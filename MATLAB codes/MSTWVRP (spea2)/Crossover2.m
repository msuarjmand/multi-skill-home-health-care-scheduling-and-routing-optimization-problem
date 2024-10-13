function [y1 y2]=Crossover2(x1,x2)



        RS1=x1.RS;
        L=x1.L;
        C=x1.C;
        activity=x1.activity;
        
        RS2=x2.RS;


%%

      METHOD=randi([1 3]);

      switch METHOD
             case 1
            
                 %one point

                n=numel(RS1(1,:));
                i=randsample(n,2);

                RSnew1=[RS1(:,1:i) RS2(:,i+1:end)];
                RSnew2=[RS2(:,1:i) RS1(:,i+1:end)];

            
             case 2

                 %two point
            
                   n=numel(RS1(1,:));
                   I=randsample(n,2);
                   i1=min(I);
                   i2=max(I);
                   
                RSnew1=[RS1(:,1:i1) RS2(:,i1+1:i2) RS1(:,i2+1:end)];
                RSnew2=[RS2(:,1:i1) RS1(:,i1+1:i2) RS2(:,i2+1:end)];
                
             case 3
              
                  %uniform
            
                    n=numel(RS1(1,:));
                    i1=randi([0 1],1,n);
                    RSnew1=zeros(size(RS1));
                                       
                    for j=1:n
                       if i1==0
                           RSnew1(:,j)=RS1(:,j);
                       else
                           RSnew1(:,j)=RS2(:,j);
                       end
                        
                    end
                    
                    i2=randi([0 1],1,n);
                    RSnew2=zeros(size(RS2));
                                       
                    for k=1:n
                       if i2==0
                           RSnew2(:,k)=RS1(:,k);
                       else
                           RSnew2(:,k)=RS2(:,k);
                       end
                        
                    end
            
      end
    

%%

    p11=RSnew1(1,:);                         
    p12=RSnew1(2:end,:);                     
    [~,q1]=sort(p11);                         
                    
    p21=RSnew2(1,:);                         
    p22=RSnew2(2:end,:);                     
    [~,q2]=sort(p21);                         


    D1=cell(1,n);                      
    D2=cell(1,n);                      

  
     for i=q1

         w=[];              
         a=1;          
         for j=L{i}
             aw=C{j};    
                         
            for k=1:activity(i,j)                
                aw=aw(~ismember(aw,w));
                x=cumsum((1/(numel(aw)-(k-1))).*ones(1,(numel(aw)-(k-1))));  
                f=find(p12(a,i)<=x,1,'first');
                w=[w aw(f)];    %#ok
                aw(f)=[]; 
                a=a+1;                
            end           
         end
         
         D1{i}=w;
        
     end
     
     
     for i=q2

         w=[];              
         a=1;          
         for j=L{i}
             aw=C{j};    
                         
            for k=1:activity(i,j)                
                aw=aw(~ismember(aw,w));
                x=cumsum((1/(numel(aw)-(k-1))).*ones(1,(numel(aw)-(k-1))));  
                f=find(p22(a,i)<=x,1,'first');
                w=[w aw(f)];    %#ok
                aw(f)=[]; 
                a=a+1;                
            end           
         end
         
         D2{i}=w;
        
     end
    



%%
                
    y1.q=q1;
    y1.D=D1;
    y1.C=C;
    y1.L=L;
    y1.RS=RSnew1;
    y1.activity=activity;  
    
    y2.q=q2;
    y2.D=D2;
    y2.C=C;
    y2.L=L;
    y2.RS=RSnew2;
    y2.activity=activity;


end





