function d = drectangle(p, data)
  d = -min(min(min(-data(3)+p(:,2),data(4)-p(:,2)), -data(1)+p(:,1)), data(2)-p(:,1));
end