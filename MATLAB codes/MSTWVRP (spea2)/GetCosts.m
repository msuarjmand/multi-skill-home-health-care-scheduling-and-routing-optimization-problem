function Costs=GetCosts(pop)

    nObj=numel(pop(1).Cost);

    Costs=[pop.Cost];

    Costs=reshape(Costs,nObj,[]);
    
end