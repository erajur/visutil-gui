## Author: RJurkin <RJurkin@E15084>
## Created: 2016-04-12

function [retval] = spi_erase_all(parent)
global spi_chip_fpga;
global ft_hw_desc ;
retval = 0;

    %% OpenHandler
    [ret hDLL ftHandle] = ft_spi_open(ft_hw_desc);

    str = textprogressbar('erasing all: ');
    UpdateConsole(str, 1, parent);   % type string on new line
    %pause(0.01);
        
    if ret == 0

        %% setup board's muxes
        [val dir] = get_io_cfg(get(parent.tb,'string'));
        ret = ft_spi_io_cfg(hDLL, ftHandle, 1, val, dir);    
        ret = ft_spi_erase_all(hDLL, ftHandle);

        str = textprogressbar(100);
        UpdateConsole(str, 0, parent);
        s = ' done';
        
        %% CloseHandler
        ret = ft_spi_close(hDLL, ftHandle);        
    else
        s = 'communication error';    
    endif

    str = textprogressbar(s);
    UpdateConsole(str, 0, parent);        
    
retval = ret;
endfunction
