transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -sv -work work +incdir+. {ipm_ID1000500B_convolution_coprocessor.svo}

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

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L altera_lnsim_ver -L cyclonev_ver -L lpm_ver -L sgate_ver -L cyclonev_hssi_ver -L altera_mf_ver -L cyclonev_pcie_hip_ver -L gate_work -L work -voptargs="+acc"  ID1000500BTB

add wave *
view structure
view signals
run 10 us
