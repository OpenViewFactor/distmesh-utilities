function oM = generateCylinder(r, h, N)
  theta_span = 2*pi / N;
  l = r * sqrt( 2 - 2*cos(theta_span) );
  
  equilateral_l = l / sin(pi/3);
  num_full_equilaterals = floor(h / equilateral_l);
  centerline_offset = sqrt( (equilateral_l/2)^2 - (l/2)^2 );
  initial_point_offset = centerline_offset + (num_full_equilaterals - 2)*equilateral_l/2;
  
  p = zeros(num_full_equilaterals, 3);
  p(1,1) = h/2 + initial_point_offset;
  p(1,2) = h/2 - initial_point_offset;
  
  for i = 2 : num_full_equilaterals
    p(i,1) = p(i-1,1) - equilateral_l;
    p(i,2) = p(i-1,2) + equilateral_l;
  end
  
  p(:,1) = sort(p(:,1),"ascend");
  p(:,2) = sort(p(:,2),"ascend");
  
  num_points_one_slice = (num_full_equilaterals*2 + 4);
  
  all_p = zeros( N * num_points_one_slice , 3);
  y_coord = sqrt( r^2 - (l/2)^2 );
  all_p(1,:) = [l/2,y_coord,0];
  all_p(2,:) = [-l/2,y_coord,0];
  all_p(num_points_one_slice-1,:) = [l/2,y_coord,h];
  all_p(num_points_one_slice,:) = [-l/2,y_coord,h];
  
  for i = 3 : (num_points_one_slice - 2)
    if (mod(i,2) == 0)
      x_coord = -l/2;
      z_coord = p( (i-2)/2, 2);
    else
      x_coord = l/2;
      z_coord = p(ceil( (i-2)/2 ), 1);
    end
    all_p(i,:) = [x_coord,y_coord,z_coord];
  end
  
  first_rectangle_p = all_p( 1 : num_points_one_slice , : );
  
  num_tri_one_slice = num_full_equilaterals*2 + 2;
  c = zeros(num_tri_one_slice*2, 3);
  for i = 1 : num_tri_one_slice
    c(i,:) = [i, i+1, i+2];
  end
  
  for i = 1 : N-1
    rotation_matrix = [ cos(i*theta_span), -sin(i*theta_span); sin(i*theta_span), cos(i*theta_span) ];
    new_p = first_rectangle_p;
    new_c = c( 1 : num_tri_one_slice , : ) + i * num_points_one_slice;
    if mod(i,2) == 1
      for j = 1 : size(new_p, 1)
        new_p( j , : ) = [-1,1,1].*new_p(j,:);
      end
    end
    new_p( : ,[1,2]) = (rotation_matrix * ( new_p( : ,[1,2])' ) )';
  
    c( (i*num_tri_one_slice) + (1 : num_tri_one_slice) , : ) = new_c;
    all_p( (i) * num_points_one_slice + 1 : (i+1) * num_points_one_slice , : ) = new_p;
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
end

% function output_mesh = generateCylinder(zmin, zmax, thmax, r, baseCenter, scale)
%   [theta_z_positions, connections] = distmesh2d(@drectangle, ...
%     @huniform, ...
%     min([zmax-zmin,thmax*r])/scale, ...
%     [zmin,0;zmax,thmax*r], ...
%     [zmin,0; zmax,0; zmin,thmax*r; zmax,thmax*r], ...
%     [zmin,zmax,0,thmax*r]);
% 
%   positions = [baseCenter(1) + cos(theta_z_positions(:,2)/r) .* r, ...
%                baseCenter(2) + sin(theta_z_positions(:,2)/r) .* r, ...
%                theta_z_positions(:,1)];
%   output_mesh = triangulation(connections, positions);
% end