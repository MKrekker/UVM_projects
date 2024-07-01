`uvm_analysis_impl_decl(_i)
`uvm_analysis_impl_decl(_o)

class sincos_scrb extends uvm_scoreboard;
  `uvm_component_utils(sincos_scrb)
  `uvm_component_new

  uvm_analysis_imp_i #(sincos_seqi, sincos_scrb) sincos_aprt_i;
  uvm_analysis_imp_o #(sincos_seqi, sincos_scrb) sincos_aprt_o;

  extern function build_phase(uvm_phase phase);

  extern virtual function void write_i(sincos_seqi sincos_seqi_h);
  extern virtual function void write_o(sincos_seqi sincos_seqi_h);

  sincos_seqi sincos_seqi_queue_i[$];
  sincos_seqi sincos_seqi_queue_o[$];

  extern function void processing();

  extern virtual function int get_ideal_sin(int phase);
  extern virtual function int get_ideal_cos(int phase);

endclass

function void sincos_scrb::build_phase(uvm_phase phase);
  sincos_aprt_i = new("sincos_aprt_i",this);
  sincos_aprt_o = new("sincos_aprt_o",this);
endfunction

function void sincos_scrb::write_i(sincos_seqi sincos_seqi_h);
  sincos_seqi_queue_i.push_back(sincos_seqi_h);
endfunction

function void sincos_scrb::write_os(sincos_seqi sincos_seqi_h);
  sincos_seqi_queue_o.push_back(sincos_seqi_h);
  processing();
endfunction

function void sincos_scrb::processing();
  sincos_seqi sincos_seqi_i;
  sincos_seqi sincos_seqi_o;
  string data_str;

  sincos_seqi_i = sincos_seqi_queue_i.pop_front();

  sincos_seqi_i.sin = get_ideal_sin(sincos_seqi_i.phase);
  sincos_seqi_i.cos = get_ideal_cos(sincos_seqi_i.phase);

  // $display(sincos_seqi_i.convert2string());
  
  sincos_seqi_o = sincos_seqi_queue_o.pop_front();
  sincos_seqi_o.phase = sincos_seqi_i.phase;
  
  // $display(sincos_seqi_o.convert2string());

  data_str = {
            "\n", "actual:      ", sincos_seqi_o.convert2string(),
            "\n", "predicted:   ", sincos_seqi_i.convert2string()
  };

  if(!sincos_seqi_i.compare(sincos_seqi_o))
    `uvm_error("FAIL", data_str)
  else begin
    `uvm_info("PASS", data_str, UVM_NONE)
  end
endfunction

function int sincos_scrb::get_ideal_sin(int phase);
  int sin_max = 2**15-1;
  real c_pi = 3.141592653589793238462643383279;
  real phase_r;
  real sin_r;
  real sin_floor;

  phase_r = $itor(phase)*2.0*c_pi / 4096.0;
  sin_r = $sin(phase_r) * $itor(sin_max);
  sin_floor = $floor(sin_r + 0.5);

  return $rtoi(sin_floor);
endfunction

function int sincos_scrb::get_ideal_cos(int phase);
  int cos_max = 2**15-1;
  real c_pi = 3.141592653589793238462643383279;
  real phase_r;
  real cos_r;
  real cos_floor;

  phase_r = $itor(phase)*2.0*c_pi / 4096.0;
  cos_r = $cos(phase_r) * $itor(cos_max);
  cos_floor = $floor(cos_r + 0.5);

  return $rtoi(cos_floor);
endfunction