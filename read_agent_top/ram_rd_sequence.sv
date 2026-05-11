
	class ram_rbase_seq extends uvm_sequence #(read_xtn);  
	

	`uvm_object_utils(ram_rbase_seq)  

        extern function new(string name ="ram_rbase_seq");
	endclass
	function ram_rbase_seq::new(string name ="ram_rbase_seq");
		super.new(name);
	endfunction

	class ram_single_addr_rd_xtns extends ram_rbase_seq;

  	
  	`uvm_object_utils(ram_single_addr_rd_xtns)

        extern function new(string name ="ram_single_addr_rd_xtns");
        extern task body();
	endclass
	function ram_single_addr_rd_xtns::new(string name = "ram_single_addr_rd_xtns");
		super.new(name);
	endfunction

	
	task ram_single_addr_rd_xtns::body();
    	repeat(10)
	  begin
   	   req=read_xtn::type_id::create("req");
	   start_item(req);
   	   assert(req.randomize() with {address==55;} );
	   `uvm_info("RAM_RD_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	   finish_item(req); 
	   end
    	endtask



	class ram_ten_rd_xtns extends ram_rbase_seq;

  	
  	`uvm_object_utils(ram_ten_rd_xtns)

        extern function new(string name ="ram_ten_rd_xtns");
        extern task body();
	endclass
	function ram_ten_rd_xtns::new(string name = "ram_ten_rd_xtns");
		super.new(name);
	endfunction  
	
       task ram_ten_rd_xtns::body();
	int addrseq; 
	addrseq=0;	
   	repeat(10) begin
	req=read_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {address==addrseq; read==1'b1;} );
	`uvm_info("RAM_RD_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	finish_item(req);
	addrseq=addrseq + 1;
	end
       endtask

	class ram_odd_rd_xtns extends ram_rbase_seq;

  	
  	`uvm_object_utils(ram_odd_rd_xtns)

        extern function new(string name ="ram_odd_rd_xtns");
        extern task body();
	endclass
	function ram_odd_rd_xtns::new(string name = "ram_odd_rd_xtns");
		super.new(name);
	endfunction
    

       task ram_odd_rd_xtns::body();
	int addrseq; 
	addrseq=0;	
   	repeat(10) begin
	req=read_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {address==(2*addrseq+1);read==1'b1;} );
	`uvm_info("RAM_RD_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	finish_item(req);
	addrseq=addrseq + 1;
	end
       endtask


	class ram_even_rd_xtns extends ram_rbase_seq;

  	  	`uvm_object_utils(ram_even_rd_xtns)

        extern function new(string name ="ram_even_rd_xtns");
        extern task body();
	endclass
	function ram_even_rd_xtns::new(string name = "ram_even_rd_xtns");
		super.new(name);
	endfunction


       task ram_even_rd_xtns::body();
	int addrseq; 
	addrseq=0;	
   	repeat(10) begin
	req=read_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {address==(2*addrseq);read==1'b1;} );
	`uvm_info("RAM_RD_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
	finish_item(req);
	addrseq=addrseq + 1;
	end
       endtask



