transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/joserodriguez/basicblocks/aip {/home/joserodriguez/basicblocks/aip/aipModules.v}
vlog -vlog01compat -work work +incdir+/home/joserodriguez/basicblocks/memories {/home/joserodriguez/basicblocks/memories/simple_dual_port_ram_single_clk.v}
vlog -vlog01compat -work work +incdir+/home/joserodriguez/basicblocks/ipm {/home/joserodriguez/basicblocks/ipm/ipm_register.v}
vlog -vlog01compat -work work +incdir+/home/joserodriguez/basicblocks/ipm {/home/joserodriguez/basicblocks/ipm/ipm.v}
vlog -vlog01compat -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src/ID1000500B_aip.v}
vlog -vlog01compat -work work +incdir+/home/joserodriguez/basicblocks/sequential {/home/joserodriguez/basicblocks/sequential/convolution_coprocessor_register.v}
vlog -vlog01compat -work work +incdir+/home/joserodriguez/basicblocks/arithmetic {/home/joserodriguez/basicblocks/arithmetic/convolution_coprocessor_realAdder.v}
vlog -vlog01compat -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src/ID1000500B_convolution_coprocessor.v}
vlog -vlog01compat -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src/ipm_ID1000500B_convolution_coprocessor.v}
vlog -sv -work work +incdir+/home/joserodriguez/basicblocks/memories {/home/joserodriguez/basicblocks/memories/convolution_coprocessor_simple_rom_sv.sv}
vlog -sv -work work +incdir+/home/joserodriguez/basicblocks/arithmetic {/home/joserodriguez/basicblocks/arithmetic/convolution_coprocessor_comparatorLessThan.sv}
vlog -sv -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src/convolution_coprocessor_substractor.sv}
vlog -sv -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src/convolution_coprocessor_not.sv}
vlog -sv -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src/convolution_coprocessor_mux.sv}
vlog -sv -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src/convolution_coprocessor_mult.sv}
vlog -sv -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src/convolution_coprocessor_fsm.sv}
vlog -sv -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src/convolution_coprocessor_and.sv}
vlog -sv -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/src/ID1000500B_convolution_coprocessor_core.sv}

vlog -vlog01compat -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../simulation {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../simulation/ID1000500BTB.v}
vlog -sv -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src/convolution_coprocessor.sv}
vlog -sv -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src/convolution_coprocessor_and.sv}
vlog -sv -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src/convolution_coprocessor_fsm.sv}
vlog -sv -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src/convolution_coprocessor_mult.sv}
vlog -sv -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src/convolution_coprocessor_mux.sv}
vlog -sv -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src/convolution_coprocessor_not.sv}
vlog -sv -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src/convolution_coprocessor_substractor.sv}
vlog -vlog01compat -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src/ID1000500B_aip.v}
vlog -vlog01compat -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src/ID1000500B_convolution_coprocessor.v}
vlog -sv -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src/ID1000500B_convolution_coprocessor_core.sv}
vlog -vlog01compat -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../src/ipm_ID1000500B_convolution_coprocessor.v}
vlog -sv -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../../../basicblocks/arithmetic {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../../../basicblocks/arithmetic/convolution_coprocessor_comparatorLessThan.sv}
vlog -vlog01compat -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../../../basicblocks/arithmetic {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../../../basicblocks/arithmetic/convolution_coprocessor_realAdder.v}
vlog -vlog01compat -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../../../basicblocks/ipm {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../../../basicblocks/ipm/ipm.v}
vlog -vlog01compat -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../../../basicblocks/ipm {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../../../basicblocks/ipm/ipm_register.v}
vlog -sv -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../../../basicblocks/memories {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../../../basicblocks/memories/convolution_coprocessor_simple_rom_sv.sv}
vlog -vlog01compat -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../../../basicblocks/memories {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../../../basicblocks/memories/simple_dual_port_ram_single_clk.v}
vlog -vlog01compat -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../../../basicblocks/sequential {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../../../basicblocks/sequential/convolution_coprocessor_register.v}
vlog -vlog01compat -work work +incdir+/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../../../basicblocks/aip {/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/hdl/quartus_project/../../../basicblocks/aip/aipModules.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  ID1000500BTB

add wave *
view structure
view signals
run 10 us
