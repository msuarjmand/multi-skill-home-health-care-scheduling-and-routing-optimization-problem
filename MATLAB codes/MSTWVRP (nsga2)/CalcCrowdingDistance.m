function pop=CalcCrowdingDistance(pop,F)

    nObj=numel(pop(1).Cost);

    nF=numel(F);
    
    for f=1:nF
        
        A=F{f};
        
        C=GetCosts(pop(A));
        
        n=numel(A);
        
        d=zeros(n,nObj);
        
        for j=1:nObj
            
            Cj=C(j,:);
            
            [Cj SO]=sort(Cj);
            
            d(SO(1),j)=inf;
            d(SO(end),j)=inf;
            
            for k=2:n-1
                d(SO(k),j)=(Cj(k+1)-Cj(k-1))/(Cj(end)-Cj(1));
            end
            
        end
        
        for i=1:n
            pop(A(i)).CrowdingDistance=sum(d(i,:));
        end
        
    end

end