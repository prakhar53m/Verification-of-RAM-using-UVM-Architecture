
 
	class ram_wbase_seq extends uvm_sequence #(write_xtn);  


	`uvm_object_utils(ram_wbase_seq)  

        extern function new(string name ="ram_wbase_seq");
	endclass
	function ram_wbase_seq::new(string name ="ram_wbase_seq");
		super.new(name);
	endfunction


	class ram_single_addr_wr_xtns extends ram_wbase_seq;

  	
  	`uvm_object_utils(ram_single_addr_wr_xtns)


        extern function new(string name ="ram_single_addr_wr_xtns");
        extern task body();
	endclass
	function ram_single_addr_wr_xtns::new(string name = "ram_single_addr_wr_xtns");
		super.new(name);
	endfunction


	
	task ram_single_addr_wr_xtns::body();
    	repeat(10)
	  begin
   	   req=write_xtn::type_id::create("req");
	   start_item(req);
   	   assert(req.randomize() with {address==55;} );
	   `uvm_info("RAM_WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	   finish_item(req); 
	   end
    	endtask



	class ram_ten_wr_xtns extends ram_wbase_seq;

  	
  	`uvm_object_utils(ram_ten_wr_xtns)


        extern function new(string name ="ram_ten_wr_xtns");
        extern task body();
	endclass
	function ram_ten_wr_xtns::new(string name = "ram_ten_wr_xtns");
		super.new(name);
	endfunction
 
	
       task ram_ten_wr_xtns::body();
	int addrseq; 
	addrseq=0;	
   	repeat(10) begin
	req=write_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {address==addrseq; write==1'b1;} );
	`uvm_info("RAM_WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	finish_item(req);
	addrseq=addrseq + 1;
	end
       endtask



	class ram_odd_wr_xtns extends ram_wbase_seq;


  	`uvm_object_utils(ram_odd_wr_xtns)


        extern function new(string name ="ram_odd_wr_xtns");
        extern task body();
	endclass
	function ram_odd_wr_xtns::new(string name = "ram_odd_wr_xtns");
		super.new(name);
	endfunction


       task ram_odd_wr_xtns::body();
	int addrseq; 
	addrseq=0;	
   	repeat(10) begin
	req=write_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {address==(2*addrseq+1);write==1'b1;} );
	`uvm_info("RAM_WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	finish_item(req);
	addrseq=addrseq + 1;
	end
       endtask

	class ram_even_wr_xtns extends ram_wbase_seq;

  	
  	`uvm_object_utils(ram_even_wr_xtns)

        extern function new(string name ="ram_even_wr_xtns");
        extern task body();
	endclass
	function ram_even_wr_xtns::new(string name = "ram_even_wr_xtns");
		super.new(name);
	endfunction



       task ram_even_wr_xtns::body();
	int addrseq; 
	addrseq=0;	
   	repeat(10) begin
	req=write_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {address==(2*addrseq);write==1'b1;} );
	`uvm_info("RAM_WR_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	finish_item(req);
	addrseq=addrseq + 1;
	end
       endtask



