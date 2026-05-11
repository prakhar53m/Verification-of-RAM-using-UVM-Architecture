
	class ram_wr_agent extends uvm_agent;

	`uvm_component_utils(ram_wr_agent)

        ram_wr_agent_config m_cfg;
       
	ram_wr_monitor monh;
	ram_wr_sequencer wr_sequencer;
	ram_wr_driver drvh;

  extern function new(string name = "ram_wr_agent", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass : ram_wr_agent

       function ram_wr_agent::new(string name = "ram_wr_agent", 
                               uvm_component parent = null);
         super.new(name, parent);
       endfunction
     
  

	function void ram_wr_agent::build_phase(uvm_phase phase);
		super.build_phase(phase);
	  if(!uvm_config_db #(ram_wr_agent_config)::get(this,"","ram_wr_agent_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
	        monh=ram_wr_monitor::type_id::create("monh",this);	
		if(m_cfg.is_active==UVM_ACTIVE)
		begin
		drvh=ram_wr_driver::type_id::create("drvh",this);
		wr_sequencer=ram_wr_sequencer::type_id::create("wr_sequencer",this);
		end
	endfunction


      
	function void ram_wr_agent::connect_phase(uvm_phase phase);
		if(m_cfg.is_active==UVM_ACTIVE)
		begin
		drvh.seq_item_port.connect(wr_sequencer.seq_item_export);
  		end
	endfunction
   

   

