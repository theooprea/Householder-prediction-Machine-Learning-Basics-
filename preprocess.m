function [X, y] = preprocess(path_to_dataset, histogram, count_bins)
  path_to_dataset_cats = strcat(path_to_dataset, 'cats/');
  x_cats = getImgNames(path_to_dataset_cats);
  [n_cats m_cats] = size(x_cats);
  path_to_dataset_not_cats = strcat(path_to_dataset, 'not_cats/');
  x_not_cats = getImgNames(path_to_dataset_not_cats);
  [n_not_cats m_not_cats] = size(x_not_cats);
  X = zeros(n_cats + n_not_cats, count_bins * 3);
  y = zeros(n_cats + n_not_cats, 1);
  if(strcmp(histogram, 'RGB') == 1)
    %pentru cazul in care e RGB
    ok = 1;
  else
    %pentru cazul in care e HSV
    ok = 2;
  end
  for i = 1 : n_cats
    in = strcat(path_to_dataset_cats, x_cats(i,:));
    if(ok == 1)
      X(i,:) = rgbHistogram(in, count_bins);
    else
      X(i,:) = hsvHistogram(in, count_bins);
    end
    y(i) = 1;
  end
  for i = n_cats + 1 : n_not_cats + n_cats
    in = strcat(path_to_dataset_not_cats, x_not_cats(i - n_cats,:));
    if(ok == 1)
      X(i,:) = rgbHistogram(in, count_bins);
    else
      X(i,:) = hsvHistogram(in, count_bins);
    end
    y(i) = -1;
  end
endfunction
