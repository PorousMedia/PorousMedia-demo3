function plot_pore_body(pore_size_distribution, domain_length)
%This is a function to plot 3D representation of the generated pore
%microstructure. It plots the pore body only and not the pore throats

%   It reads in the pore_size_distribution array expected to contain
%   atleast two rows and atleast four columns
%   The domain_length is half the length of the domain 

    [X,Y,Z] = sphere;
    
    x = pore_size_distribution(1,1);
    y = pore_size_distribution(1,2); 
    z = pore_size_distribution(1,3);
    r = pore_size_distribution(1,4);

    X_ = X * r;
    Y_ = Y * r;
    Z_ = Z * r;
    
    figure('Name','Pore bodies');

    surf(X_+x, Y_+y, Z_+z)
    xlabel('X axis')
    ylabel('Y axis')
    zlabel('Z axis')
    axis equal

    domain_length = domain_length/100;
    axis([-domain_length domain_length -domain_length domain_length -domain_length domain_length])
    pause(0.2)
    shg
    hold on

    for i = 2: size(pore_size_distribution, 1)

        x = pore_size_distribution(i,1);
        y = pore_size_distribution(i,2); 
        z = pore_size_distribution(i,3);
        r = pore_size_distribution(i,4);

        X_ = X * r;
        Y_ = Y * r;
        Z_ = Z * r;

        surf(X_+x, Y_+y, Z_+z)
        pause(1)
        shg

    end
    

end

