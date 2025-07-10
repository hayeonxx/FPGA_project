module asccon(
  input [7:0] tx_data,
  output reg [7:0] ascii_data
);

  always @(tx_data) begin
    case (tx_data)
      10'h0: ascii_data <={1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0};  // '0'
      10'h1: ascii_data <={1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1};  // '1'
      10'h2: ascii_data <= {1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0};  // '2'
      10'h3: ascii_data <= {1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1};  // '3'
      10'h4: ascii_data <= {1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0};  // '4'
      10'h5: ascii_data <= {1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1};  // '5'
      10'h6: ascii_data <={1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b0} ;  // '6'
      10'h7: ascii_data <= {1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1};  // '7'
      10'h8: ascii_data <= {1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0};  // '8'
      10'h9: ascii_data <={1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1} ;  // '9'
      default: ascii_data <= {1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0};  // Default value if tx_data is out of range
    endcase
  end

endmodule
