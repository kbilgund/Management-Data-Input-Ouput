module mdio (clk, reset,data); // currently using mdio model 
  input      clk;
  input      reset;
  inout      data;
  reg [25:0] parallel_data;
  reg start_detected;
  wire data;
  reg write_en;
  reg write_data;
  
  //reg        [16:0] data;
 // reg        [1:0] state; // 0:idle 1:read 2:write 3:error 
  
  assign data = write_en ? write_data : 1'bz;
  
  always @(posedge clk or posedge reset)
  begin
    if (reset) begin
      parallel_data <= 0;
      start_detected <= 0 ;
      write_en <=0;
    end 
    else begin
      parallel_data <= {parallel_data[24:0] , data};
      if(parallel_data[1:0]==2'b1)begin 
        if(start_detected == 0)
          start_detected <= 1;
      end 
      
      $display("DUT %h",data);
    end
  end
endmodule
