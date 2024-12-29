function d = dcircle(p, data)
  d = sqrt((p(:,1)-data(1)).^2+(p(:,2)-data(2)).^2)-data(3);
end