function sol=ParseSolution(q,model)

    I=model.I;
    K=model.K;
    M=model.M;
    d=model.d;
    d0=model.d0;
    r=model.r;
    c=model.c;
    v=model.v;
    t1=model.t1;
    t2=model.t2;
    p=model.p;
    pt=model.pt;
    
    
    DelPos=find(q>I);
    
    From=[0 DelPos]+1;
    To=[DelPos I+K]-1;
    
    L=cell(K,1);
    D=zeros(1,K);

    AT=zeros(1,I);
   
    for k=1:K
        L{k}=q(From(k):To(k));
        
        if ~isempty(L{k})
            
            D(k)=d0(L{k}(1));
             tt=0;  
            for kk=1:numel(L{k})
                           
                 AT(L{k}(kk))=D(k)/v(k)+tt;
                 tt=tt+pt(L{k}(kk));
                if kk<numel(L{k})
                    D(k)=D(k)+d(L{k}(kk),L{k}(kk+1));
                end
            end
            
            D(k)=D(k)+d0(L{k}(end));
            
            

        end
    end
    

    
   ED=zeros(1,I);
    for i=1:I
        ED(i)=max(0,floor((AT(i)-t1(i))/p(i)));         
    end
    
    TWV=floor(sum(t2./p));
    
    
    


%% Output parameters

    sol.L=L;
    sol.D=D;
    sol.M=M;
    sol.MaxD=max(D);
    sol.TotalD=sum(D);
    sol.AT=AT;
    sol.TWV=TWV;
    sol.ED=ED;


    
end
