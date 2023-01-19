% checks if two pores are connected. Goal is to prevent isolated pores to
% ensure all pores are connected to each other because we want all porosity=effective porosity 
function check1 = overlap(poreData1, poreData2, ptl)
    % poreData (1&2) is a 1X4 array that contains the x,y,z coodinates and the
    % radius of the pore respectively  

    % distance between the pores
    dist = sqrt((poreData1(1,1)-poreData2(1,1))^2+(poreData1(1,2)-poreData2(1,2))^2+(poreData1(1,3)-poreData2(1,3))^2);
    
    % checking if their is an overlap between the pores, negative means they do not overlap and are seperated by this distance
    over = (poreData1(1,4) + poreData2(1,4)+ptl) - dist;
    
    if over > -0.1 % returns 1 if there is an overlap and 0 if there is no overlap
        check = 1;
    else
        check = 0;
    end
    
    % returns if they overlap, the overlapping length, and the disntance
    % between the center of the pores
    check1 = [check,over,dist];
end