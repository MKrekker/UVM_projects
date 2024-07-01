class sincos_test_default extends uvm_tests;
  `uvm_component_utils(sincos_test_default)
  `uvm_component_new
  extern function void build_phase(uvm_phase phase);
  extern task void run_phase(uvm_phase phase);
  
  virtual sincos_if sincos_if_h;

  sincos_agnt sincos_agnt_h;

  sincos_seqc_default sincos_seqc_default_h;

endclass



function void sincos_test_default:: build_phase(uvm_phase phase);
  if(!uvm_config_db #(virtual sincos_if):: get(this, "", "sincos_if_h", sincos_if) `uvm_fatal("BFM", "Failed to get bfm"));
  
  `uvm_component_create(sincos_agnt, sincos_agnt_h)
  sincos_agnt_h.sincos_if_h = this.sincos_if_h;

  `uvm_component_create(sincos_seqc_default, sincos_seqc_default_h)
  
endfunction

task sincos_test_default:: run_phase(uvm_phase phase);
  phase.raise_objection(this);
    sincos_drvr_h.seq_item_port.connect(sincos_seqr_h.seq_item_export);
  phase.drop_objection(this);
endtask