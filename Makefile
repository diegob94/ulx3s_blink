
program: ulx3s.bit
	openFPGALoader -b ulx3s ulx3s.bit

.PHONY: clean
clean:
	rm -rf blinky.json ulx3s_out.config ulx3s.bit blinky_netlist.v

ulx3s.bit: ulx3s_out.config
	ecppack ulx3s_out.config ulx3s.bit

ulx3s_out.config: blinky.json
	nextpnr-ecp5 --package CABGA381 --85k --json blinky.json \
		--lpf ulx3s_v20.lpf \
		--textcfg ulx3s_out.config 

blinky.json: blinky.ys blinky.v
	yosys blinky.ys

