% checks if the pores connect to the designated inlet and outlet
% boundaries. Goal is to
% ensure all pores are connected to the inlet and outlet we want all porosity=
% effective porosity
function check3 = inOutCon (poreData,xRange)
    % poreData is a 1X4 array that contains the x,y,z coodinates and the
    % radius of the pore respectively. 
    
    % xRange is half the designated length scale the rock domain in the X
    % direction. since the digital rock is centerd at 0, the spatial length
    % of the rock along the X goes from -xRange to +xRange. Note the rock
    % domain is a perfect cube so this length scale is thee same in all directions. 

    % defining the extreme limits of the incoming pore
    xMin=poreData(1,1)-poreData(1,4);
    xMax=poreData(1,1)+poreData(1,4);
    
    % detecting if the incoming pore will go past the range of the core
    if xMin<-xRange || xMax>xRange % returns 1 if true and 0 if false
        check3 = 1; 
    else
        check3 = 0;
    end

end