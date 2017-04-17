// kbilgund 
// components needed 
// 1. Dut instance 
// 2. interface 
// 3. clock generation 

module top;
import uvm_pkg::*;
  initial
  begin
    run_test();
  end
  
  initial begin // clock generation for tb 
    clk = 0 ;
    forever begin
    #1ns clk = ~clk ;
    end 
  end 
  
endmodule 
