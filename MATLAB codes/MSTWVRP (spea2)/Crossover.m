function [y1 y2]=Crossover(x1,x2)


      r1=sort(rand(1,size(x1,2)));
      r2=sort(rand(1,size(x2,2)));
      x1_hat=r1(x1);
      x2_hat=r2(x2);


      METHOD=randi([1 2]);

      switch METHOD
             case 1
            
                 %one point
            
                 cut_point=randi([1 size(x1,2)]);   %2= size rooye sotoon
                 y1_hat=[x1_hat(1:cut_point) x2_hat(cut_point+1:end)];
                 y2_hat=[x2_hat(1:cut_point) x1_hat(cut_point+1:end)];


            
             case 2

                 %two point
            
                 cc=randsample(size(x1,2),2);
                 c1=min(cc);
                 c2=max(cc);

                 y1_hat=[x1_hat(1:c1) x2_hat(c1+1:c2) x1_hat(c2+1:end)];
                 y2_hat=[x2_hat(1:c1) x1_hat(c1+1:c2) x2_hat(c2+1:end)];
   
            
      end
    
                [~,y1]=sort(y1_hat);
                [~,y2]=sort(y2_hat);
                
    
    

end





