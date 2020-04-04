function [x] = SST(A, b)
  [n m] = size(A);
  x = zeros(m, 1);
  for i = m : -1 : 1
    s = 0;
    for j = i + 1 : m
      s = s + A(i, j) * x(j, 1);
     end
    x(i, 1) = (b(i, 1) - s) / A(i, i); 
  end
end
    