module top;
   	
    	import ram_test_pkg::*;
   
	import uvm_pkg::*;

	bit clock;  
	always 
		#10 clock=!clock;     

   ram_if in0(clock);
	ram_if in1(clock);
	ram_if in2(clock);
	ram_if in3(clock);

       
    	ram_soc  DUV(.mif0(in0), 
                     .mif1(in1), 
                     .mif2(in2), 
                     .mif3(in3));

       	initial 
		begin

			`ifdef VCS
         		$fsdbDumpvars(0, top);
        		`endif
	
			uvm_config_db #(virtual ram_if)::set(null,"*","vif_1",in1);
			uvm_config_db #(virtual ram_if)::set(null,"*","vif_0",in0);
			uvm_config_db #(virtual ram_if)::set(null,"*","vif_2",in2);
			uvm_config_db #(virtual ram_if)::set(null,"*","vif_3",in3);
			run_test();
		end   
endmodule


  
   
  