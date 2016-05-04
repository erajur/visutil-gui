## Author: RJurkin <RJurkin@E15084>
## Created: 2016-05-03

function [val dir] = get_io_cfg(spi_dev)
global spi_chip_fpga;

    %% setup board muxes
    if  strcmpi(spi_dev, spi_chip_fpga)
        % FTDI_AC0 = 0; First   MUX off (oe\)
        % FTDI_AC2 = 0; Second  MUX on  (oe\)
        % FTDI_AC3 = 1; connects FTDI to FPGA SPI Flash
        % FTDI_AC4 = 1; Third   MUX off (oe\)
        % FTDI_AC7 = 0; LED on
        val = 0x18;
        dir = 0x9D;
    else
        % FTDI_AC0 = 0; First   MUX off (oe\)
        % FTDI_AC2 = 1; Second  MUX off (oe\)
        % FTDI_AC4 = 0; Third   MUX on  (oe\)
        % FTDI_AC5 = 1; connects FTDI to DSP SPI Flash
        % FTDI_AC7 = 0; LED on
        val = 0x24;
        dir = 0xB5;        
    endif


endfunction
