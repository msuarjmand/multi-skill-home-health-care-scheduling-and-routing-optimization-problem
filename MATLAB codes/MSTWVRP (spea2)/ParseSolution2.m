function sol1=ParseSolution2(sol,model)

    %% 
    
    q=sol.q;
    D=sol.D;

    
    
    N=model.N;
    t=model.t;
    PredList=model.PredList;
    es=model.es;
    worker=model.worker;
    
    
    %% 
    
    q=RepairSchedule(q,model);
    T=sum(t);
    ST=zeros(1,N);
    FT=zeros(1,N);
    NW=numel(worker(:,1));
    W=zeros(NW,T);
    
    
    for i=q
        if ~isempty(PredList{i})
            t1=max(FT(PredList{i}),es(i));
        else
            t1=es(i);
        end
        for tt=t1:T
            workers_are_ready=true;
            
            for d=1:t(i)
                for k=D{i}
                    if W(k,tt+d)==1
                        workers_are_ready=false;
                        break;
                    end
                end
            end
            
            if workers_are_ready
                t2=tt;
                break;
            end
        end
        
        ST(i)=t2;
        
        for d=1:t(i)
            for l=D{i}
               W(l,ST(i)+d)=1;
                
            end
        end
        
        FT(i)=ST(i)+t(i);
        
    end
    
    Cmax=max(FT);
    UW=zeros(1,numel(worker(:,1)));
    
    for o=1:numel(worker(:,1))
       
        if any(W(o,:)==1)
            UW(o)=1;
        end
    end
    
    W=W(:,1:Cmax);
    
    %% 

    
    sol1.q=q;
    sol1.ST=ST;
    sol1.FT=FT;
    sol1.Cmax=Cmax;
    sol1.W=W;
    sol1.UW=UW;

end