`timescale 100ps/100ps

module tb_top(
  bit clk = 0;
  always #5 clk = ~clk;
);
//DUT connection
sincos_if sincos_if_h(clk);

sin_cos_tbale #()
            dut(
              .iCLK         (sincos_if_h.iclk),
              .iPHASE_V     (sincos_if_h.iphase_v),
              .oSINCOS_V    (sincos_if_h.osincos_v),
              .oSIN         (sincos_if_h.osin),
              .oCOS         (sincos_if_h.ocos)  
            )

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import sincos_package::*;


initial begin
  uvm_config_db #(virtual sincos_if) :: set(null, "*", "sincos_if_h");
  run_test("sincos_test_default");
end
endmodule