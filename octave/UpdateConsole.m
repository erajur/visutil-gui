function UpdateConsole(str, line, glob)
num_lines = 12;
% str - 'string' to update
% line- shift(1) or sameline(0) (progress feature)
%[h,S] = varargin{[1,3]};  % Get calling handle and structure.
  s = get(glob.tx,'string')';
  if line == 1
    %st = [{str}, s(1:4)]; 
    s(2:num_lines) = s(1:num_lines-1);
    s(1) = str;
  else
    %st = [{sprintf(str)}, s(2:5)]; 
    %s(2:5) = s(1:4);
    s(1) = str;
  endif
  
  set(glob.tx,'string',s);
  
  %S = varargin{3};
  %s = get(S.tx,'string');  % Get the current string.
  %str = 'qwe';
  %set(S.tx,'string',s);

  
endfunction


%str = textprogressbar('loading: ');
%typeConsole(str, 1, varargin{3});   % type string on new line
%for i=1:100,
%    str = textprogressbar(i);
%    typeConsole(str, 0, varargin{3});
%    pause(0.05);
%end
%str = textprogressbar(' done');
%typeConsole(str, 0, varargin{3});
