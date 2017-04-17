class mdio_test extends uvm_test;

`uvm_component_utils(mdio_test)
 mdio_env mdio_env_0;

function new(string name = "mdio_test", uvm_component parent = null);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  mdio_env_0 = mydio_env::type_id::create("mdio_env_0", this)
endfunction: build_phase

function void connect_phase(uvm_phase phase);

endfunction: connect_phase

task run_phase(uvm_phase phase);
  bit [4:0]  phy_addr;
  bit [4:0]  reg_addr;
  bit [15:0] read_data;
  bit [15:0] write_data;
  repeat(10)begin 
    phy_addr   = $urandom_range(0,5); // depends on number of slave  assume 5 slaves 
    reg_addr   = $urandom();
    write_data = $urandom();
    mdio_env_0.mdio_write(phy_addr,reg_addr,write_data);
    mdio_env_0.mdio_read(phy_addr,reg_addr,read_data);
    if(read_data != write_data)
      `uvm_error("MDIO_TEST", "Random write data != read data")
  end 
endtask: run_phase

endclass: mdio_test
