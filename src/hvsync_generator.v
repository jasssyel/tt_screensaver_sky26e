`timescale 1ns / 1ps
`default_nettype none

module hvsync_generator (
    input wire clk,
    input wire reset,

    output reg hsync,
    output reg vsync,
    output wire display_on,

    output reg [9:0] hpos,
    output reg [9:0] vpos
);

    always @(posedge clk) begin
        if (reset) begin
            hpos <= 10'd0;
            vpos <= 10'd0;
        end
        else begin

            if (hpos == 10'd799) begin
                hpos <= 10'd0;

                if (vpos == 10'd524)
                    vpos <= 10'd0;
                else
                    vpos <= vpos + 10'd1;

            end
            else begin
                hpos <= hpos + 10'd1;
            end
        end
    end

    assign display_on =
        (hpos < 10'd640) &&
        (vpos < 10'd480);

    always @(*) begin
        if ((hpos >= 10'd656) &&
            (hpos < 10'd752))
            hsync = 1'b0;
        else
            hsync = 1'b1;
    end

    always @(*) begin
        if ((vpos >= 10'd490) &&
            (vpos < 10'd492))
            vsync = 1'b0;
        else
            vsync = 1'b1;
    end

endmodule

`default_nettype wire
