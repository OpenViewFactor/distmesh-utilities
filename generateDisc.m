% disc generation
function oM = generateDisc(r,scale)
  [pos, pointers] = distmesh2d(@dcircle, @huniform, r/scale, [-r,-r;r,r],[0,0], [0,0,r]);
  bottom_points = [pos, zeros(length(pos(:,1)),1)];
  oM = triangulation(pointers, bottom_points);
end