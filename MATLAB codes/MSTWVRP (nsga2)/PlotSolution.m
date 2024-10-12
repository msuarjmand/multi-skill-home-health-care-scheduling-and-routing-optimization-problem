function PlotSolution(sol,model)

    K=model.K;

    xmin=model.xmin;
    xmax=model.xmax;
    ymin=model.ymin;
    ymax=model.ymax;
    
    x=model.x;
    y=model.y;
    x0=model.x0;
    y0=model.y0;
    
    L=sol.L;
    
    Colors=hsv(K);
    
    for k=1:K
        
        if isempty(L{k})
            continue;
        end
        
        X=[x0 x(L{k}) x0];
        Y=[y0 y(L{k}) y0];
        
        Color=0.8*Colors(k,:);
        
        plot(X,Y,'-o',...
            'Color',Color,...
            'LineWidth',2,...
            'MarkerSize',10,...
            'MarkerFaceColor','white');
        hold on;
        
    end

    plot(x0,y0,'ks',...
        'LineWidth',2,...
        'MarkerSize',18,...
        'MarkerFaceColor','yellow');
    
    hold off;
    
end












