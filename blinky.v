module top(input clk_25mhz,
           input [6:0] btn,
           output [7:0] led,
           output wifi_gpio0);

    wire i_clk;

    // Tie GPIO0, keep board from rebooting
    assign wifi_gpio0 = 1'b1;
    assign i_clk= clk_25mhz;
    reg [7:0] o_led;
    assign led = o_led;

    localparam ctr_width = 21;
    reg [ctr_width-1:0] ctr = 0;

    wire pulse = ctr[ctr_width-1];
    reg last_pulse;

    integer i;
    always @(posedge i_clk) begin
        ctr <= ctr + 1;
        last_pulse <= pulse;
        if(!btn[0])
            o_led <= 8'b1;
        else if(!last_pulse && pulse) begin
            o_led[0] <= o_led[7];
            for(i = 0; i<7; i++)
                o_led[i+1] <= o_led[i];
        end
    end

endmodule
