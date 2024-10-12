function [pop F]=SortPopulation(pop)

    CD=[pop.CrowdingDistance];
    [CD CDSO]=sort(CD,'descend');
    pop=pop(CDSO);
    
    R=[pop.Rank];
    [R RSO]=sort(R);
    pop=pop(RSO);
    
    nF=max(R);
    F=cell(1,nF);
    for f=1:nF
        F{f}=find(R==f);
    end


end