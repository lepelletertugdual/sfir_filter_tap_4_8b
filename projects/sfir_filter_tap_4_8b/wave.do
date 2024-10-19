onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /bch_sfir_filter_4/inst_sfir_filter_4/i_clk
add wave -noupdate /bch_sfir_filter_4/inst_sfir_filter_4/i_rst
add wave -noupdate /bch_sfir_filter_4/inst_sfir_filter_4/i_x
add wave -noupdate /bch_sfir_filter_4/inst_sfir_filter_4/o_y
add wave -noupdate /bch_sfir_filter_4/inst_sfir_filter_4/s_clk
add wave -noupdate /bch_sfir_filter_4/inst_sfir_filter_4/s_rst
add wave -noupdate /bch_sfir_filter_4/inst_sfir_filter_4/s_data_pipe
add wave -noupdate /bch_sfir_filter_4/inst_sfir_filter_4/s_data
add wave -noupdate /bch_sfir_filter_4/inst_sfir_filter_4/s_h
add wave -noupdate /bch_sfir_filter_4/inst_sfir_filter_4/s_a
add wave -noupdate /bch_sfir_filter_4/inst_sfir_filter_4/s_m
add wave -noupdate /bch_sfir_filter_4/inst_sfir_filter_4/s_b
add wave -noupdate /bch_sfir_filter_4/inst_sfir_filter_4/s_y
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {986 ps}
