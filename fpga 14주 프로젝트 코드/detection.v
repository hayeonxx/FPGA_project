
`timescale 1ns/1ps
module detection (//chochochoCHO
    clk,
    n_rst,
    d,
    tick

);

input clk;
input n_rst;
input d;
output  tick;


    reg d_d1;
    reg d_d2;
    
always @(posedge clk or negedge n_rst)
    if(!n_rst) begin
        d_d1 <= 1'b1;
        d_d2 <= 1'b1;
    end
    else begin
        d_d1 <= d;
        d_d2 <= d_d1;    
    end


assign tick = ((d_d1 == 1'b0)&&(d_d2 == 1'b1))? 1'b1 : 1'b0;


    
endmodule

