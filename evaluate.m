function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  path_to_testset_cats = strcat(path_to_testset, 'cats/');
  x_cats = getImgNames(path_to_testset_cats);
  [n_cats m_cats] = size(x_cats);
  path_to_testset_not_cats = strcat(path_to_testset, 'not_cats/');
  x_not_cats = getImgNames(path_to_testset_not_cats);
  [n_not_cats m_not_cats] = size(x_not_cats);
  if(strcmp(histogram, 'RGB') == 1)
    %pentru cazul in care e RGB
    ok = 1;
  else
    %pentru cazul in care e HSV
    ok = 2;
  end
  cazuri_reusite = 0;
  cazuri_totale = n_cats + n_not_cats;
  for i = 1 : n_cats
    %deschid imaginea din cats
    in = strcat(path_to_testset_cats, x_cats(i,:));
    if(ok == 1)
      imagine = rgbHistogram(in, count_bins);
    else
      imagine = hsvHistogram(in, count_bins);
    end
    %evaluez daca e pisica, daca este adun 1 la cazuri reusite, daca nu, nu adun
    imagine_tilda = [imagine 1];
    imagine_tilda = imagine_tilda';
    y = w' * imagine_tilda;
    if (y >= 0)
      cazuri_reusite = cazuri_reusite + 1;
    end
  end
  for i = n_cats + 1 : n_not_cats + n_cats
    in = strcat(path_to_testset_not_cats, x_not_cats(i - n_cats,:));
    if(ok == 1)
      imagine = rgbHistogram(in, count_bins);
    else
      imagine = hsvHistogram(in, count_bins);
    end
    imagine_tilda = [imagine 1];
    imagine_tilda = imagine_tilda';
    y = w' * imagine_tilda;
    if (y < 0)
      cazuri_reusite = cazuri_reusite + 1;
    end
  end
  percentage = double(cazuri_reusite) / cazuri_totale;
endfunction