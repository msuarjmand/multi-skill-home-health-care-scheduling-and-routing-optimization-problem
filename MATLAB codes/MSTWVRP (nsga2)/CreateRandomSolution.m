function q=CreateRandomSolution(model)

    I=model.I;
    K=model.K;
    
    q=randperm(I+K-1);

end