function oM = rotateMesh( m , angle , axis )

  switch axis
    case 1
      rotation = [ 1 , 0          ,  0 ; ...
                   0 , cos(angle) , -sin(angle) ; ...
                   0 , sin(angle) ,  cos(angle) ];

    case 2
      rotation = [ cos(angle) , 0 ,  -sin(angle) ; ...
                   0 ,          1 ,   0 ; ...
                   sin(angle) , 0 ,   cos(angle) ];

    case 3
      rotation = [ cos(angle) , -sin(angle) , 0 ; ...
                   sin(angle) ,  cos(angle) , 0 ; ...
                   0          ,  0          , 1 ];
  end

  oM = triangulation( m.ConnectivityList , ( rotation * m.Points' )' );

end