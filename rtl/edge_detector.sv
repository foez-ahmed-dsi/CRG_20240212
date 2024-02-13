module edge_detector (

	input logic global_rst,
	input logic arst_req_a,
	input logic clk_ref,
	output logic edge_out


	);
  
	logic q1,q2;
  
	always_ff @ (posedge clk_ref)
    
	begin
		q1<= global_rst && ~arst_req_a;
		q2<= ~{(global_rst && ~arst_req_a) ||(~q1)};
      
 	end
	
	assign edge_out=~q2;
  
endmodule
