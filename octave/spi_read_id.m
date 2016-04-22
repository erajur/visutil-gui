## Author: RJurkin <RJurkin@E15084>
## Created: 2016-04-12

function [retval] = spi_read_id(parent)
global spi_chip_fpga;
global ft_hw_desc ;
retval = 0;
   
    %% OpenHandler
    [ret hDLL ftHandle] = ft_spi_open(ft_hw_desc);

    if ret ~= 0
        str = 'communication error';
    else
        %% muxes cfg
        s = get(parent.tb,'string');  
        if  strcmpi(s, spi_chip_fpga)
            ret = ft_spi_io_cfg(hDLL, ftHandle, 1, 0x08, 0x0B); % FPGA
        else
            ret = ft_spi_io_cfg(hDLL, ftHandle, 1, 0x24, 0xB4); % DSP
        endif
        
        #i = 0;
        #while i<256
        #  ft_spi_io_cfg(hDLL, ftHandle, 1, i, 0xFF); % FPGA
        #  i = i + 1;
        #endwhile
        
    
        %% Read ID
        [ret data] = ft_spi_read_id(hDLL, ftHandle, 12);
        %pause(0.05);  % makes blink longer

        %% CloseHandler
        ret = ft_spi_close(hDLL, ftHandle);
        
        s = sprintf('x%02X ', data);        
        str = ['read id: ' s];
    endif
    
    UpdateConsole(str, 1, parent);
    
    hDLL = [];
    ftHandle = [];
    
endfunction
