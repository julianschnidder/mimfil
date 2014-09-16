function [x, out]=mimfil(mimfil_problem, mimfil_options)
% [x, out]=mimfil(mimfil_problem, mimfil_options)
%
% Apply (multigrid) implicit filtering optimization method to
% mimfil_problem: optimization problem statement, with
% mimfil_options: algorithm options.
%
% mimfil_problem and mimfil_options must be constructed by MIMFIL_PROBLEM and
% MIMFIL_OPTIONS respectively.
%
% See also: MIMFIL_PROBLEM, MIMFIL_OPTIONS

global mimfil_problem mimfil_options fevals;
fevals=0;

% invoke main routine

mimfil_problem.x0=mimfil_problem.x0(:);
n=length(mimfil_problem.x0);
f=mimfil_problem.f

x=ones(n,1);
xc=x0;

for k=1:length(mimfil_options.scales)
    % compute auxiliary variables

    %% is abortion criterion met?
    criterion = norm(mimfil_gradient(f,xc)<mimfil_options.termeps)
    if (criterion)
        break;
    end

    %% check for choice of inner optimization algorithm
    if mimfil_options.algo == 'steepest'
        x=mimfil_steepst(mimfil_problem.f, xc, mimfil_options.scales(k));
    end

    if mimfil_options.algo == 'sr1'
        x=mimfil_steepst(mimfil_problem.f, xc, mimfil_options.scales(k));
    end

    if mimfil_options.algo == 'bfgs'
        x=mimfil_steepst(mimfil_problem.f, xc, mimfil_options.scales(k));
    end
end

end

function [grad, fevals] = mimfil_gradient(f, xc, h)
%  grad = mimfil_gradient(f, xc, h)
% Compute gradient of f at xc with central difference
% quotient with difference increment h
xc=xc(:);
grad = ones(size(xc));

for k=1:length(xc)
    grad(k) = (feval(f, xc + h*ones(size(xc))) - ...
    feval(f, xc-h*ones(size(xc)))) / h;
end
fevals=2*k+fevals;

end % mimfil_gradient

function t = mimfil_armijo(f, x, d, grad)
maxiter=20;
beta=0.5;
sigma=0.5;
t=1;
val=0;


maxiter = probem.mimfil_options.maxiter;

for k=0:maxiter
    val = feval(f, x+t*d) - (feval(f, x) + sigma*t*grad'*d);
    fevals=fevals+2;
    if(val > 0)
        t=t*beta;
    else
        break;
    end
end
end % mimfil_armijo

fuction xu=mimfil_steepst(f, x, scale)

    % fevals = fevals+...    
end % function mimfil_steepst
