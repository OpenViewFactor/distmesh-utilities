clear all
clc

r = 1;
N = 20;

perimeter = 2 * pi * r;
single_triangle_arclength = 2*pi / N;
d = r * cos(single_triangle_arclength / 2);
single_triangle_chord_length = 2 * sqrt( r^2 - d^2 );
ring_width = single_triangle_chord_length*cosd(30);
m = generateCircle2(r,N,0);

new_r = d;
new_N = N;
new_ring_width = ring_width;
previous_rotation = 0;
while new_r > 2 * new_ring_width
  new_r = d - (single_triangle_chord_length*cosd(30));
  new_N = new_N - 1;
  perimeter = 2 * pi * new_r;
  single_triangle_arclength = 2*pi / new_N;
  d = new_r * cos(single_triangle_arclength / 2);
  single_triangle_chord_length = 2 * sqrt( new_r^2 - d^2 );
  m2 = generateCircle2( new_r , new_N , previous_rotation + single_triangle_arclength/2);
  previous_rotation = previous_rotation + single_triangle_arclength/2;
  m = combineTriangulations(m,m2);
  new_ring_width = single_triangle_chord_length*cosd(30);
end


trisurf(m,'EdgeColor','k','FaceColor','none','LineWidth',1)
daspect([1,1,1])
view(2)
grid off
axis off