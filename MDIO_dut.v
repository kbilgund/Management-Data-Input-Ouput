module mdio (clk, reset,data); // currently using mdio model 
  input      clk;
  input      reset;
  inout      data;
  reg        [16:0] data;
 // reg        [1:0] state; // 0:idle 1:read 2:write 3:error 
  
  always @(posedge clk or posedge reset)
  begin
    if (reset) begin
      data <= 16'heeee;
    end 
    else begin
      //data <= 1'b1;
    end
  end
endmodule
