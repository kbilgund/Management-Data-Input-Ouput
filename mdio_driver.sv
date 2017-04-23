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
      repeat(200) @(mdio_vif.tb_clk); // master should generate the clk , min 400ns as per wiki 
        mdio_vif.clk = 1;
      repeat(200) @(mdio_vif.tb_clk);
        mdio_vif.clk = 0;
   end
endtask: run_phase

task mdio_read(input bit [4:0] phy_addr, input bit [4:0] reg_addr, output bit [15:0] data);
  
  @(posedge mdio_vif.clk);
  mdio_vif.data <= 0; // start pulse 
  @(posedge mdio_vif.clk);
  mdio_vif.data <= 1;
  
  @(posedge mdio_vif.clk);
  mdio_vif.data <= 1; // read code 
  @(posedge mdio_vif.clk);
  mdio_vif.data <= 0;

  
endtask 

task mdio_write(input bit [4:0] phy_addr, input bit [4:0] reg_addr, input [15:0] data);
    
  mdio_vif.data <= 0; // start pulse 
  @(posedge mdio_vif.clk);
  mdio_vif.data <= 1;
  
  @(posedge mdio_vif.clk);
  mdio_vif.data <= 0; // write code 
  @(posedge mdio_vif.clk);
  mdio_vif.data <= 1;
  
endtask


endclass: mdio_driver
