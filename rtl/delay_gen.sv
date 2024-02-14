///////////////////////////////////////////////////////////////////////////////
//Author: Md Nazmus Sakib
//This is a delay generator which is constructed using counter
///////////////////////////////////////////////////////////////////////////////
module delay_gen #(
    parameter count_range=128
)(
    input  logic                  clk,
    input  logic                  arst_n,
    output logic                  out
);

	// TODO: REWRITE
    logic [$clog(n+1)-1:0] count;
    logic                  en;
    
    assign out=(count+1==count_range);
    assign en=~out;



    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            count<= 0;
        end else begin
			if(en) begin
                count <= count + 1; 
            end
        end
    end
	
endmodule
