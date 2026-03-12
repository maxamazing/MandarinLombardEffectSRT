%Example to read the data
%Created on Thu Mar 12 10:26:25 2026
%
%@author: max scharf

path = "data.json";
txt  = fileread(path);
data = jsondecode(txt);


% --- convert srt -> 45x11 numeric matrix X (with NaN for missing) ---
Xcell = cellfun(@toDoubleRowMissing, data.data, 'UniformOutput', false); % each -> 1x11 double
X     = vertcat(Xcell{:});                                         % 45x11 double

% --- build table with named columns and rows ---
T = array2table(X, 'VariableNames', data.column_names(:).', 'RowNames', data.row_names);

% optional: ensure valid MATLAB variable names
T.Properties.VariableNames = matlab.lang.makeValidName(T.Properties.VariableNames);

disp(T)

% ===== local functions =====
function r = toDoubleRowMissing(v)
    if iscell(v)
        r = cellfun(@(x) oneVal(x), v(:)).';
    else
        r = arrayfun(@(x) double(x), v(:)).';
    end
end

function y = oneVal(x)
    % Map "missing value" -> NaN; otherwise numeric conversion
    if isstring(x) || ischar(x)
        sx = string(x);
        if sx == "missing value"
            y = NaN;
        else
            y = str2double(sx);
        end
    else
        y = double(x);
    end
end