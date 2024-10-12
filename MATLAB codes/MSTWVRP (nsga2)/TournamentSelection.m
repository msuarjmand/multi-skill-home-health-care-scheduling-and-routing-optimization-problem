function i=TournamentSelection(pop,m)

    if nargin<2
        m=2;
    end

    nPop=numel(pop);
    
    m=round(min(max(m,1),nPop));
    
    jj=randperm(nPop);
    jj=jj(1:m);
    
    i=jj(1);
    
    for k=2:m
        
       if pop(jj(k)).Rank<pop(i).Rank
           i=jj(k);
       elseif pop(i).Rank<pop(jj(k)).Rank
           % do nothing
       else 
           if pop(jj(k)).CrowdingDistance>pop(i).CrowdingDistance
               i=jj(k);
           else
               % do nothing
           end
       end
    end
    
    
%     Costs=[pop(jj).Cost];
%     
%     [min_Cost min_Cost_index]=min(Costs); %#ok
%     
%     i=jj(min_Cost_index);

end