class mdio_env extends uvm_env;

    `uvm_component_utils(mdio_env)
   
    mdio_driver    mdio_driv_0;
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
 
    function void build_phase(uvm_phase phase);
      mdio_driv_0 = mdio_driver::type_id::create("mdio_driv_0", this);
    endfunction
    
    function void connect_phase(uvm_phase phase);

    endfunction
    
 endclass: mdio_env
  
