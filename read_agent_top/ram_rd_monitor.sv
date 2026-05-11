
	class ram_rd_monitor extends uvm_monitor;

	`uvm_component_utils(ram_rd_monitor)

   	virtual ram_if.RMON_MP vif;

        ram_rd_agent_config m_cfg;

  uvm_analysis_port #(read_xtn) monitor_port;


extern function new(string name = "ram_rd_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
extern function void report_phase(uvm_phase phase);


endclass 

 
 function ram_rd_monitor::new (string name = "ram_rd_monitor", uvm_component parent);
    super.new(name, parent);
    monitor_port = new("monitor_port", this);
  endfunction : new

 
	function void ram_rd_monitor::build_phase(uvm_phase phase);
          super.build_phase(phase);
	  if(!uvm_config_db #(ram_rd_agent_config)::get(this,"","ram_rd_agent_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
        endfunction


 	function void ram_rd_monitor::connect_phase(uvm_phase phase);
          vif = m_cfg.vif;
        endfunction


       task ram_rd_monitor::run_phase(uvm_phase phase);
        forever
       collect_data();     
       endtask


  task ram_rd_monitor::collect_data();

    read_xtn data_sent;
    data_sent= read_xtn::type_id::create("data_sent");

    @(posedge vif.rmon_cb.read);
    data_sent.read = vif.rmon_cb.read;
    data_sent.address = vif.rmon_cb.rd_address;
    data_sent.xtn_type = (data_sent.address == 'd1904) ? BAD_XTN : GOOD_XTN ;
    repeat(2)
      @(vif.rmon_cb);
    data_sent.data = vif.rmon_cb.data_out;
    `uvm_info("RAM_RD_MONITOR",$sformatf("printing from monitor \n %s", data_sent.sprint()),UVM_LOW) 
    monitor_port.write(data_sent);
    m_cfg.mon_rcvd_xtn_cnt++;
  endtask 
  function void ram_rd_monitor::report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: RAM Read Monitor Collected %0d Transactions", m_cfg.mon_rcvd_xtn_cnt), UVM_LOW)
  endfunction         
     
    

