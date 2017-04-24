// kbilgund 
// components needed 
// 1. Dut instance 
// 2. interface 
// 3. tb clock generation , master clk will be from driver 

module top_tb;

import uvm_pkg::*;
import mdio_pkg::*;
  reg tb_clk;
  mdio_if mdio_if_0();
  mdio mdio_inst();
  

 // assign mdio_if_0.clk = clk; // driver needs to generate the clk as per wiki
                              // add a frequency divider logic in driver for clk generation. min clk period: 400ns 
  
  assign mdio_inst.clk  = mdio_if_0.clk;
  assign mdio_inst.data = mdio_if_0.data;
  pullup (mdio_inst.data); // since it is bidirectional pin
  pullup (mdio_if_0.data);
  assign mdio_if_0.tb_clk = tb_clk;
  assign mdio_inst.reset = mdio_if_0.reset;
  
  initial
  begin
    uvm_config_db #(virtual mdio_if)::set(null, "*", "mdio_vif" , mdio_if_0);
    run_test("mdio_test");
  end
  
  initial begin // clock generation for tb 
    tb_clk = 0 ;
    forever begin
    #0.5ns tb_clk = ~ tb_clk ; // 1ns clock period 
    end 
  end 


  initial begin 
    $dumpvars(0, top_tb);
    #1000;
    $finish;
  end 
endmodule: top_tb
