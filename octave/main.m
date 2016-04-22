
global file_to_write_FPGA = 'C:\proj\visutil\modules\gui\write_fpga.bin';
global file_to_read_FPGA = 'C:\proj\visutil\modules\gui\read_fpga.bin';
global file_to_write_DSP = 'C:\proj\visutil\modules\gui\write_dsp.bin';
global file_to_read_DSP = 'C:\proj\visutil\modules\gui\read_dsp.bin';
global file_to_write;
global file_to_read;

global spi_chip_fpga = 'FPGA SPI';          #define 
global spi_chip_dsp = 'DSP SPI';            #define 
global spi_chip_tgl_str;

global n25q032_size = 4194304;              % memory size in bytes

global n25q032_page_size_read = 4096;
global n25q032_subpage_size = 4096;         % 
global n25q032_subpages_num = 1024;         % 

%libfilename = 'peraftdi_d64.dll'; 
%libheader = 'peraftdiDllApi.h';
%ft_handle = libpointer('uint64Ptr', uint64(0));

global ft_hw_desc = 'dsp platform A';

gui_prog();

