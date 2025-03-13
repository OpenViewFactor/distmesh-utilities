% alternative cylinder

function oM = generateCylinder2(r, h, N)
  theta_span = 2*pi / N;
  l = r * sqrt( 2 - 2*cos(theta_span) );
  num_triangles = floor(h / l);
  h_1 = h / num_triangles;
  y_coord = sqrt( r^2 - (l/2)^2 );

  p = zeros(num_triangles*2 + 2, 3);

  p(1,:) = [ l/2, y_coord, -h/2 ];
  p(2,:) = [ -l/2, y_coord, -h/2 ];
  p(end-1,:) = [ l/2, y_coord, h/2 ];
  p(end,:) = [ -l/2, y_coord, h/2 ];
  
  j = 0;
  for i = 3 : size(p,1)-2
    if mod(i,2) == 0
      x = -l/2;
    else
      x = l/2;
      j = j + 1;
    end
    p(i,:) = [ x, y_coord, -h/2 + h_1 * j ];
  end

  first_c = zeros(num_triangles*2,3);
  for i = 1 : num_triangles*2
    if mod(i,2) == 0
      first_c(i,:) = (i-2) + [2,4,3];
    else
      first_c(i,:) = (i-1) + [1,2,3];
    end
  end

  % m = triangulation(first_c,p);
  % trisurf(m)
  % daspect([1,1,1])

  num_triangles_per_slice = num_triangles * 2;
  num_points_per_slice = num_triangles*2 + 2;
  


  all_p = zeros( N * num_points_per_slice , 3);
  all_p( 1 : size(p,1), : ) = p;
  c = zeros( N * num_triangles_per_slice, 3);
  c( 1 : size(first_c,1), : ) = first_c;

  for i = 1 : N-1
    rotation_matrix = [ cos(i*theta_span), -sin(i*theta_span); sin(i*theta_span), cos(i*theta_span) ];
    new_p = p;
    new_c = c( 1 : num_triangles_per_slice , : ) + i * num_points_per_slice;
    if mod(i,2) == 1
      for j = 1 : size(new_p, 1)
        new_p( j , : ) = [-1,1,1].*new_p(j,:);
      end
    end
    new_p( : ,[1,2]) = (rotation_matrix * ( new_p( : ,[1,2])' ) )';
  
    c( (i*num_triangles_per_slice) + (1 : num_triangles_per_slice) , : ) = new_c;
    all_p( (i) * num_points_per_slice + 1 : (i+1) * num_points_per_slice , : ) = new_p;
  end
  
  [all_p, ~, IC] = unique(all_p, 'rows', 'stable');
  c = IC(c);

  for i = 1 : size(c,1)
    normal = cross( all_p( c(i,2) , : ) - all_p( c(i,1) , : ) , all_p( c(i,3) , : ) - all_p( c(i,1) , : ) );
    if (dot( normal, all_p( c(i,1) , : ) ) < 0)
      temp = c(i,1);
      c(i,1) = c(i,2);
      c(i,2) = temp;
    end
  end
  
  oM = triangulation(c, all_p);

  % figure
  % trisurf(oM)
  % daspect([1,1,1])
end