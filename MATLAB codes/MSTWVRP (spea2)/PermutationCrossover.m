function [y1 y2]=PermutationCrossover(x1,x2)

    n=numel(x1);
    
    c=randi([1 n-1]);
    
    x11=x1(1:c);
    x12=x1(c+1:end);
    
    x21=x2(1:c);
    x22=x2(c+1:end);
    
    R1=x22(ismember(x22,x11));
    R2=x12(ismember(x12,x21));
    
    x22(ismember(x22,x11))=x21(ismember(x21,R2));
    x12(ismember(x12,x21))=x11(ismember(x11,R1));
    
    y1=[x11 x22];
    y2=[x21 x12];

end