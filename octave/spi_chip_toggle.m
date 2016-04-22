## Author: RJurkin <RJurkin@E15084>
## Created: 2016-04-21

function spi_chip_toggle (parent)

global file_to_write_FPGA;
global file_to_read_FPGA;
global file_to_write_DSP;
global file_to_read_DSP;
global file_to_write;
global file_to_read;

global spi_chip_fpga;
global spi_chip_dsp;
global spi_chip_tgl_str;

  s = get(parent.tb,'string');
  
  if  strcmpi(s, spi_chip_fpga)
    spi_chip_tgl_str = spi_chip_dsp;
    file_to_write = file_to_write_DSP;
    file_to_read = file_to_read_DSP;
    
  elseif strcmpi(s, spi_chip_dsp)
    spi_chip_tgl_str = spi_chip_fpga;
    file_to_write = file_to_write_FPGA;
    file_to_read = file_to_read_FPGA;
    
  else
    spi_chip_tgl_str = spi_chip_fpga;          % set default
    file_to_write = file_to_write_FPGA;
    file_to_read = file_to_read_FPGA;
  endif
  
  set(parent.tb,'string',spi_chip_tgl_str);  
  set(parent.ed(1),'string',file_to_write);
  set(parent.ed(2),'string',file_to_read);
    
endfunction


