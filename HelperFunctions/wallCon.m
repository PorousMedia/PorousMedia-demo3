% checks if the pores connect to the designated wall boundaries. Goal is to
% prevent dead end pores at the walls because we want all porosity=
% effective porosity
function check2 = wallCon(poreData,xyzRange)

    % poreData is a 1X4 array that contains the x,y,z coodinates and the
    % radius of the pore respectively  
    
    % xyzRange is half the designated length scale the rock domain in all
    % directions. since the digital rock is centerd at 0, the spatial
    % length of the rock along the X goes from -xyzRange to +xyzRange.Note
    % the rock domain is a perfect cube so this length scale is thee same in all directions.   
   
    % defining the extreme limits of the incoming pore
    yMin=poreData(1,2)-poreData(1,4);
    yMax=poreData(1,2)+poreData(1,4);
    zMin=poreData(1,3)-poreData(1,4);
    zMax=poreData(1,3)+poreData(1,4);
    
    % detecting if the incoming pore will go past the range of the core
    if yMin<-xyzRange || yMax>xyzRange || zMin<-xyzRange || zMax>xyzRange 
        check2 = 1; % returns 1 if true and 0 if false
    else
        check2 = 0;
    end

end