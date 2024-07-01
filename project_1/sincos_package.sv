package sincos_package;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  `include "common_macros.svh"
  `include "sincos_seqi.svh"
  typedef uvm_sequencer #(sincos_seqi) sincos_seqr;
  `include "sincos_drvr.svh"
  typedef uvm_analysis_port #(sincos_seqi) sincos_aprt;
  `include "sincos_mont.svh"
  `include "sincos_scrb.svh"
  `include "sincos_agnt.svh"
  `include "sincos_seqc_default.svh"
  `include "sincos_test_default.svh"