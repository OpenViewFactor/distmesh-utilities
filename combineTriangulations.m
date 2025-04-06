function oM = combineTriangulations(m1, m2)
  points = [m1.Points ; m2.Points];
  connectivity = [m1.ConnectivityList ; m2.ConnectivityList + size(m1.Points,1)];
  oM = triangulation(connectivity, points);
end