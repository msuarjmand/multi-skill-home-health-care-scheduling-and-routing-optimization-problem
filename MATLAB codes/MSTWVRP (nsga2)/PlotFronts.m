function PlotFronts(pop,F)

    Costs=GetCosts(pop);
    
    nF=numel(F);
    
    h=linspace(0,2/3,nF);
    
    LEGENDS=cell(1,nF);
    
    for f=1:nF
        
        COLOR=hsv2rgb([h(f) 1 1]);
        
        plot(Costs(1,F{f}),Costs(2,F{f}),'*','Color',COLOR);
        hold on;
        
        LEGENDS{f}=['F_{' num2str(f) '}'];
        
    end
    hold off;
    
    legend(LEGENDS,'Location','NorthEastOutside');
    

end