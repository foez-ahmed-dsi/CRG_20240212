module delaygen #(
    parameter count_range=128
)(
    input  logic                  clk,
    input  logic                  rst,
    input logic                   en,
    output logic                  out
);
  
  logic [$clog(n+1)-1:0] count
  always_ff @(posedge clk or negedge rst) begin
    if (rst) 
        count<= 0;
	out  <= 0;
	en<=0;
    else begin
    	if(count< count_range) begin
count <= count + 1; 
      end else begin
		out<=1;
		en <=0;

      end
endmodule
