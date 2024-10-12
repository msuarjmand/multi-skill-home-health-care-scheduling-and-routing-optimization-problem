function b=Dominates(p,q)

    if isstruct(p)
        p=p.Cost;
    end
    
    if isstruct(q)
        q=q.Cost;
    end

    b=all(p<=q) && any(p<q);

end