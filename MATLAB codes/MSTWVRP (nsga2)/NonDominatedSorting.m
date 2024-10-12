function [pop F]=NonDominatedSorting(pop)

    nPop=numel(pop);

    F{1}=[];
    for i=1:nPop
        p=pop(i);
        
        p.DominationSet=[];
        p.DominatedCount=0;
        
        for j=[1:i-1 i+1:nPop]
            q=pop(j);
            
            if Dominates(p,q)
                p.DominationSet=[p.DominationSet j];
                
            elseif Dominates(q,p)
                p.DominatedCount=p.DominatedCount+1;
                
            end
            
        end
        
        if p.DominatedCount==0
            p.Rank=1;
            F{1}=[F{1} i];
        end
        
        pop(i)=p;
    end
    
    f=1;
    while true
        
        Q=[];
        
        for i=F{f}
            p=pop(i);
            for j=p.DominationSet
                q=pop(j);

                q.DominatedCount=q.DominatedCount-1;
                
                if q.DominatedCount==0
                    q.Rank=f+1;
                    Q=[Q j];
                end
                
                pop(j)=q;
            end
        end
        
        if isempty(Q)
            break;
        end
        
        F{f+1}=Q;
        f=f+1;
        
    end

end

