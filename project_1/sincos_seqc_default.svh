class sincos_seqc_default extends uvm_sequence #(sincos_seqi);
  `uvm_object_utils(sincos_seqc_default);
  `uvm_object_new

  extern task body();

  sincos_seqi sincos_seqi_h;

endclass



task sincos_seqc_default::body();

  `uvm_component_create(sincos_seqi, sincos_seqi_h)

  repeat(100)begin
    start_item(sincos_seqi_h);
      assert(sincos_seqi_h.randomize());
    finish_item(sincos_seqi_h);
  end
endtask