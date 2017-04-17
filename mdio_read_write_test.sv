class mdio_test extends uvm_test;

`uvm_component_utils(mdio_test)


function new(string name = "mdio_test", uvm_component parent = null);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
 
endfunction: build_phase

function void connect_phase(uvm_phase phase);

endfunction: connect_phase

task run_phase(uvm_phase phase);

endtask: run_phase

endclass: mdio_test
