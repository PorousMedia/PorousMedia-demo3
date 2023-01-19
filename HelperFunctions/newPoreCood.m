% this function generates the coodinates of the new pore.
function add_pore = newPoreCood(pore_coordinates, pore_radius, new_pore_radius, domain_length, pore_throat_length)
% pore_coordinates is a 1X3 array that contains the x,y,z coodinates of the existing pore

% pore_radius is radius of the existing pore

% new_pore_radius is the radius of the new pore

% domain_length is half the designated length scale the rock domain in all
% directions. since the digital rock is centerd at 0, the spatial
% length of the rock along the X goes from -domain_length to +domain_length.Note
% the rock domain is a perfect cube so this length scale is thee same in all directions.

% defining the extreme limits of the incoming pore along the Y axis
b = pore_coordinates(1,2) - (pore_radius + new_pore_radius + pore_throat_length);
a = pore_coordinates(1,2) + (pore_radius + new_pore_radius + pore_throat_length);

% defining the extreme limits of the incoming pore along the Z axis
b2 = pore_coordinates(1,3) - (pore_radius + new_pore_radius + pore_throat_length);
a2 = pore_coordinates(1,3) + (pore_radius + new_pore_radius + pore_throat_length);

% the trigger vairable is only a jump start for the while loop
trigger=0;
while trigger == 0 || wallCon(data, domain_length) == 1
    trigger = 1;
    
    % initializing the Y and Z coodinates to jumpstart the while loop
    y2 = -100000;
    z2 = -100000;
    while y2 < -domain_length || y2 > domain_length || z2 < -domain_length || z2 > domain_length
        y2 = (b-a) .* rand(1) + a; % random from uniform distribution between the range of maximum values and within range the Y direction
        z2 = (b2-a2) .* rand(1) + a2; % random from uniform distribution between the range of maximum values and within range the Z direction
    end
    
    % assigning the variables for the cordinates in the existing pore  
    z1 = pore_coordinates(1,3);
    y1 = pore_coordinates(1,2);
    x1 = pore_coordinates(1,1);
    
    % logic to place randomly find the distance between the two pores
%     mn = max([pore_radius, new_pore_radius])*1.01; % extra 1% to ensure there is a bit of space to promote limited pore connection to a single pore
%     mx = (pore_radius + new_pore_radius)*0.95; % extra 5% to ensure there is a minimum reasonable overlap between pores to prevent the mesh from crashing dues to self-intersection
    distance = (pore_radius + new_pore_radius)+pore_throat_length; % random distnce betwen the two pores based on mn and mx

    % math to estimate the corresponding x location of the new pore
    x2_a = x1 + sqrt(distance ^2 - y1 ^2 + 2 * y1 * y2 - y2 ^2 - z1 ^2 + 2 * z1 * z2 - z2 ^2);
    x2_b = x1 - sqrt(distance ^2 - y1 ^2 + 2 * y1 * y2 - y2 ^2 - z1 ^2 + 2 * z1 * z2 - z2 ^2);
    x2_a = real(x2_a);
    x2_b = real(x2_b);
    
    % Randomly select one of the two solutions and alternate if it is out of range
    x2 = [x2_a, x2_b];
    x2 = x2(randperm(length(x2)));
    if x2(1,1) > -domain_length  &&	x2(1,1) < domain_length
        x2 = x2(1,1);
    else
        x2 = x2(1,2);
    end
    
    if x2 > domain_length || x2 < -domain_length
        trigger = 0;
    end
    data = [x2, y2, z2, new_pore_radius];
end

% return coordinates of new pore
add_pore = [x2, y2, z2];
end