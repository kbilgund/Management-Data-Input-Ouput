class mdio_driver extends uvm_driver;

`uvm_component_utils(mdio_driver)


virtual mdio_if mdio_vif;

function new(string name = "mdio_driver", uvm_component parent = null);
  super.new(name, parent);
endfunction

task run_phase(uvm_phase phase);
  forever
    begin         
      repeat(5) @(mdio_vif.tb_clk); // master should generate the clk , min 400ns as per wiki 
        mdio_vif.clk = 1;
      repeat(5) @(mdio_vif.tb_clk);
        mdio_vif.clk = 0;
   end
endtask: run_phase

task mdio_read(input bit [4:0] phy_addr, input bit [4:0] reg_addr, output bit [15:0] data);
  
  @(negedge mdio_vif.clk);
  mdio_vif.data <= 0; // start pulse 
  
  @(negedge mdio_vif.clk);
  mdio_vif.data <= 1;
  
  @(negedge mdio_vif.clk);
  mdio_vif.data <= 1; // read code 
  @(negedge mdio_vif.clk);
  mdio_vif.data <= 0;
 
  repeat(2)@(posedge mdio_vif.clk);
  mdio_vif.data <= 1'bz;
  
  for(int i=0;i<16;i++)begin 
     @(posedge mdio_vif.clk);
    data[16-i-1] = mdio_vif.data;
  end 
  
  
endtask 

task mdio_write(input bit [4:0] phy_addr, input bit [4:0] reg_addr, input [15:0] data);
  $display("TB write request = %h",{phy_addr,reg_addr,data});
   
  @(negedge mdio_vif.clk);
  mdio_vif.data <= 0; // start pulse 

  @(negedge mdio_vif.clk);
  mdio_vif.data <= 1;

  @(negedge mdio_vif.clk);
  mdio_vif.data <= 0; // write code 

  @(negedge mdio_vif.clk);
  mdio_vif.data <= 1;
  
  for(int i=0 ; i < 5; i++)begin 
    @(negedge mdio_vif.clk);
    mdio_vif.data <= phy_addr[5-i-1];
  end 
  
  for(int i=0 ; i < 5; i++)begin 
    @(negedge mdio_vif.clk);
    mdio_vif.data <= reg_addr[5-i-1];
  end 
  
  @(negedge mdio_vif.clk);
  mdio_vif.data <= 1; // end pulse 

  @(negedge mdio_vif.clk);
  mdio_vif.data <= 0;
  
  for(int i=0 ; i < 16; i++)begin  // data 
    @(negedge mdio_vif.clk);
    mdio_vif.data <= data[16-i-1];
  end 
  
   mdio_vif.data <= 1'bz;
  
endtask


endclass: mdio_driver
