% checks if the pores connect to the designated wall boundaries. Goal is to
% prevent dead end pores at the walls because we want all porosity=
% effective porosity
function checker = wallCon(pore_data, domain_length)

    % pore_data is a 1X4 array that contains the x,y,z coodinates and the
    % radius of the pore respectively  
    
    % domain_length is half the designated length scale the rock domain in all
    % directions. since the digital rock is centerd at 0, the spatial
    % length of the rock along the X goes from -domain_length to +domain_length.Note
    % the rock domain is a perfect cube so this length scale is thee same in all directions.   
   
    % defining the extreme limits of the incoming pore
    y_min = pore_data(1,2) - pore_data(1,4);
    y_max = pore_data(1,2) + pore_data(1,4);
    z_min = pore_data(1,3) - pore_data(1,4);
    z_max = pore_data(1,3) + pore_data(1,4);
    
    % detecting if the incoming pore will go past the range of the core
    if y_min < -domain_length || y_max > domain_length || z_min < -domain_length || z_max > domain_length 
        checker = 1; % returns 1 if true and 0 if false
    else
        checker = 0;
    end

end