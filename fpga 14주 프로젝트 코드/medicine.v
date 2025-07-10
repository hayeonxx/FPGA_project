module medicine (
  input clk,
  input n_rst,
  input [9:0] switches,
  input button0,
  input button_1,
  output [6:0] fnd,
  output [6:0] fnd1,
  output [6:0] fnd2,
  output [6:0] fnd3,
  output reg alarm,
  output txd
);


  reg [9:0] count0;
  reg [9:0] count1;
  reg [9:0] count2;
  reg [9:0] count3;
  reg [9:0] count4;
  reg [9:0] count5;
  reg [9:0] count6;
  reg [9:0] count7;
  reg [9:0] count8;
  reg [9:0] count9;
  reg mode;
  reg [9:0] selected_switches;
  reg button0_prev;
  reg [9:0] fnd1_val;
  reg [7:0] sum;
  wire button1;
  wire [7:0]tx_data;
  wire [7:0]tx_data_sw;
  wire txen;

  detection u_detection (//chochocho
    .clk(clk),
    .n_rst(n_rst),
    .d(button_1),
    .tick(button1)

);


  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
      alarm <= 1'b0;
      mode <= 1'b0;
      selected_switches <= 10'h0;
      count0 <= 10'h0;
      count1 <= 10'h0;
      count2 <= 10'h0;
      count3 <= 10'h0;
      count4 <= 10'h0;
      count5 <= 10'h0;
      count6 <= 10'h0;
      count7 <= 10'h0;
      count8 <= 10'h0;
      count9 <= 10'h0;
      button0_prev <= 1'b1;
      fnd1_val <= 10'h0;
      sum <= 8'b0;
    end else begin
      if (!button0 && !button0_prev) begin
        mode <= ~mode;
        if (mode) begin
        end
   end else if (button1 == 1'b1 && (selected_switches != 10'b0000000000)) begin
   if (mode) begin
      case (selected_switches)
      10'b0000000001: if (count0 < 10'h9) count0 <= count0 + 1;
      10'b0000000010: if (count1 < 10'h9) count1 <= count1 + 1;
      10'b0000000100: if (count2 < 10'h9) count2 <= count2 + 1;
      10'b0000001000: if (count3 < 10'h9) count3 <= count3 + 1;
      10'b0000010000: if (count4 < 10'h9) count4 <= count4 + 1;
      10'b0000100000: if (count5 < 10'h9) count5 <= count5 + 1;
      10'b0001000000: if (count6 < 10'h9) count6 <= count6 + 1;
      10'b0010000000: if (count7 < 10'h9) count7 <= count7 + 1;
      10'b0100000000: if (count8 < 10'h9) count8 <= count8 + 1;
      10'b1000000000: if (count9 < 10'h9) count9 <= count9 + 1;
    endcase
  end else if (~mode) begin
    case (selected_switches)
      10'b0000000001: if (count0 > 10'h0) count0 <= count0 - 1;
      10'b0000000010: if (count1 > 10'h0) count1 <= count1 - 1;
      10'b0000000100: if (count2 > 10'h0) count2 <= count2 - 1;
      10'b0000001000: if (count3 > 10'h0) count3 <= count3 - 1;
      10'b0000010000: if (count4 > 10'h0) count4 <= count4 - 1;
      10'b0000100000: if (count5 > 10'h0) count5 <= count5 - 1;
      10'b0001000000: if (count6 > 10'h0) count6 <= count6 - 1;
      10'b0010000000: if (count7 > 10'h0) count7 <= count7 - 1;
      10'b0100000000: if (count8 > 10'h0) count8 <= count8 - 1;
      10'b1000000000: if (count9 > 10'h0) count9 <= count9 - 1;

    endcase
  end
end

      alarm <= (mode);
      button0_prev <= !button0;
      //button0_prev2 <= button0_prev;
		selected_switches <= switches;
      
      case (selected_switches)
        10'b0000000001: fnd1_val <= count0;
        10'b0000000010: fnd1_val <= count1;
        10'b0000000100: fnd1_val <= count2;
        10'b0000001000: fnd1_val <= count3;
        10'b0000010000: fnd1_val <= count4;
        10'b0000100000: fnd1_val <= count5;
        10'b0001000000: fnd1_val <= count6;
        10'b0010000000: fnd1_val <= count7;
        10'b0100000000: fnd1_val <= count8;
        10'b1000000000: fnd1_val <= count9;
      default fnd1_val <= 10'h0;      
      endcase



      sum <= count0+count1+count2+count3+count4+count5+count6+count7+count8+count9;
	 end
  end

gen_en u_gen_en(
    .clk(clk),
    .n_rst(n_rst),
    .txen(txen)
);




asccon u_asccon(
  .tx_data(fnd1_val),
  .ascii_data(tx_data)
);


wire txd_in;

  tx u_tx (
    .clk(clk),
    .n_rst(n_rst),
    .tx_data(tx_data),  // Concatenate fnd and fnd1 values
    .txen(txen),  // Use button1 as transmitter enable
    .load(button1),  // Ignore load input
    .txd(txd_in)
  );


  assign txd = !txd_in;
  fnd u_fnd(
    .inp(switches),
    .seg(fnd)
  );

  fnd1 u_fnd1(
    .inp(fnd1_val),
    .seg(fnd1)
  );
  fnd1 u_fnd2(
    .inp(sum % 10),
    .seg(fnd2)
  );

  fnd1 u_fnd3(
    .inp(sum / 10),
    .seg(fnd3)
  );

endmodule