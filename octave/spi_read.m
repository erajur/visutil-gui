## Author: RJurkin <RJurkin@E15084>
## Created: 2016-04-12

function spi_read(parent)
global n25q032_size;
global n25q032_page_size_read;
global spi_chip_fpga;
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
    
    %% muxes cfg
    ss = get(parent.tb,'string');  
    if  strcmpi(ss, spi_chip_fpga)
        ret = ft_spi_io_cfg(hDLL, ftHandle, 1, 0x08, 0x0B); % FPGA
    else
        ret = ft_spi_io_cfg(hDLL, ftHandle, 1, 0x24, 0xB4); % DSP
    endif
    
    str = textprogressbar('reading: ');      % console message
    UpdateConsole(str, 1, parent);           % type string on new line

    len = n25q032_size;
    data_r = repmat(uint8(255), 1, len);        % read buffer allocation
    %pdata_r = libpointer('uint8Ptr', data_r);   % is allocated

    page_size = n25q032_page_size_read;
    %buffer = [];
    addr = 0;
    while addr < len
        st = addr + 1;
        sp = addr + page_size;
        %[ret handle buf] = calllib('peraftdi_d64', 'PeraFTDI_iSpiReadData', ft_handle.value, adr, pdata_r.value(st:sp), page_size);
        [ret data] = ft_spi_read(hDLL, ftHandle, addr, page_size);
        data_r(st:sp) = data;
        
        addr = addr + page_size;                
        %buffer = [buffer buf];
        str = textprogressbar(addr*100/len);     % report writing progress
        UpdateConsole(str, 0, parent);
        pause(0.001);    
    endwhile

    %calllib('peraftdi_d64', 'PeraFTDI_iSpiDeviceClose', ft_handle.value);    

    fid = fopen(file_to_read,'w');
    fwrite(fid, data_r);
    fclose(fid);
    
    str = textprogressbar(' done');
    UpdateConsole(str, 0, parent);

    %% CloseHandler
    ret = ft_spi_close(hDLL, ftHandle)

endfunction