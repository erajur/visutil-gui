## Author: RJurkin <RJurkin@E15084>
## Created: 2016-04-12

function spi_write(parent)
global n25q032_page_size_write;
global spi_chip_fpga;
global ft_hw_desc ;

    %% Check file for writing
    file_to_write = get(parent.ed(1),'string');  % Get the current string.
    if isequal(file_to_write,0)
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
    
    str = textprogressbar('writing: ');         % initiate console message
    UpdateConsole(str, 1, parent);              % type string on new line

    fid = fopen(file_to_write);                 % low level read file
    data_w = uint8(fread(fid))';
    fclose(fid);

    page_size = n25q032_page_size_write;
    reminder = rem(numel(data_w), page_size);   % check page size and
    if reminder ~= 0                            % extend to be page_size equal
        data_w = [data_w, repmat(uint8(255), 1, page_size-reminder)];
    end

    len = numel(data_w);
    adr = 0;
    while adr < len
        st = adr + 1;
        sp = adr + page_size;
        %calllib('peraftdi_d64', 'PeraFTDI_iSpiWriteData', ft_handle.value, adr, pdata_w.value(st:sp), page_size);
        ret = ft_spi_write(hDLL, ftHandle, adr, data_w(st:sp), page_size);
        
        %pause(0.05);
        adr = adr + page_size;
        
        str = textprogressbar(adr*100/len);     % report writing progress
        UpdateConsole(str, 0, parent);
        pause(0.001);    
    end   

    %calllib('peraftdi_d64', 'PeraFTDI_iSpiDeviceClose', ft_handle.value);    

    str = textprogressbar(' done');
    UpdateConsole(str, 0, parent);

    %% CloseHandler
    ret = ft_spi_close(hDLL, ftHandle)
    
endfunction