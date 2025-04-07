function [ oM , arc_length , theta , d , chord_length , ring_width , outer_points , inner_points ] = generateRing( outer_points )

num_outer_points = size(outer_points , 1);
N = num_outer_points - 1;


d = norm(outer_points(1,:));
chord_length = norm( outer_points(1,:) - outer_points(2,:) );
r = sqrt(d^2 + chord_length^2 / 4);

arc_length = 2*pi / N;
theta = (pi - arc_length) / 3;
% d = r * cos(arc_length / 2);
% chord_length = 2 * sqrt( r^2 - d^2 );
ring_width = tan(theta) * chord_length / 2;

num_inner_points = num_outer_points;
num_points = num_outer_points + num_inner_points;
inner_points = zeros(num_inner_points,3);

for i = 1 : num_inner_points - 1

  outer_edge = outer_points(i + 1,:) - outer_points(i,:);
  halfway_point = outer_points(i,:) + outer_edge/2;
  normal_vector = -halfway_point ./ norm(halfway_point);
  inner_points(i,:) = halfway_point + normal_vector.*ring_width;

end

inner_points(end,:) = inner_points(1,:);

points = zeros(num_points,3);
points( 1 : num_outer_points , :) = outer_points;
points( num_outer_points + 1 : end , :) = inner_points;

num_triangles = 2*N;
connectivity = zeros(num_triangles,3);

for i = 1 : N

  connectivity(2*(i)-1,:) = [ num_outer_points + i , i , i + 1 ];
  if i < N
    second_index = num_outer_points + i + 1;
  else
    second_index = num_outer_points + 1;
  end
  connectivity(2*(i),:) = [ i + 1 , second_index , num_outer_points + i ];

end

oM = triangulation(connectivity, points);

end