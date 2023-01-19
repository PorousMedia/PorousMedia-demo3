% ensures pores are connected and the number of pores connected to a single
% pore is minimal. Goal is to prevent concentration of pores in one
% locations as they need to spread through the rock domain.  
function check5 = poreCon(poreData1, poreData2, attempt, ptl)
    % poreData1 is an nX4 array that contains the x,y,z coodinates and the
    % radius of the pore respectively. n depends on the number of already
    % established connected pores
    
    % poreData2 is a 1X4 array that contains the x,y,z coodinates and the
    % radius of the pore respectively 
    
    % attempt is the number of attempts made to cooenct an incoming pore to
    % an existing pore system

    % initiallizing a check detct if a logic is satisfied. the role of the counter is to identify if the number of
    % overlap surpasses the set limit and is greater than 0
    check4 = 0;
    
    % initiallizing a switch to help code detect if there is atleast an overlap or not
    count = 0;
    
    % initial number of overlaps a new pore can have
    lim=1;
    
    % the limit is increased when the number of trials get higher
    if attempt > 40000
        lim=2;
    end
    
%     if attempt > 30000
%         lim=3;
%     end
%     
%     if attempt > 32000
%         lim=4;
%     end
%     
%     if attempt > 35000
%         lim=5;
%     end
%     
%     if attempt > 40000
%         lim=6;
%     end
    
    % identifying the existing pore network to help chenck if poreData2
    % intersect with any of them
    strt= 1;
    stp= size(poreData1,1);
    if strt<1
        strt= 1;
    end
    
    % running the logic check if the pore intersect as few pores as
    % possible
    % if check4==1, logic is not satisfies beacause the number of pore
    % intersections surpasses the set limit
    for x = strt:stp
        temp = overlap(poreData1(x,:),poreData2, ptl);
        if temp(1) == 1
            count= count + 1;
            if count > lim
                check4 = 1;
                break
            end
        end
    end
    
    % also, if there is no overlap "check4 = 1", so it can still go back to
    % finding new cordinate to assign 
    if count == 0
        check4 = 1;
    end
    % return check4, to help determine if the new poreData2 is accepted (0) of
    % not(1)
    check5 = check4;
end