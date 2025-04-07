function oM = generateCircle(r,N)
  
warning ('off','all');

n = N;
while n > 2
  n = n / 2;
  if mod(n,2) ~= 0
    fprintf("Must use a power of 2 for N\n")
    return
  end
end

fprintf("Starting Generation\n")

rotation = @(angle) [ cos(angle) , -sin(angle) , 0;...
                      sin(angle) ,  cos(angle) , 0;...
                      0          ,  0          , 1];

arc_length = 2*pi / N;
theta = (pi - arc_length) / 3;
d = r * cos(arc_length / 2);
chord_length = 2 * sqrt( r^2 - d^2 );
ring_width = tan(theta) * chord_length / 2;

num_outer_points = N+1;

outer_points = zeros(num_outer_points,3);
outer_points(1,:) = [ -chord_length/2 , -d , 0 ];
for i = 1 : num_outer_points-1
  outer_points(i+1,:) = (rotation(i * arc_length) * outer_points(1,:)')';
end

[ oM , arc_length , theta , d , chord_length , ring_width , outer_points , inner_points ] = generateRing( outer_points );

new_r = sqrt( (d-ring_width)^2 + chord_length^2 / 4 );


iteration = 1;
while new_r > 0.0001 * r
  iteration = iteration + 1;

  [ iM , arc_length , theta , d , chord_length , ring_width , outer_points , inner_points ] = generateRing( inner_points );

  if mod(iteration,10) == 0 && mod(size(inner_points,1) - 1, 2) == 0
    iteration = 1;

    inner_points_copy = inner_points(1:end-1,:);
    inner_points_copy(1:end-2,:) = inner_points(3:end-1,:);
    inner_points_copy(end,:) = inner_points(2,:);
    inner_points_copy(end-1,:) = inner_points(1,:);

    edges = inner_points_copy(1:2:end,:) - inner_points(1:2:end-1,:);

    midway_points = inner_points(1:2:end-1,:) + edges/2;

    inner_points(2:2:end-1,:) = midway_points;

    c = iM.ConnectivityList;
    p = iM.Points;
    p( size(outer_points,1)+1 : end , : ) = inner_points;
    iM = triangulation(c,p);

    inner_points = inner_points(1:2:end,:);

  end

  oM = combineTriangulations(oM, iM);

  new_r = sqrt( (d-ring_width)^2 + chord_length^2 / 4 );

end

p = oM.Points;
num_points = size(oM.Points,1);
p(end + 1, :) = [0,0,0];

num_innermost_points = size(inner_points,1);

c = oM.ConnectivityList;
for i = 0 : num_innermost_points-1
  c(end + 1, :) = [ num_points-num_innermost_points+1+i , num_points+1 , num_points-num_innermost_points+1+i+1 ];
end

oM = triangulation(c,p);

trisurf(oM , 'EdgeColor' , 'k' , 'LineWidth' , 0.2 , 'FaceColor' , 'k' , 'FaceAlpha', 0.5)
hold on
view(2)
daspect([1,1,1])
pbaspect([1,1,1])
grid off
axis off
hold off

end