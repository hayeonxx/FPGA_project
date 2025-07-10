module fnd  (//chochochocho
	inp,
	seg
);


input	      [9:0] inp;
output	reg [6:0]	seg;


always @(*)
begin
		case(inp)
		10'd0: seg = 7'b1000000;
		10'd1: seg = 7'b1111001;	
		10'd2: seg = 7'b0100100; 
		10'd4: seg = 7'b0110000; 	
		10'd8: seg = 7'b0011001; 	
		10'd16: seg = 7'b0010010; 
		10'd32: seg = 7'b0000010; 	
		10'd64: seg = 7'b1111000; 	
		10'd128: seg = 7'b0000000; 	
		10'd256: seg = 7'b0011000;
		10'd512: seg = 7'b0001000;		
		endcase
		
end

/*
input	      [3:0] inp;
output	reg [6:0]	seg;
always @(*)
begin
		case(inp)
		4'h1: seg = 7'b1111001;	
		4'h2: seg = 7'b0100100; //0x24
		4'h3: seg = 7'b0110000; //0x30	
		4'h4: seg = 7'b0011001; 	
		4'h5: seg = 7'b0010010; 
		4'h6: seg = 7'b0000010; 	
		4'h7: seg = 7'b1111000; 	
		4'h8: seg = 7'b0000000; 	
		4'h9: seg = 7'b0011000; 	
		4'ha: seg = 7'b0001000;  //A
		4'hb: seg = 7'b0000011;  //b
		4'hc: seg = 7'b1000110;  //C
		4'hd: seg = 7'b0100001;  //d
		4'he: seg = 7'b0000110;  //E
		4'hf: seg = 7'b0001110;  //F
		4'h0: seg = 7'b1000000;  //0	//0x40
		endcase
end*/
endmodule

