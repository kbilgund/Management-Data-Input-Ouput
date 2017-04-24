
class mdio_env extends uvm_env;

    `uvm_component_utils(mdio_env)
   
    mdio_driver    mdio_driv_0;
    virtual mdio_if mdio_vif;
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
 
    function void build_phase(uvm_phase phase);
      mdio_driv_0 = mdio_driver::type_id::create("mdio_driv_0", this);
      if (!uvm_config_db #(virtual mdio_if)::get(this, "*",
      "mdio_vif", mdio_vif)) begin
    `uvm_fatal("connect", "ADPCM_vif not found")
      end
    endfunction
    
    function void connect_phase(uvm_phase phase);
       mdio_driv_0.mdio_vif = mdio_vif;
    endfunction
  
    task reset_phase(uvm_phase phase);
      phase.raise_objection(this, "starting reset");
      mdio_vif.reset = 1 ;
      repeat(10) @(mdio_vif.tb_clk);
      mdio_vif.reset = 0 ;
      phase.drop_objection(this, "reset over");
    endtask
    
 endclass: mdio_env
