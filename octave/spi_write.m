## Author: RJurkin <RJurkin@E15084>
## Created: 2016-04-12

function spi_write(parent)
global n25q032_page_size_write;
global m25p16_page_size_write;
global spi_chip_fpga;
global ft_hw_desc ;

    %% Check file for writing
    file_to_write = get(parent.ed(1),'string');  % Get the current string.
    if isequal(file_to_write,0)
        UpdateConsole('no file assigned!', 1, parent);
        return;
    end

    %% read the file    
    fid = fopen(file_to_write);                 % low level read file
    data_w = uint8(fread(fid))';
    fclose(fid);

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
        page_size = n25q032_page_size_write;
    else
        page_size = m25p16_page_size_write;
        
        %% make every byte bit reverse for DSP
        str = textprogressbar('Data processing: '); % initiate console message
        UpdateConsole(str, 1, parent);              % type string on new line
        i = 0;
        len = numel(data_w);
        while i < len
            i = i + 1;
            
            if (data_w(i) ~= 255) || (data_w(i) ~= 0)
                data_w(i) = bin2dec(fliplr(dec2bin(data_w(i),8)));
            endif
    
            str = textprogressbar(i*100/len);     % report writing progress
            UpdateConsole(str, 0, parent);

        endwhile
        
        str = textprogressbar(' done');
        UpdateConsole(str, 0, parent);
        pause(0.5);

    endif

    str = textprogressbar('writing: ');         % initiate console message
    UpdateConsole(str, 1, parent);              % type string on new line
        
    %% Process the file
    reminder = rem(numel(data_w), page_size);   % check page size and
    if reminder ~= 0                            % extend to be page_size equal
        data_w = [data_w, repmat(uint8(255), 1, page_size-reminder)];
    end

    len = numel(data_w);
    adr = 0;
    while adr < len
        st = adr + 1;
        sp = adr + page_size;
        ret = ft_spi_write(hDLL, ftHandle, adr, data_w(st:sp), page_size);
        
        %pause(0.05);
        adr = adr + page_size;
        
        str = textprogressbar(adr*100/len);     % report writing progress
        UpdateConsole(str, 0, parent);
        pause(0.001);    
    end   

    %% CloseHandler
    ft_spi_close(hDLL, ftHandle);
    str = textprogressbar(' done');
    UpdateConsole(str, 0, parent);
    
endfunction