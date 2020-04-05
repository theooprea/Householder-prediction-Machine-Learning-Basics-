function [sol] = hsvHistogram(path_to_image, count_bins)
  A = imread(path_to_image);
  A = transform_to_HSV(A);
  sol = zeros(1, 3 * count_bins);
  step = 1.01 / count_bins;
  i = 1 : count_bins;
  binranges = [(i-1) * step i * step];
  bincounts_hue =  histc(A(:,:,1), binranges);
  bincounts_saturation = histc(A(:,:,2), binranges);
  bincounts_value = histc(A(:,:,3), binranges);
  bincounts_hue = sum(bincounts_hue');
  bincounts_saturation = sum(bincounts_saturation');
  bincounts_value = sum(bincounts_value');
  %pt rosu
  sol(1, 1 : count_bins) = bincounts_hue(1, 1 : 2 : 2 * count_bins);
  sol(1, 2 : count_bins) = sol(1, 2 : count_bins) + bincounts_hue(1, 2 : 2 : 2 * count_bins - 1);
  %pt verde
  sol(1, count_bins + 1 : 2 * count_bins) = bincounts_saturation(1, 1 : 2 : 2 * count_bins);
  sol(1, count_bins + 2 : 2 * count_bins) = sol(1, count_bins + 2 : 2 * count_bins) + bincounts_saturation(1, 2 : 2 : 2 * count_bins - 1);
  %pt albastru
  sol(1, 2 * count_bins + 1 : 3 * count_bins) = bincounts_value(1, 1 : 2 : 2 * count_bins);
  sol(1, 2 * count_bins + 2 : 3 * count_bins) = sol(1, 2 * count_bins + 2 : 3 * count_bins) + bincounts_value(1, 2 : 2 : 2 * count_bins - 1);
end