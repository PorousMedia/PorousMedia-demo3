% this function generates the coodinates of the new pore.
function addPore = newPoreCood(poreCood, poreRad, newPoreRad, xyzRange, ptl)
% poreCood is a 1X3 array that contains the x,y,z coodinates of the existing pore

% poreRad is radius of the existing pore

% newPoreRad is the radius of the new pore

% xyzRange is half the designated length scale the rock domain in all
% directions. since the digital rock is centerd at 0, the spatial
% length of the rock along the X goes from -xyzRange to +xyzRange.Note
% the rock domain is a perfect cube so this length scale is thee same in all directions.

% defining the extreme limits of the incoming pore along the Y axis
b = poreCood(1,2) - (poreRad+newPoreRad+ptl);
a = poreCood(1,2) + (poreRad+newPoreRad+ptl);

% defining the extreme limits of the incoming pore along the Z axis
b2 = poreCood(1,3) - (poreRad+newPoreRad+ptl);
a2 = poreCood(1,3) + (poreRad+newPoreRad+ptl);

% the trigger vairable is only a jump start for the while loop
trigger=0;
while trigger==0 || wallCon(tempData2, xyzRange) == 1
    trigger= 1;
    
    % initializing the Y and Z coodinates to jumpstart the while loop
    tempY2 = -100000;
    tempZ2 = -100000;
    while tempY2 < -xyzRange || tempY2 > xyzRange || tempZ2 < -xyzRange || tempZ2 > xyzRange
        tempY2 = (b-a).*rand(1) + a; % random from uniform distribution between the range of maximum values and within range the Y direction
        tempZ2 = (b2-a2).*rand(1) + a2; % random from uniform distribution between the range of maximum values and within range the Z direction
    end
    
    % assigning the variables for the cordinates in the existing pore  
    tempZ1 = poreCood(1,3);
    tempY1 = poreCood(1,2);
    tempX1 = poreCood(1,1);
    
    % logic to place randomly find the distance between the two pores
%     mn = max([poreRad, newPoreRad])*1.01; % extra 1% to ensure there is a bit of space to promote limited pore connection to a single pore
%     mx = (poreRad + newPoreRad)*0.95; % extra 5% to ensure there is a minimum reasonable overlap between pores to prevent the mesh from crashing dues to self-intersection
    disL = (poreRad + newPoreRad)+ptl; % random distnce betwen the two pores based on mn and mx

    % math to estimate the corresponding x location of the new pore
    tempX2a = tempX1 + sqrt(disL^2 - tempY1^2 + 2*tempY1*tempY2 - tempY2^2 - tempZ1^2 + 2*tempZ1*tempZ2 - tempZ2^2);
    tempX2b = tempX1 - sqrt(disL^2 - tempY1^2 + 2*tempY1*tempY2 - tempY2^2 - tempZ1^2 + 2*tempZ1*tempZ2 - tempZ2^2);
    tempX2a = real(tempX2a);
    tempX2b = real(tempX2b);
    
    % Randomly select one of the two solutions and alternate if it is out of range
    tempX2 = [tempX2a,tempX2b];
    tempX2 = tempX2(randperm(length(tempX2)));
    if tempX2(1,1) > -xyzRange  &&	tempX2(1,1) < xyzRange
        tempX2 = tempX2(1,1);
    else
        tempX2 = tempX2(1,2);
    end
    
    if tempX2 > xyzRange || tempX2 < -xyzRange
        trigger = 0;
    end
    tempData2 = [tempX2,tempY2,tempZ2,newPoreRad];
end

% return coordinates of new pore
addPore = [tempX2,tempY2,tempZ2];
end
