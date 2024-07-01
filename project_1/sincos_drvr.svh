class sincos_drvr extends uvm_driver #(sincos_seqi);

  `uvm_component_utils(sincos_drvr)
  `uvm_component_new



extern task run_phase(uvm_phase phase);

virtual sincos_if sincos_if_h;
sincos_seqi sincos_seqi_h;

endclass



task sincos_drvr:: run_phase(uvm_phase phase);
  forever begin
    seq_item_port.get_next_item(sincos_seqi_h);

    foreach (sincos_seqi_h.phase_v[i]) begin
      @(posedge sincos_if_h.iclk)
      sincos_if_h.iphase_v <= sincos_seqi_h.phase_v[i]
      if(sincos_seqi_h.phase_v[i] == 1'b1)
        sincos_if_h.iphase <= sincos_seqi_h.phase[11:0];    
    end


    seq_item_port.item_done();
  end
endtask