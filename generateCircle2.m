function oM = generateCircle2(R, N)

rotation = @(angle) [ cos(angle) , -sin(angle) , 0];

points = [0 0 0];
tris = [];

for i = 1 : 6
    points(end+1, :) = rotation(pi/3*(i-1));
    tris(end+1, :) = [ 1, i+1, mod(i, 6)+2];
end

r = 1;
prevR = 1;
n = 6;
prevN = 1;
theta = 0;
prevTheta = 0;
lastStartingIndex = 2;
startingIndex = 2;

maxDeviation = 1.1; % this part should really be changed

for j = 2 : N
    prevN = n;
    prevTheta = theta;
    prevR = r;
    lastStartingIndex = startingIndex;
    startingIndex = startingIndex+n;

    if 2*pi*(r+2*pi*r/n)/n > 2*pi*r/n*maxDeviation
        for i = 1 : n
            points(end+1, :) = rotation(theta+(2*pi/n*(i-0.5)))*cos(pi/n)*r;
        end
        startingIndex = startingIndex+n;
        n = n * 2;
    end
    
    theta = theta + pi/n;
    r = r + 2*pi*r/n;
    
    for i = 1 : n
        points(end+1, :) = rotation(theta+(2*pi/n*(i-1)))*r;
        if n == prevN
            tris(end+1, :) = [startingIndex+(i-1), startingIndex+mod(i, n), lastStartingIndex+mod(i, n)];
            tris(end+1, :) = [startingIndex+(i-1), lastStartingIndex+mod(i, n), lastStartingIndex+mod(i+n-1, n)];
        else
            tris(end+1, :) = [startingIndex+(i-1), startingIndex+mod(i, n), lastStartingIndex+mod(floor((i)/2), prevN)+mod(i, 2)*(prevN)];
            tris(end+1, :) = [startingIndex+(i-1), lastStartingIndex+mod(floor((i)/2), prevN)+mod(i, 2)*(prevN), lastStartingIndex+mod(floor((i+n-1)/2), prevN)+mod(i+1, 2)*(prevN)];
        end
    end
end

oM = triangulation(tris, points*(R/r));

trisurf(oM , 'EdgeColor' , 'k' , 'LineWidth' , 0.2 , 'FaceColor' , 'k' , 'FaceAlpha', 0.5)
hold on
view(2)
daspect([1,1,1])
pbaspect([1,1,1])
grid off
axis off
hold off