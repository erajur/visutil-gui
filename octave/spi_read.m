## Author: RJurkin <RJurkin@E15084>
## Created: 2016-04-12

function spi_read(parent)
global n25q032_size;
global n25q032_page_size_read;
global m25p16_size;              % memory size in bytes
global m25p16_page_size_read;

global spi_chip_fpga;
global spi_chip_dsp;
global ft_hw_desc ;

    %% Check file for reading
    file_to_read = get(parent.ed(2),'string');  % Get the current string.
    if isequal(file_to_read,0)
        UpdateConsole('no file assigned!', 1, parent);
        return;
    end

    %% OpenHandler
    [ret hDLL ftHandle] = ft_spi_open(ft_hw_desc);
    if ret ~= 0
        UpdateConsole('communication error!', 1, parent);
        return;
    end
    
    %% setup board's muxes
    ss = get(parent.tb,'string');  
    [val dir] = get_io_cfg(ss);
    ret = ft_spi_io_cfg(hDLL, ftHandle, 1, val, dir);    
    if strcmpi(ss, spi_chip_fpga)
        page_size = n25q032_page_size_read;
        len = n25q032_size;
    else
        page_size = m25p16_page_size_read;
        len = m25p16_size;
    endif
        
    str = textprogressbar('reading: ');       % console message
    UpdateConsole(str, 1, parent);            % type string on new line
    data_r = repmat(uint8(255), 1, len);      % read buffer allocation
    addr = 0;
    while addr < len
        st = addr + 1;
        sp = addr + page_size;
        [ret data] = ft_spi_read(hDLL, ftHandle, addr, page_size);
        data_r(st:sp) = data;
        
        addr = addr + page_size;                
        str = textprogressbar(addr*100/len);  % report writing progress
        UpdateConsole(str, 0, parent);
        pause(0.001);    
    endwhile

    %% CloseHandler
    ft_spi_close(hDLL, ftHandle);    
    str = textprogressbar(' done');
    UpdateConsole(str, 0, parent);
    
    #pause(0.5);    
    %% make every byte bit reverse for DSP
    #ss = get(parent.tb,'string');  
    #if  strcmpi(ss, spi_chip_dsp)
    #    str = textprogressbar('Data processing: '); % initiate console message
    #    UpdateConsole(str, 1, parent);              % type string on new line
    #    i = uint32(0);
    #    len = uint32(numel(data_r));
    #    div = uint32(len / 100);
    #    while i < len
    #        i = i + 1;
    #        
    #        if mod(uint32(i), uint32(div)) == 0
    #          str = textprogressbar(i*100/len); % report writing progress
    #          UpdateConsole(str, 0, parent);
    #        endif
    #        
    #        if (data_r(i) ~= 255) || (data_r(i) ~= 0)
    #            data_r(i) = bin2dec(fliplr(dec2bin(data_r(i),8)));
    #        endif                    
    #    endwhile
    #        
    #    str = textprogressbar(100); % report writing progress
    #    UpdateConsole(str, 0, parent);
    #    str = textprogressbar(' done');
    #    UpdateConsole(str, 0, parent);
    #endif
    
    fid = fopen(file_to_read,'w');
    fwrite(fid, data_r);
    fclose(fid);
    
endfunction