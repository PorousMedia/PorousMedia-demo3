function plot_pore_throats(pore_throat_distribution, domain_length)
%This is a function to plot 3D representation of the generated pore
%microstructure's skeleton. It plots the pore body only the pore throats
%with a ball at the connections

%   It reads in the pore_throat_distribution array expected to contain
%   atleast two rows and atleast six columns
%   The domain_length is half the length of the domain 

    start = pore_throat_distribution(:, 1:3);
    stop = pore_throat_distribution(:, 4:6);

    figure('Name','Pore throats');
   
    X = [start(:,1) stop(:,1)] ;
    Y = [start(:,2) stop(:,2)] ;
    Z = [start(:,3) stop(:,3)] ;

    plot3(X' ,Y' , Z','LineWidth',5)
    xlabel('X axis')
    ylabel('Y axis')
    zlabel('Z axis')
   
    hold on
    axis equal
    plot3(X', Y', Z', '.','MarkerSize',50)
    domain_length = domain_length/100;
    axis([-domain_length domain_length -domain_length domain_length -domain_length domain_length])
    shg

end

