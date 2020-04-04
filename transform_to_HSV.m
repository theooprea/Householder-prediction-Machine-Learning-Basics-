function [HSV] = transform_to_HSV(RGB)
  [n m a] = size(RGB);
  RGB = double(RGB(:,:,:)) ./ 255;
  HSV = zeros(n,m,3);
  R = RGB(:,:,1);
  G = RGB(:,:,2);
  B = RGB(:,:,3);
  C_max = max(RGB, [], 3);
  C_min = min(RGB, [], 3);
  delta = C_max - C_min;
  H = zeros(n,m);
  S = zeros(n,m);
  V = zeros(n,m);
  %valorile pt delta == 0 puse in h
  index_pt_conditie = (delta == 0);
  H(index_pt_conditie) = 0;
  %valorile pt C_max == R (red)
  index_pt_conditie = (C_max == R & delta != 0);
  H(index_pt_conditie) = 60 * mod(((G(index_pt_conditie) - B(index_pt_conditie)) ./ delta(index_pt_conditie)), 6);
  %valorile pt C_max == G (green)
  index_pt_conditie = (C_max == G & delta != 0);
  H(index_pt_conditie) = 60 * ((B(index_pt_conditie) - R(index_pt_conditie)) ./ delta(index_pt_conditie) + 2);
  %valorile pt C_max == B (blue)
  index_pt_conditie = (C_max == B & delta != 0);
  H(index_pt_conditie) = 60 * ((R(index_pt_conditie) - G(index_pt_conditie)) ./ delta(index_pt_conditie) + 4);
  %normez H
  H = H ./ 360;
  %in cazul in care C_max este 0 pt S
  index_pt_conditie = (C_max == 0);
  S(index_pt_conditie) = 0;
  S(!index_pt_conditie) = delta(!index_pt_conditie) ./ C_max(!index_pt_conditie);
  V = C_max;
  HSV(:,:,1) = H;
  HSV(:,:,2) = S;
  HSV(:,:,3) = V;
end