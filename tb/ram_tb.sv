	class ram_tb extends uvm_env;

        
     	`uvm_component_utils(ram_tb)

	
	ram_wr_agt_top wagt_top[];
	ram_rd_agt_top ragt_top[];
	
		ram_virtual_sequencer v_sequencer;
		ram_scoreboard sb[];

                ram_env_config m_cfg;

extern function new(string name = "ram_tb", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass: ram_tb
	

	function ram_tb::new(string name = "ram_tb", uvm_component parent);
		super.new(name,parent);
	endfunction


        	function void ram_tb::build_phase(uvm_phase phase);

	  if(!uvm_config_db #(ram_env_config)::get(this,"","ram_env_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
                if(m_cfg.has_wagent) begin
		  wagt_top = new[m_cfg.no_of_duts];
		foreach(wagt_top[i])begin

                  uvm_config_db #(ram_wr_agent_config)::set(this,$sformatf("wagt_top[%0d]*",i),  "ram_wr_agent_config", m_cfg.m_wr_agent_cfg[i]);
	          wagt_top[i]=ram_wr_agt_top::type_id::create($sformatf("wagt_top[%0d]",i) ,this);
                 end 
                end
                if(m_cfg.has_ragent == 1) begin
                 
		  ragt_top = new[m_cfg.no_of_duts];
                 foreach(ragt_top[i]) begin
               
                  uvm_config_db #(ram_rd_agent_config)::set(this,$sformatf("ragt_top[%0d]*",i),  "ram_rd_agent_config", m_cfg.m_rd_agent_cfg[i]);
	        
	          ragt_top[i]=ram_rd_agt_top::type_id::create($sformatf("ragt_top[%0d]",i) ,this);
               end
                end

        	super.build_phase(phase);
               if(m_cfg.has_virtual_sequencer)
	         v_sequencer=ram_virtual_sequencer::type_id::create("v_sequencer",this);
               if(m_cfg.has_scoreboard) begin
                
		  sb = new[m_cfg.no_of_duts];
                foreach(sb[i])
	          sb[i]=ram_scoreboard::type_id::create($sformatf("sb[%0d]",i) ,this);

               end
		endfunction

 
   		function void ram_tb::connect_phase(uvm_phase phase);
                      if(m_cfg.has_virtual_sequencer) begin
                        if(m_cfg.has_wagent)
		foreach(wagt_top[i])
			
		v_sequencer.wr_seqrh[i] = wagt_top[i].agnth.wr_sequencer;
		
                        if(m_cfg.has_ragent)
                         foreach(ragt_top[i])		
						v_sequencer.rd_seqrh[i] = ragt_top[i].agnth.seqrh;

                      end
	
   		     if(m_cfg.has_scoreboard) begin
    	foreach(wagt_top[i])
		wagt_top[i].agnth.monh.monitor_port.connect(sb[i].fifo_wrh.analysis_export);
	foreach(ragt_top[i])
      		ragt_top[i].agnth.monh.monitor_port.connect(sb[i].fifo_rdh.analysis_export);

					      end
			endfunction
