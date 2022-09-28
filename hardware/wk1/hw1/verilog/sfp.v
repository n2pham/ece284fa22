// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module sfp (out, in, thres, acc, relu, clk, reset);

parameter bw = 4;
parameter psum_bw = 16;

input clk;
input acc;
input relu;
input reset;

input signed [bw-1:0] in;
input signed [psum_bw-1:0] thres;

output  signed [psum_bw-1:0] out;

reg  signed [psum_bw-1:0] psum_q;


assign out = psum_q;           // Assign psum_q to out at the next clock edge

always @ (posedge clk) begin
        if(reset) begin              // Synchronous Reset 
            psum_q <= '0;
        end
        else if (acc) begin          // When acc == 1, psum_q will increment by in
            psum_q <= psum_q + in;
        end
        else if (relu && psum_q < thres) begin  // When relu == 1 and psum_q < thres, set psum_q to 0
            psum_q <= '0;
        end
        else begin                        // If none of the cases then set to same value
            psum_q <= psum_q;
	end
end

endmodule
