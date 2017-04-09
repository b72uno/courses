function [theta] = normalEqn(X, y)
%NORMALEQN Computes the closed-form solution to linear regression 
%   NORMALEQN(X,y) computes the closed-form solution to linear 
%   regression using the normal equations.

theta = zeros(size(X, 2), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the code to compute the closed form solution
%               to linear regression and put the result in theta.
%

% ---------------------- Sample Solution ----------------------
%theta = (dot(pinv(dot(transpose(X), X)), transpose(X)) * y)
first = transpose(X) * X;
second = pinv(first) * transpose(X);
third = second * y;
theta = third;
% -------------------------------------------------------------


% ============================================================

end
