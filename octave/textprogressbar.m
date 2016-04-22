function str = textprogressbar(c)
% This function creates a text progress bar.
% Inspired by: Paul Proteus

%% Initialization
persistent init_str;       %   Carriage return pesistent variable
persistent last_str;       %   Carriage return pesistent variable

% Vizualization parameters
strPercentageLength = 10;   %   Length of percentage string (must be >5)
strDotsMaximum      = 10;   %   The total number of dots in a progress bar

%% Main 
if isempty(init_str) && ~ischar(c),
    % Progress bar must be initialized with a string
    error('The text progress must be initialized with a string');
elseif isempty(init_str) && ischar(c),
    % Progress bar - initialization
    init_str = c;
    str = init_str;
elseif ~isempty(init_str) && ischar(c),
    % Progress bar  - termination
    str = [char(init_str), char(last_str), char(c)];
    init_str = [];  
elseif isnumeric(c)
    % Progress bar - normal progress
    c = floor(c);
    percentageOut = [num2str(c) '%'];
    percentageOut = [percentageOut repmat(' ',1,strPercentageLength-length(percentageOut)-1)];
    nDots = floor(c/100*strDotsMaximum);
    dotOut = ['[' repmat('.',1,nDots) repmat(' ',1,strDotsMaximum-nDots) ']'];
    strOut = [percentageOut dotOut];
    
    % Print it on the screen
    last_str = strOut;
    str = [init_str, last_str];
    
else
    % Any other unexpected input
    error('Unsupported argument type');
end
