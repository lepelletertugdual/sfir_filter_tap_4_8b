-- #################################################################################################################################################################################
-- file :
--     sfir_filter_4.vhd
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- objective :
--     symetrical FIR filter with 4 taps hardware implementation
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- level of description :
--     register tranfer level (RTL)
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- limitation :
--     clock ratio must be higher or equal to 16.
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- author :
--     Tugdual LE PELLETER
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- history :
--     2024-10-19
--         file creation
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- table of contents :
--     01. libraries
--     02. entity
--     03. architecture
--         03.01. constants
--         03.02. types
--         03.03. signals
--         03.04. input assignment
--         03.05. coefficient assignment
--         03.06. delay line
--         03.07. stage 0 : adder
--         03.08. stage 1 : multiplier
--         03.09. stage 2 : adder
--         03.10. stage 3 : adder
--         03.11. output assignment 
-- #################################################################################################################################################################################

-- #################################################################################################################################################################################
-- 01. libraries
-- #################################################################################################################################################################################
    -- =============================================================================================================================================================================
	-- 01.01. standard
    -- =============================================================================================================================================================================
    library ieee;
        use ieee.std_logic_1164.all;
	    use ieee.numeric_std.all;
	    use ieee.math_real.all;

    -- =============================================================================================================================================================================
	-- 01.01. custom
    -- =============================================================================================================================================================================	
       -- none
	
-- #################################################################################################################################################################################
-- 02. entity
-- #################################################################################################################################################################################

entity sfir_filter_4 is
    generic (
	     g_h0 : std_logic_vector(7 downto 0)
	    ;g_h1 : std_logic_vector(7 downto 0)
	    ;g_h2 : std_logic_vector(7 downto 0)
	    ;g_h3 : std_logic_vector(7 downto 0)
	);
    port (
	     i_clk : in  std_logic
		;i_rst : in  std_logic
		;i_x   : in  std_logic_vector(7 downto 0)
		;o_y   : out std_logic_vector(9 downto 0)
	);
end entity sfir_filter_4;

-- #################################################################################################################################################################################
-- 03. architecture
-- #################################################################################################################################################################################

architecture rtl of sfir_filter_4 is

    -- =============================================================================================================================================================================
	-- 03.01. constants
    -- =============================================================================================================================================================================
        -- none

    -- =============================================================================================================================================================================
	-- 03.02. types
    -- =============================================================================================================================================================================
    type t_data_pipe     is array(0 to 7) of signed( 7 downto 0);
	type t_coeff         is array(0 to 3) of signed( 7 downto 0);
	type t_adder_stage_0 is array(0 to 3) of signed( 8 downto 0);
	type t_multi_stage_1 is array(0 to 3) of signed(17 downto 0);
	type t_adder_stage_2 is array(0 to 1) of signed(18 downto 0);

    -- =============================================================================================================================================================================
	-- 03.03. signals
    -- =============================================================================================================================================================================
	signal s_clk       : std_logic;
	signal s_rst       : std_logic;
	signal s_data_pipe : t_data_pipe;
	signal s_data      : signed(7 downto 0); 
	signal s_h         : t_coeff;
	signal s_a         : t_adder_stage_0; --  9 bits
	signal s_m         : t_multi_stage_1; -- 18 bits
	signal s_b         : t_adder_stage_2; -- 19 bits
	signal s_y         : signed(19 downto 0);
	
begin

    -- =============================================================================================================================================================================
	-- 03.04. input assignment
    -- =============================================================================================================================================================================
	s_clk  <= i_clk;
	s_rst  <= i_rst;
    s_data <= signed(i_x);

    -- =============================================================================================================================================================================
	-- 03.05. coefficient assignment
    -- =============================================================================================================================================================================
    p_coef_assignment : process(s_clk,s_rst)
	begin
	    if (s_rst = '1') then
            s_h <= (others => (others => '0'));
		elsif (rising_edge(s_clk)) then
            s_h(0) <= signed(g_h0);
            s_h(1) <= signed(g_h1);
            s_h(2) <= signed(g_h2);
            s_h(3) <= signed(g_h3);
		end if;
	end process p_coef_assignment; 

    -- =============================================================================================================================================================================
	-- 03.06. delay line
    -- =============================================================================================================================================================================
    p_delay_line : process(s_clk,s_rst)
	begin
	    if (s_rst = '1') then
		    s_data_pipe <= (others => (others => '0'));
		elsif (rising_edge(s_clk)) then
            s_data_pipe <= s_data & s_data_pipe(0 to s_data_pipe'length-2);
		end if;
	end process p_delay_line; 

    -- =============================================================================================================================================================================
	-- 03.07. stage 0 : adder
    -- =============================================================================================================================================================================
    p_stage_0_adder : process(s_clk,s_rst)
	begin
	    if (s_rst = '1') then
            s_a(0) <= (others => '0');
            s_a(1) <= (others => '0');
            s_a(2) <= (others => '0');
            s_a(3) <= (others => '0');
		elsif (rising_edge(s_clk)) then
			s_a(0) <= resize(s_data_pipe(0),9) +  resize(s_data_pipe(7),9);
			s_a(1) <= resize(s_data_pipe(1),9) +  resize(s_data_pipe(6),9);
			s_a(2) <= resize(s_data_pipe(2),9) +  resize(s_data_pipe(5),9);
			s_a(3) <= resize(s_data_pipe(3),9) +  resize(s_data_pipe(4),9);
		end if;
	end process p_stage_0_adder;

    -- =============================================================================================================================================================================
	-- 03.08. stage 1 : multiplier
    -- =============================================================================================================================================================================
    p_stage_2_multiplier : process(s_clk,s_rst)
	begin
	    if (s_rst = '1') then
           s_m <= (others => (others => '0'));
		elsif (rising_edge(s_clk)) then
           for i in 0 to 3 loop
		       s_m(i) <= resize(s_h(i),9) * s_a(i);
           end loop;		   
		end if;
	end process p_stage_2_multiplier;
	
    -- =============================================================================================================================================================================
	-- 03.09. stage 2 : adder
    -- =============================================================================================================================================================================
    p_stage_2_adder : process(s_clk,s_rst)
	begin
	    if (s_rst = '1') then
            s_b <= (others => (others => '0'));
		elsif (rising_edge(s_clk)) then
		    for i in 0 to 1 loop
                s_b(i) <= resize(s_m(2*i),19) + resize(s_m(2*i+1),19);
			end loop;
		end if;
	end process p_stage_2_adder;	

    -- =============================================================================================================================================================================
	-- 03.10. stage 3 : adder
    -- =============================================================================================================================================================================
    p_stage_3_adder : process(s_clk,s_rst)
	begin
	    if (s_rst = '1') then
            s_y <= (others => '0');
		elsif (rising_edge(s_clk)) then
            s_y <= resize(s_b(0),20) + resize(s_b(1),20);
		end if;
	end process p_stage_3_adder;	

    -- =============================================================================================================================================================================
	-- 03.11. output assignment
    -- =============================================================================================================================================================================
    o_y <= std_logic_vector(s_y(s_y'high downto s_y'high-9));
   
end architecture rtl;

-- #################################################################################################################################################################################
-- EOF
-- #################################################################################################################################################################################