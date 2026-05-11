	class ram_base_test extends uvm_test;

	`uvm_component_utils(ram_base_test)
    
    	 ram_tb ram_envh;
         ram_env_config m_tb_cfg;
		ram_wr_agent_config m_wr_cfg[];
		ram_rd_agent_config m_rd_cfg[];

         int no_of_duts = 4;
         int has_ragent = 1;
         int has_wagent = 1;

	extern function new(string name = "ram_base_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void config_ram();
        endclass

   	function ram_base_test::new(string name = "ram_base_test" , uvm_component parent);
		super.new(name,parent);
	endfunction

	function void ram_base_test::config_ram();
 	   if (has_wagent) begin
                m_wr_cfg = new[no_of_duts];
	
	        foreach(m_wr_cfg[i]) begin
                m_wr_cfg[i]=ram_wr_agent_config::type_id::create($sformatf("m_wr_cfg[%0d]", i));

	  if(!uvm_config_db #(virtual ram_if)::get(this,"", $sformatf("vif_%0d",i),m_wr_cfg[i].vif))
		`uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?") 
                m_wr_cfg[i].is_active = UVM_ACTIVE;

                m_tb_cfg.m_wr_agent_cfg[i] = m_wr_cfg[i];
                
                end
             end
             if (has_ragent) begin
                                m_rd_cfg = new[no_of_duts];


		foreach(m_rd_cfg[i]) begin
            m_rd_cfg[i]=ram_rd_agent_config::type_id::create($sformatf("m_rd_cfg[%0d]", i));

	  if(!uvm_config_db #(virtual ram_if)::get(this,"", $sformatf("vif_%0d",i),m_rd_cfg[i].vif))
		`uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?") 
                m_rd_cfg[i].is_active = UVM_ACTIVE;
		

                               m_tb_cfg.m_rd_agent_cfg[i] = m_rd_cfg[i];

                
                end
             end

                m_tb_cfg.no_of_duts = no_of_duts;
                m_tb_cfg.has_ragent = has_ragent;
                m_tb_cfg.has_wagent = has_wagent;
            endfunction : config_ram



	function void ram_base_test::build_phase(uvm_phase phase);
	       m_tb_cfg=ram_env_config::type_id::create("m_tb_cfg");
                if(has_wagent)
                m_tb_cfg.m_wr_agent_cfg = new[no_of_duts];
                if(has_ragent)
              m_tb_cfg.m_rd_agent_cfg=new[no_of_duts];
                config_ram(); 

	 	uvm_config_db #(ram_env_config)::set(this,"*","ram_env_config",m_tb_cfg);
     		super.build_phase(phase);
		ram_envh=ram_tb::type_id::create("ram_envh", this);
	endfunction


	class ram_single_addr_test extends ram_base_test;

  
	`uvm_component_utils(ram_single_addr_test)

         ram_single_vseq ram_seqh;

 	extern function new(string name = "ram_single_addr_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass


   	function ram_single_addr_test::new(string name = "ram_single_addr_test" , uvm_component parent);
		super.new(name,parent);
	endfunction


            
	function void ram_single_addr_test::build_phase(uvm_phase phase);
            super.build_phase(phase);
	endfunction


      	task ram_single_addr_test::run_phase(uvm_phase phase);
         phase.raise_objection(this);
          ram_seqh=ram_single_vseq::type_id::create("ram_seqh");
          ram_seqh.start(ram_envh.v_sequencer);
         phase.drop_objection(this);
	endtask   


	class ram_ten_addr_test extends ram_base_test;

  
	`uvm_component_utils(ram_ten_addr_test)

         ram_ten_vseq ram_seqh;

 	extern function new(string name = "ram_ten_addr_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass


   	function ram_ten_addr_test::new(string name = "ram_ten_addr_test" , uvm_component parent);
		super.new(name,parent);
	endfunction


            
	function void ram_ten_addr_test::build_phase(uvm_phase phase);
            super.build_phase(phase);
	endfunction


      	task ram_ten_addr_test::run_phase(uvm_phase phase);
         phase.raise_objection(this);
          ram_seqh=ram_ten_vseq::type_id::create("ram_seqh");
          ram_seqh.start(ram_envh.v_sequencer);
         phase.drop_objection(this);
	endtask   


	class ram_odd_addr_test extends ram_base_test;

  
	`uvm_component_utils(ram_odd_addr_test)

         ram_odd_vseq ram_seqh;

 	extern function new(string name = "ram_odd_addr_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass


   	function ram_odd_addr_test::new(string name = "ram_odd_addr_test" , uvm_component parent);
		super.new(name,parent);
	endfunction


            
	function void ram_odd_addr_test::build_phase(uvm_phase phase);
            super.build_phase(phase);
	endfunction


      	task ram_odd_addr_test::run_phase(uvm_phase phase);
         phase.raise_objection(this);
          ram_seqh=ram_odd_vseq::type_id::create("ram_seqh");
          ram_seqh.start(ram_envh.v_sequencer);
        phase.drop_objection(this);
	endtask   


	class ram_even_addr_test extends ram_base_test;

  
	`uvm_component_utils(ram_even_addr_test)

         ram_even_vseq ram_seqh;

 	extern function new(string name = "ram_even_addr_test" , uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass


   	function ram_even_addr_test::new(string name = "ram_even_addr_test" , uvm_component parent);
		super.new(name,parent);
	endfunction

            
	function void ram_even_addr_test::build_phase(uvm_phase phase);
            super.build_phase(phase);
	endfunction

      	task ram_even_addr_test::run_phase(uvm_phase phase);
         phase.raise_objection(this);
          ram_seqh=ram_even_vseq::type_id::create("ram_seqh");
          ram_seqh.start(ram_envh.v_sequencer);
         phase.drop_objection(this);
	endtask   