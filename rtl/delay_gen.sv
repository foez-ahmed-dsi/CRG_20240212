module delay_gen #(
    parameter count_range=128
)(
    input  logic                  clk,
    input  logic                  arst_n,
    output logic                  out
);

	// TODO: REWRITE
    logic [$clog(n+1)-1:0] count;
    always_comb begin 
        en=~out;
    end

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            count<= 0;
            out  <= 0;
        end else begin
			if(count+1 == count_range) begin
                count <= count + 1; 
            end else begin
                out <= 1;
            end
        end
    end
	
endmodule
