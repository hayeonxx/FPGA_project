module fnd1  (//chochochocho
	inp,
	seg
);

input	      [9:0] inp;
output	reg [6:0]	seg;

always @(*)
begin
		case(inp)
		10'h0: seg = 7'b1000000;  //0	//0x40	
		10'h1: seg = 7'b1111001;	
		10'h2: seg = 7'b0100100; //0x24
		10'h3: seg = 7'b0110000; //0x30	
		10'h4: seg = 7'b0011001; 	
		10'h5: seg = 7'b0010010; 
		10'h6: seg = 7'b0000010; 	
		10'h7: seg = 7'b1111000; 	
		10'h8: seg = 7'b0000000; 	
		10'h9: seg = 7'b0011000;
		endcase
end
endmodule

