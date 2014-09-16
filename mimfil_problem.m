function problem = mimfil_problem(varargin)
% problem = mimfil_problem('name1', value1, 'name2', value2,... [,probin])
%
% Set cell array of the problem statement.
% The problem includes:
% f: objective function
% x0: initial starting point
%
% See also: MIMFIL, MIMFIL_OPTIONS

if(mod(nargin,2) == 0) % no problem structure given
    problem.f = @(x) 0;
    problem.x0 = 0;
else
    problem = varargin{end}
end

% set given values
for k=1:2:nargin-1
    switch varargin{k}
    case {'f'}
        problem.f = varargin{k+1};
    case {'x0'}
        problem.x0 = varargin{k+1};
    otherwise
        error('mimfil: invalid problem statement');
    end
end
