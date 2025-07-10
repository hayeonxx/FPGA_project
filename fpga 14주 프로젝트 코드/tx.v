module tx(
    input clk,        // Clock input
    input n_rst,      // Active-low reset input
    input [7:0] tx_data,  // First data input
    input [7:0] tx_data2, // Second data input
    input txen,       // Transmitter enable input
    input load,       // Load input
    output reg txd    // Transmitter data output
);

  reg [3:0] c_cnt;    // Current count
  reg [3:0] n_cnt;    // Next count
  reg [2:0] c_state;  // Current state
  reg [2:0] n_state;  // Next state

  localparam FLG = 4'h9;  // Constant value for comparison
  localparam ST0 = 3'h0;
  localparam ST1 = 3'h1;
  localparam ST2 = 3'h2;
  localparam ST3 = 3'h3;
  localparam ST4 = 3'h4;

  // Sequential logic for state and count
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
      c_state <= ST0;  // Initialize state to ST0
      c_cnt <= 4'h0;   // Initialize count to 0
    end
    else begin
      c_state <= n_state;  // Update current state with next state
      c_cnt <= n_cnt;      // Update current count with next count
    end
  end

  // Combinational logic for state transitions
  always @(load or n_cnt or txen) begin
    case (c_state)
      ST0: begin
        if (load == 1'b1)
          n_state = ST1;  // Move to ST1 if load is high
        else
          n_state = c_state;  // Stay in the current state
      end
      ST1: begin
        if (txen == 1'b1)
          n_state = ST2;  // Move to ST2 if transmitter enable is high
        else
          n_state = c_state;  // Stay in the current state
      end
      ST2: begin
        if (n_cnt == 4'h1)
          n_state = ST3;  // Move to ST3 if next count is 1
        else
          n_state = c_state;  // Stay in the current state
      end
      ST3: begin
        if (n_cnt == FLG)
          n_state = ST4;  // Move to ST4 if next count reaches the constant FLG
        else
          n_state = c_state;  // Stay in the current state
      end
      ST4: begin
        if (n_cnt == 4'h0)
          n_state = ST0;  // Move back to ST0 if next count is 0
        else
          n_state = c_state;  // Stay in the current state
      end
      default: n_state = ST0;  // Default case, move to ST0
    endcase
  end

  // Combinational logic for count transitions
  always @(txen) begin
    case (c_state)
      ST0: n_cnt = 4'h0;  // Next count is 0 in ST0
      ST1: n_cnt = c_cnt;  // Next count is the current count in ST1
      default: begin
        if (txen == 1'b0)
          n_cnt = c_cnt;  // Next count is the current count if txen is low
        else if (c_cnt == FLG)
          n_cnt = 4'h0;  // Next count is 0 if current count reaches the constant FLG
        else
          n_cnt = c_cnt + 4'h1;  // Next count is the current count plus 1
      end
    endcase
  end

  reg [7:0] tx_data_in;  // First data input buffer

  // Sequential logic for storing first data input
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst)
      tx_data_in <= 8'h00;  // Reset first data input buffer to 0
    else begin
      case (c_state)
        ST2: tx_data_in <= tx_data;  // Store the first data input in ST2
        ST3: begin
          if (txen == 1'b1)
            tx_data_in <= {1'b0, tx_data_in[7:1]};  // Shift first data input left in ST3 if txen is high
          else
            tx_data_in <= tx_data_in;  // Keep the first data input unchanged
        end
        default: tx_data_in <= 8'h00;  // Reset first data input buffer to 0 for other states
      endcase
    end
  end

  // Sequential logic for setting the transmitter output
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst)
      txd <= 1'b1;  // Initialize transmitter output to high
    else begin
      case (c_state)
        ST2: txd <= 1'b0;  // Set transmitter output to low in ST2
        ST3: begin
          if (txen == 1'b0)
            txd <= tx_data_in[0];  // Set transmitter output to the least significant bit of the first data input in ST3 if txen is low
          else
            txd <= txd;  // Keep the transmitter output unchanged
        end
        ST4: txd <= 1'b1;  // Set transmitter output to high in ST4
        default: txd <= txd;  // Keep the transmitter output unchanged for other states
      endcase
    end
  end

endmodule
