`timescale 1ns/100ps
`define T_CLK 10

module tb_medicine();

integer i = 0;
  
reg clk;
reg n_rst;
reg [9:0] switches;
reg button0;
reg button_1;
wire [6:0] fnd;
wire [6:0] fnd1;
wire [6:0] fnd2;
wire [6:0] fnd3;
wire alarm;
wire txd;

initial begin
    clk = 1'b1;
    n_rst = 1'b0;
    button0 = 1'b1;
    button_1 = 1'b1;
    switches = 10'b00_0000_0000;
    #(`T_CLK * 2.2) n_rst = ~n_rst;
end

always #(`T_CLK/2) clk = ~clk;

initial begin
  wait (n_rst == 1'b1);
  #(`T_CLK) button0 = 1'b0;
  #(`T_CLK) button0 = 1'b1;
  #(`T_CLK * 2) switches = 10'b0000000001;

  #(`T_CLK * 10);

  for(i=0; i<5; i=i+1) begin
    #(`T_CLK) button_1 = 0;
    #(`T_CLK) button_1 = 1;
  end
    
  #(`T_CLK) switches = 10'b0000000010;

  #(`T_CLK * 10);
    
  for(i=0; i<7; i=i+1) begin
    #(`T_CLK) button_1 = 0;
    #(`T_CLK) button_1 = 1;
  end

  #(`T_CLK * 5) button0 = 1'b0;
  #(`T_CLK) button0 = 1'b1;
  
  #(`T_CLK * 10);
  
  for(i=0; i<4; i=i+1) begin
    #(`T_CLK) button_1 = 0;
    #(`T_CLK) button_1 = 1;
  end

  #(`T_CLK * 10) $stop;
end
  
medicine umedicine (
    .clk(clk),
    .n_rst(n_rst),
    .switches(switches),
    .button0(button0),
    .button_1(button_1),
    .fnd(fnd),
    .fnd1(fnd1),
    .fnd2(fnd2),
    .fnd3(fnd3),
    .alarm(alarm),
    .txd(txd)
);

endmodule
