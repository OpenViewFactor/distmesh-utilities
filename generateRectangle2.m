% generate rectangle in strips

function oM = generateRectangle2(L,W,N)

if mod(N,2) == 0
  fprintf("Enter odd value for N\n")
  return
end

short_edge = min(L,W);
long_edge = max(L,W);

strip_base = long_edge / N;
iM = generateStrip( strip_base , short_edge );
iM = translateMesh(iM , [-strip_base/2 , -short_edge/2 , 0]);

oM = iM;

for i = 1 : N - 1

  iM = triangulation( iM.ConnectivityList , [-1,1,1] .* iM.Points );
  iM = flipNormals(iM);
  iM2 = translateMesh( iM , [i*strip_base,0,0] );
  oM = combineTriangulations(oM, iM2);

end

oM = flipNormals(translateMesh(oM , [strip_base/2 , short_edge/2 , 0]));

% trisurf(oM , 'EdgeColor' , 'k' , 'LineWidth' , 0.2 , 'FaceColor' , 'k' , 'FaceAlpha', 0.5)
% hold on
% view(2)
% daspect([1,1,1])
% pbaspect([1,1,1])
% grid off
% axis off
% hold off

end