function [z sol]=MyCost(q,model)

    global NFE;
    NFE=NFE+1;

    sol=ParseSolution(q,model);
    
    % Input Parameters

    ED=sol.ED;
    TWV=sol.TWV;
    L=sol.L;
    
    M=model.M;
    I=model.I;
    K=model.K;
    pt=model.pt;
    cv=model.cv;
    r=model.r;
    c=model.c;
    d0=model.d0;
    d=model.d;
    cf=model.cf;
    
    z1=abs(1-(sum(ED)/TWV));
    
    SP=zeros(I,K);
    ES=zeros(I,K);
    for k=1:K
        for i=L{k}
            SP(i,k)=sum(max(0,r(i,:)-c(k,:)));
            ES(i,k)=cv(k)*pt(i);
        end
    end

    z2=abs(1-(sum(sum(SP))/(M*I)));
    
    
    CD=zeros(1,K);
   for k=1:K             
        if ~isempty(L{k})            
            CD(k)=d0(L{k}(1))*1;             
            for kk=1:numel(L{k})              
                if kk<numel(L{k})
                    CD(k)=CD(k)+d(L{k}(kk),L{k}(kk+1));
                end
            end           
            CD(k)=CD(k)+d0(L{k}(end));
        end
        CD(k)=CD(k)+cf(k);
   end
    
   z3=sum(CD)+sum(sum(ES));
   
   % Objective Function
   z=[(1/2*(z1+z2)) z3];

   % Output parameters
   sol.z1=z1;
   sol.z2=z2;
   sol.z3=z3;
   
end
