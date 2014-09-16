function optout = mimfil_options(varargin)
% optout = mimfil_options('name1', value1, 'name2', value2,... [,optin])
%
% Set cell array of options.
% Following Optoins are availible:
% scales: A vector, that contains the difference increments for derivations
% maxiter: maximum number of outer iterations
% termeps: Residual termination criterion
%
% See also: MIMFIL, MIMFIL_PROBLEM

if(mod(nargin,2) == 0) % no options structure given
    % set defaults
    optout.termeps = 1e-6;
    optout.maxiter = 100;
    optout.scales  = 2.^(-(2:10));
else % options at varargin{end}
    optout = varargin{end}
end

% set given values
for k=1:2:nargin-1
    switch varargin{k}
    case {'termeps'}
        optout.termeps = varargin{k+1};
    case {'maxiter'}
        optout.maxiter = varargin{k+1};
    case {'scales'}
        optout.scales = varargin{k+1};
    otherwise
        error('mimfil: invalid option');
    end
end
