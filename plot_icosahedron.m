% plot icosahedron
golden_ratio = (1 + sqrt(5)) / 2;
rectangle_half_height = sqrt( 1 / (1 + golden_ratio^2) );
rectangle_half_width = rectangle_half_height * golden_ratio;
xy_rectangle_vertices = [-rectangle_half_width,  rectangle_half_height, 0; ...
                          rectangle_half_width,  rectangle_half_height, 0; ...
                          rectangle_half_width, -rectangle_half_height, 0; ...
                         -rectangle_half_width, -rectangle_half_height, 0];
xz_rectangle_vertices = [-rectangle_half_height, 0,  rectangle_half_width; ...
                          rectangle_half_height, 0,  rectangle_half_width; ...
                          rectangle_half_height, 0, -rectangle_half_width; ...
                         -rectangle_half_height, 0, -rectangle_half_width];
yz_rectangle_vertices = [0, -rectangle_half_width,  rectangle_half_height; ...
                         0,  rectangle_half_width,  rectangle_half_height; ...
                         0,  rectangle_half_width, -rectangle_half_height; ...
                         0, -rectangle_half_width, -rectangle_half_height];
faces = [1,2,3,4,1];

% if exists(figure(1))
%   clf(1)
% end
figure(1)
patch('Faces', faces, 'Vertices', xy_rectangle_vertices, 'FaceColor', 'r', 'FaceAlpha', 0.9, 'EdgeColor', 'k')
view(3)
daspect([1,1,1])
xticks([-1,0,1]); yticks([-1,0,1]); zticks([-1,0,1]);
hold on
patch('Faces', faces, 'Vertices', xz_rectangle_vertices, 'FaceColor', 'g', 'FaceAlpha', 0.9, 'EdgeColor', 'k')
patch('Faces', faces, 'Vertices', yz_rectangle_vertices, 'FaceColor', 'y', 'FaceAlpha', 0.9, 'EdgeColor', 'k')
icosahedron = generateSphere(1,0);
trisurf(icosahedron, 'FaceColor', 'none', 'EdgeColor', 'k', 'LineWidth', 3);

% clf(2)
figure(2)
icosphere = generateSphere(1,2);
patch('Faces', faces, 'Vertices', xy_rectangle_vertices, 'FaceColor', 'r', 'FaceAlpha', 0.9, 'EdgeColor', 'k')
view(3)
daspect([1,1,1])
xticks([-1,0,1]); yticks([-1,0,1]); zticks([-1,0,1]);
hold on
patch('Faces', faces, 'Vertices', xz_rectangle_vertices, 'FaceColor', 'g', 'FaceAlpha', 0.9, 'EdgeColor', 'k')
patch('Faces', faces, 'Vertices', yz_rectangle_vertices, 'FaceColor', 'y', 'FaceAlpha', 0.9, 'EdgeColor', 'k')
trisurf(icosphere, 'FaceColor', 'none', 'EdgeColor', 'k', 'LineWidth', 3);