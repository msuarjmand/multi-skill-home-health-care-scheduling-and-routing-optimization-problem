function sol=CreateRandomSolution2(model)


    N=model.N;
    activity=model.activity;
    worker=model.worker;
    skill=model.skill;

    
    
    %% 
    
    A=(sum(activity(:,:),2))';          
    RS=rand(max(A)+1,N);                
     
    p1=RS(1,:);                         
    p2=RS(2:end,:);                     
     
    [~,q]=sort(p1);                     

    
    %%
    
    
   
    C=cell(1,skill);                  
    D=cell(1,N);                      
    L=cell(1,N);                      
    


    
     for o=1:skill
         
         C{o}=find(worker(:,o)==1);
         
     end
     
    
     for i=q
        
         L{i}=find(activity(i,:)~=0);             
            w=[];    
            
            a=1;

            
         for j=L{i}
             aw=C{j};    
             
             
            for k=1:activity(i,j) 
                
                aw=aw(~ismember(aw,w));
                x=cumsum((1/(numel(aw)-(k-1))).*ones(1,(numel(aw)-(k-1))));  
                f=find(p2(a,i)<=x,1,'first');
                w=[w aw(f)];    %#ok
                aw(f)=[]; 
                a=a+1;
                
            end 
           
         end
         
         D{i}=w;
        
     end
    %%
    
    
    sol.q=q;
    sol.D=D;
    sol.C=C;
    sol.L=L;
    sol.RS=RS;
    sol.activity=activity;
    sol.worker=worker;



end

