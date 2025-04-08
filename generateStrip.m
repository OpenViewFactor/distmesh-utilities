function oM = generateStrip(l,h)

  num_triangles = floor(h / l);
  h_1 = h / num_triangles;

  p = zeros(num_triangles*2 + 2, 3);

  p(1,:) = [ l, 0, 0 ];
  p(2,:) = [ 0, 0, 0 ];
  p(end-1,:) = [ l, h, 0 ];
  p(end,:) = [ 0, h, 0 ];
  
  j = 0;
  for i = 3 : size(p,1)-2
    if mod(i,2) == 0
      x = 0;
    else
      x = l;
      j = j + 1;
    end
    p(i,:) = [ x , 0 + h_1 * j , 0 ];
  end

  first_c = zeros(num_triangles*2,3);
  for i = 1 : num_triangles*2
    if mod(i,2) == 0
      first_c(i,:) = (i-2) + [2,4,3];
    else
      first_c(i,:) = (i-1) + [1,2,3];
    end
  end

  num_triangles_per_slice = num_triangles * 2;
  num_points_per_slice = num_triangles * 2 + 2;

  oM = triangulation(first_c, p);

end