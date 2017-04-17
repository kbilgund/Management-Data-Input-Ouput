class mdio_driver extends uvm_driver #(mdio_seq_item);

`uvm_component_utils(mdio_driver)

mdio_seq_item req;

virtual mdio_if mdio_vif;

function new(string name = "mdio_driver", uvm_component parent = null);
  super.new(name, parent);
endfunction

task run_phase(uvm_phase phase);
  forever
    begin         
      repeat(200) @top.clk; // clk generation 400ns max period 
        mdio_vif.clk = 1;
      repeat(200) @top.clk;
        mdio_vif.clk = 0;
   end
endtask: run_phase

task mdio_read(input bit [8:0] phy_addr, input bit [15:0] reg_addr, output bit [31:0] data);
endtask 

task mdio_write(input bit [8:0] phy_addr, input bit [15:0] reg_addr, input [31:0] data);
endtask


endclass: mdio_driver
