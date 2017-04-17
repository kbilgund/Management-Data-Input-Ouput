// kbilgund 
// components needed 
// 1. Dut instance 
// 2. interface 
// 3. clock generation 

module top;
import uvm_pkg::*;
  wire clk;
  mdio_if mdio_if_0;
  mdio mdio_inst;
  
  // temp code 
  assign mdio_if_0.clk = clk; // driver needs to generate the clk as per wiki
                              // add a divider logic in driver for clk generation. min clk period: 400ns 
  
  assign mdio_inst.clk  = mdio_if_0.clk;
  assign mdio_inst.data = mdio_if_0.data;
  pullup(mdio_inst.data); // since it is bidirectional pin
  
  initial
  begin
    uvm_config_db #(virtual mdio_if)::set(null, "uvm_test_top", "mdio_vif" , mdio_if_0);
    run_test();
  end
  
  initial begin // clock generation for tb 
    clk = 0 ;
    forever begin
    #1ns clk = ~clk ; // 2ns clock period 
    end 
  end 
  
endmodule 
