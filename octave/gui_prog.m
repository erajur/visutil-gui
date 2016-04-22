function gui_prog()
global file_to_write;
global file_to_read;
global spi_chip_tgl_str;

SCR = get(0,'Screensize');  % Get screensize.
S.fh = figure('numbertitle','off',...
              'menubar','none',...
              'units','pixels',...
              %'position',[SCR(3)/2-200 ,SCR(4)/2-200 , 400, 400],...
              'position',[SCR(3)/2-200 ,SCR(4)/2-200 , 400, 500],...
              'name','Flash Prog',...
              'Units','normalized',...
              'Color',[0.8 0.8 0.8],...
              'resize','off');

S.tx = uicontrol('style','text','units','pixels','position',[25 60 355 190],...
                 'visible','on',...
                 'string',{'Welcome to FTDI-SPI programming utility, EII (c) 2016','','','','','','','','','','',''},...
                 'HorizontalAlignment','left',...
                 'BackgroundColor','white',...
                 'fontsize',10,'fontweight','normal');

bg1 = uipanel ("title", "Write to SPI Flash", 'Visible','on',"position", [0.05 0.77 .9 .20]);
bg2 = uipanel ("title", "Read from SPI Flash", 'Visible','on',"position", [0.05 0.54 .9 .20]);                 
                 
Wpb = {'style','pushbutton','units','pixels','fontsize',12,'position'};          
S.pb(1) = uicontrol(Wpb{:},[40  400 70 25],'string','Write');
S.pb(2) = uicontrol(Wpb{:},[130 400 70 25],'string','Erase All');
S.pb(3) = uicontrol(Wpb{:},[290 400 70 25],'string','Browse');
S.pb(4) = uicontrol(Wpb{:},[40  285 70 25],'string','Read');
S.pb(5) = uicontrol(Wpb{:},[130 285 70 25],'string','Read ID');
S.pb(6) = uicontrol(Wpb{:},[290 285 70 25],'string','Browse');
S.pb(7) = uicontrol(Wpb{:},[290 20 70 25],'string','Exit');
                 
Wed = {'style','edit','units','pixels','fontsize',10,'HorizontalAlignment','left','position'};  % Save some typing.               
%S.ed(1) = uicontrol(Wed{:},[40 435 320 25],'string',file_to_write);
%S.ed(2) = uicontrol(Wed{:},[40 320 320 25],'string',file_to_read);
S.ed(1) = uicontrol(Wed{:},[40 435 320 25]);
S.ed(2) = uicontrol(Wed{:},[40 320 320 25]);

S.tb = uicontrol ('style', 'togglebutton', "position",[30 20 90 30]);
%set(S.tb,'string',spi_chip_tgl_str);

set(S.tb,'callback',{@pushToggleBtn,S});
set(S.pb(1),'callback',{@pushWrite,S});
set(S.pb(2),'callback',{@pushEraseAll,S});
set(S.pb(3),'callback',{@pushBrowseWrite,S});
set(S.pb(4),'callback',{@pushRead,S});
set(S.pb(5),'callback',{@ReadId,S});
set(S.pb(6),'callback',{@pushBrowseRead,S});
set(S.pb(7),'callback',{@pushExit,S});
set(S.fh,'CloseRequestFcn',{@Exit_callback,S});

spi_chip_toggle(S);

endfunction

function [] = pushExit(varargin)            % Callback for pushbutton.
S = varargin{3};                            % Get calling handle ans structure.
delete(S.fh)                                % Delete the figure.
endfunction

function [] = Exit_callback(varargin)
button = questdlg('sure?','exiting..') ;    %http://se.mathworks.com/help/matlab/ref/inputdlg.html
  if button == 'Yes'
    S = varargin{3};                        % Get calling handle ans structure.
    delete(S.fh)                            % Delete the figure.
  endif
endfunction

function ReadId(varargin) 
  %UpdateConsole('no file assigned!', 1, varargin{3});
  spi_read_id(varargin{3});
endfunction

function [] = pushRead(varargin)
  spi_read(varargin{3});
endfunction

function pushWrite(varargin)
  spi_write(varargin{3});
endfunction

function pushBrowseWrite(varargin)          % define file to write dialog
  file_browse(varargin{3},'w');
endfunction

function pushBrowseRead(varargin)           % define read file dialog
  file_browse(varargin{3},'r');
endfunction

function pushEraseAll(varargin)
  %spi_erase_sectors(varargin{3},0);
  spi_erase_all(varargin{3});
endfunction

function pushEraseSectorAll(varargin)       % not currently in use
  spi_erase_sectors(varargin{3},1);
endfunction

function pushToggleBtn(varargin)
  spi_chip_toggle(varargin{3});
endfunction
