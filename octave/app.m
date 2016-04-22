function [retval] = app (input1, input2)

  h_f = figure('position',[500 500 200 100]);

  h_edit = uicontrol('style', 'edit', 'position', [10 50 150 20],'string','c:\file.bin');
  
  h_btn_settings = uicontrol('string','settings','position',[10 10 50 30],'callback',@cf_settings);
  h_btn_write = uicontrol('string','write','position',[70 10 50 30],'callback',@cf_write);
  h_btn_browse = uicontrol('string','browse','position',[130 10 50 30],'callback',{@cf_browse, h_edit});  
  
    
endfunction

function cf_settings(handle, event)
%get(handle)
%event
x = inputdlg({'port','speed'},'config');
endfunction

function cf_write(handle, event)
  h=waitbar(0,'writng');
  steps = 100;
  step = 0;
  while step<steps
    step = step + 1;
    waitbar(step/steps);
    pause(0.1);
  endwhile
  close(h);
endfunction

function cf_browse(handle, event, textedit)
%[filename, pathname] = uigetfile();
%set(textedit,'string',[pathname filename]);
str = uigetfile();
set(textedit,'string',str);
endfunction