function [w] = learn(X, y)
  [n m] = size(X);
  bias_column = ones(n, 1);
  X_tilda = [X bias_column];
  w = zeros(m + 1);
  [Q R] = Householder(X_tilda);
  y_tilda = Q' * y;
  w = SST(R,y_tilda);
end
