function model=CreateModel()

I=10;
K=3;
M=3;
  
c=randi([0 1],K,M);
r=randi([0 1],I,M);


for kk=1:K
    if c(kk,:)==0
        rr=randi([1 M]);
        c(kk,rr)=1;
    end       
end

for ii=1:I
    if r(ii,:)==0
        rr=randi([1 M]);
        r(ii,rr)=1;
    end       
end
%%
    vmin=10;
    vmax=20;
    v=randi([vmin vmax],1,K);
    
    xmin=0;
    xmax=200;
    dx=xmax-xmin;
    
    ymin=0;
    ymax=100;
    dy=ymax-ymin;
    
    H=sqrt(dx^2+dy^2);
    T=H/mean(v);
    MaxTourTime=I/K*T;
    t1min=round(0.1*MaxTourTime);
    t1max=round(0.3*MaxTourTime);
    t2min=round(0.5*MaxTourTime);
    t2max=round(0.7*MaxTourTime);
    t1=randi([t1min t1max],1,I);
    t2=randi([t2min t2max],1,I);
    
    x=randi([xmin xmax],1,I);
    y=randi([ymin ymax],1,I);
    
    alpha_x=0.1;
    xm=(xmin+xmax)/2;
    x0min=round(xm-alpha_x*dx);
    x0max=round(xm+alpha_x*dx);
    
    alpha_y=0.1;
    ym=(ymin+ymax)/2;
    y0min=round(ym-alpha_y*dy);
    y0max=round(ym+alpha_y*dy);
    
    x0=randi([x0min x0max]);
    y0=randi([y0min y0max]);
    
    d=zeros(I,I);
    d0=zeros(1,I);
    for i=1:I
        for i2=i+1:I
            d(i,i2)=sqrt((x(i)-x(i2))^2+(y(i)-y(i2))^2);
            d(i2,i)=d(i,i2);
        end
        
        d0(i)=sqrt((x(i)-x0)^2+(y(i)-y0)^2);
    end
    
    eta=0.5;

    cf=5*ones(1,K);      % fixed cost
    cv=sum(c,2);         % variable cost
    p=randi([5 20],1,I);
    pt=randi([5 15],1,I);
   
   
    
    %% output
model.I=I;
model.K=K;
model.M=M;
model.r=r;
model.c=c;
model.xmin=xmin;
model.xmax=xmax;
model.ymin=ymin;
model.ymax=ymax;
model.x=x;
model.y=y;
model.x0=x0;
model.y0=y0;
model.d=d;
model.d0=d0;
model.v=v;
model.t1=t1;
model.t2=t2;
model.eta=eta;


model.cf=cf;
model.cv=cv;
model.p=p;
model.pt=pt;

end