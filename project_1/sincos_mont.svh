class sincos_mont extends uvm_monitor;
  `uvm_component_utils(sincos_mont)
  `uvm_component_new

  extern function build_phase(uvm_phase phase);
  extern task runn_phase(uvm_phase phase);

  virtual sincos_if sincos_if_h;

  sincos_aprt sincos_aprt_i;
  sincos_aprt sincos_aprt_o;

  sincos_seqi sincso_seqi_i;
  sincos_seqi sincos_seqi_o;

endclass

function void sincos_mont :: build_phase(uvm_phase phase);
  sincos_aprt_i = new("sincos_aprt_i", this);
  sincos_aprt_o = new("sincos_aprt_o", this);
endfunction

task sincos_mont:: run_phase(uvm_phase phase);
  forever @(posedge sincos_if_h_iclk)begin
    if(sincos_if_h_iphase_v == 1)begin
      `uvm_object_create(sincos_seqi, sincso_seqi_i)
      sincos_seqi_i.phase = sincos_if_h_iphase;
      sincos_aprt_i.write(sincos_seqi_i)
    end
    if(sincos_if_h.osincos_v == 1)begin
      `uvm_object_create(sincos_seqi, sincos_seqi_o)
      sincos_seqi_o.sin = $signed(sincos_if_h.osin);
      sincos_seqi_o.cos = $signed(sincos_if_h.ocos);
      sincos_aprt_o.write(sincos_seqi_0)
    end
  end
endtask