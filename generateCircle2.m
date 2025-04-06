% generate circle 2.0

function oM = generateCircle2(r, N, rot)

perimeter = 2 * pi * r;
single_triangle_arclength = 2*pi / N;
d = r * cos(single_triangle_arclength / 2);
single_triangle_chord_length = 2 * sqrt( r^2 - d^2 );


perimeter_points = -single_triangle_chord_length/2  : single_triangle_chord_length : -single_triangle_chord_length/2 + perimeter;
offset = single_triangle_chord_length * cosd(60);
interior_points = -single_triangle_chord_length/2 + offset : single_triangle_chord_length : -single_triangle_chord_length/2 + perimeter - offset;



rotation_matrix = @(i) [ cos(i*single_triangle_arclength), -sin(i*single_triangle_arclength);...
                         sin(i*single_triangle_arclength), cos(i*single_triangle_arclength)];

rotation = @(angle) [ cos(angle), -sin(angle);...
                         sin(angle), cos(angle)];

p = zeros(length(perimeter_points) + length(interior_points), 3);

p(1,:) = [(rotation(rot) * [-single_triangle_chord_length/2, -d]')' , 0];
p(2,:) = [(rotation(rot) * [-single_triangle_chord_length/2 + offset, -d + single_triangle_chord_length*sind( 60 )]')' , 0];
p(3,:) = [(rotation(rot) * [single_triangle_chord_length/2, -d]')' , 0];

num_rotations = 0;
for i = 4:2:size(p,1)
  num_rotations = num_rotations + 1;
  p(i,[1,2]) = ( rotation_matrix(num_rotations) * p(2,[1,2])' )';
  p(i+1,[1,2]) = ( rotation_matrix(num_rotations) * p(3,[1,2])' )';
end

num_tri = N + N;
c = zeros(num_tri, 3);
for i = 1 : num_tri - 1

  if mod(i,2) == 1
    c(i,:) = [i, i+2, i+1];
  else
    c(i,:) = [i, i+1, i+2];
  end

end
c(end,:) = [num_tri, num_tri + 1, 2];





oM = triangulation(c,p);

end