function retval = file_browse(parent, read_write)        % define file to read_write dialog
global file_to_write;
global file_to_read;
retval = -1;

    if read_write = 'w'
        [filename, pathname] = uigetfile({'*.txt;*.bin;*.hex;','App Files (*.txt,*.bin,*.hex)';
        '*.txt','Text files (*.txt)'; ...
        '*.bin','Binary files (*.bin)'; ...
        '*.hex','Hex files (*.hex)'; ...
        '*.*',  'All Files (*.*)'}, ...
        'Pick a file',...
        file_to_write);

        if ~isequal(filename,0)
           file_to_write = fullfile(pathname, filename);
           set(parent.ed(1),'string',file_to_write);
           retval = 0;
           return;
        endif

    elseif read_write = 'r'
        [filename, pathname] = uiputfile({'*.txt;*.bin;*.hex;','App Files (*.txt,*.bin,*.hex)';
        '*.txt','Text files (*.txt)'; ...
        '*.bin','Binary files (*.bin)'; ...
        '*.hex','Hex files (*.hex)'; ...
        '*.*',  'All Files (*.*)'}, ...
        'Save as',...
        file_to_read);

        if ~isequal(filename,0)
           file_to_read = fullfile(pathname, filename);
           set(parent.ed(2),'string',file_to_read);
           retval = 0;
           return;
        endif

    else
        error('Bad function parameter!');
    endif

endfunction
