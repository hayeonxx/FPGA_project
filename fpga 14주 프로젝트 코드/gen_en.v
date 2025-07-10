module gen_en(
    clk,
    n_rst,
    txen
);

input clk;
input n_rst;

output txen;

reg txen;

localparam FLG1 = 16'h1458;

reg [15:0] c_cnt;
reg [15:0] n_cnt;

always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
        c_cnt <= 16'h0001;
    end
    else begin
        c_cnt <= n_cnt;
    end
end

always @(c_cnt) begin
    if (c_cnt == FLG1) begin
        n_cnt = 16'h0001;
    end
    else begin
        n_cnt = c_cnt + 16'h0001;
    end
end

always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
        txen <= 1'b0;
    end
    else begin
        if (c_cnt == FLG1) begin
            txen <= 1'b1;
        end
        else begin
            txen <= 1'b0;
        end
    end
end

endmodule
