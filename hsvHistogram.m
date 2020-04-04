function [sol] = hsvHistogram(path_to_image, count_bins)
  A = imread(path_to_image);
  A = transform_to_HSV(A);
  sol = zeros(1, 3 * count_bins);
  step = 1.01/count_bins;
    for i = 1:count_bins
    binranges = [(i-1) * step i * step];
    %for H
    bincounts = histc(A(:,:,1), binranges);
    sol(1, i) = sum(bincounts(1,:));
    %for S
    bincounts = histc(A(:,:,2), binranges);
    sol(1, i + count_bins) = sum(bincounts(1,:));
    %for V
    bincounts = histc(A(:,:,3), binranges);
    sol(1, i + 2 * count_bins) = sum(bincounts(1,:));
  end
end