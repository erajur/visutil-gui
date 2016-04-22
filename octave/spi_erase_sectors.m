## Author: RJurkin <RJurkin@E15084>
## Created: 2016-04-12
## Subsector erase: 1024_blocks x 4K_block = 4MB

function [retval] = spi_erase_sectors (parent, sector)
global n25q032_subpage_size;                % 
global n25q032_subpages_num;                % 
global n25q032_size;                        % memory size in bytes
global spi_chip_fpga;
global ft_hw_desc ;
retval = 0;

    %% OpenHandler
    [ret hDLL ftHandle] = ft_spi_open(ft_hw_desc);
   
    str = textprogressbar('erasing sectors: ');
    UpdateConsole(str, 1, parent);          % type string on new line

    if ret == 0;
        s = ' done';
                
        %% muxes cfg
        ss = get(parent.tb,'string');  
        if  strcmpi(ss, spi_chip_fpga)
            ret = ft_spi_io_cfg(hDLL, ftHandle, 1, 0x08, 0x0B); % FPGA
        else
            ret = ft_spi_io_cfg(hDLL, ftHandle, 1, 0x24, 0xB4); % DSP
        endif
            
        len = n25q032_size;
        addr = 0;
        while addr < len

            y = ft_spi_erase_sector(hDLL, ftHandle, addr);
            addr = addr + n25q032_subpage_size;     
        
            num = addr*100/n25q032_size;
            str = textprogressbar(num);            
            UpdateConsole(str, 0, parent);

            if y ~= 0 
                s = ' terminated';
                break;
            end
         end          
        
        %% CloseHandler
        ret = ft_spi_close(hDLL, ftHandle);
        
    else
        s = 'communication error';    
    endif

    str = textprogressbar(s);
    UpdateConsole(str, 0, parent);        
    
retval = 'ok'
endfunction
