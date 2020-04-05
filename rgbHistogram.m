function [sol] = rgbHistogram(path_to_image, count_bins)
  A = imread(path_to_image);
  sol = zeros(1, 3 * count_bins);
  step = 256/count_bins;
  i = 1 : count_bins;
  binranges = [(i-1) * step i * step];
  bincounts_red =  histc(A(:,:,1), binranges);
  bincounts_green = histc(A(:,:,2), binranges);
  bincounts_blue = histc(A(:,:,3), binranges);
  bincounts_red = sum(bincounts_red');
  bincounts_green = sum(bincounts_green');
  bincounts_blue = sum(bincounts_blue');
  %pt rosu
  sol(1, 1 : count_bins) = bincounts_red(1, 1 : 2 : 2 * count_bins);
  sol(1, 2 : count_bins) = sol(1, 2 : count_bins) + bincounts_red(1, 2 : 2 : 2 * count_bins - 1);
  %pt verde
  sol(1, count_bins + 1 : 2 * count_bins) = bincounts_green(1, 1 : 2 : 2 * count_bins);
  sol(1, count_bins + 2 : 2 * count_bins) = sol(1, count_bins + 2 : 2 * count_bins) + bincounts_green(1, 2 : 2 : 2 * count_bins - 1);
  %pt albastru
  sol(1, 2 * count_bins + 1 : 3 * count_bins) = bincounts_blue(1, 1 : 2 : 2 * count_bins);
  sol(1, 2 * count_bins + 2 : 3 * count_bins) = sol(1, 2 * count_bins + 2 : 3 * count_bins) + bincounts_blue(1, 2 : 2 : 2 * count_bins - 1);
end