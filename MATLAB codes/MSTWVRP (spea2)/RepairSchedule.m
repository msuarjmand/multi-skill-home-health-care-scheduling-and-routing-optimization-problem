function p=RepairSchedule(q,model)

    PredList=model.PredList;

    p=[];
    
    while ~isempty(q)
        
        for i=q
            if all(ismember(PredList{i},p))          %dar har marhale ezve q ra chek mikonad, agar hamye pish niazi ha ok bud , an faaliat ra be p ezafe mikonad
                break;
            end
        end
        
        p=[p i]; % Add i to New List
        
        q(q==i)=[]; % Remove i from Old List
        
    end

end