clc;
clear;
close all;

tic;

%% Problem Definition

model=CreateModel();

model.eta=0.1;

CostFunction=@MyCost;

%% SPEA2 Settings

MaxIt=50;        % Maximum Number of Iterations

nPop=50;            % Population Size

nArchive=40;        % Archive Size

K=round(sqrt(nPop+nArchive));  % KNN Parameter

pCrossover=0.6;
nCrossover=round(pCrossover*nPop/2)*2;

pMutation=1-pCrossover;
nMutation=nPop-nCrossover;


%% Initialization

empty_individual.Position=[];
empty_individual.Cost=[];
empty_individual.sol=[];
empty_individual.S=[];
empty_individual.R=[];
empty_individual.sigma=[];
empty_individual.sigmaK=[];
empty_individual.D=[];
empty_individual.F=[];

pop=repmat(empty_individual,nPop,1);
for i=1:nPop
    
    % Initialize Position
    pop(i).Position=CreateRandomSolution(model);
    
    % Evaluation
    [pop(i).Cost pop(i).sol]=CostFunction(pop(i).Position,model);
    
end

archive=[];

%% Main Loop

for it=1:MaxIt
    
    Q=[pop
       archive];
    
    nQ=numel(Q);
    
    dom=false(nQ,nQ);
    
    for i=1:nQ
        Q(i).S=0;
    end
    
    for i=1:nQ
        for j=i+1:nQ
            
            if Dominates(Q(i),Q(j))
                Q(i).S=Q(i).S+1;
                dom(i,j)=true;
                
            elseif Dominates(Q(j),Q(i))
                Q(j).S=Q(j).S+1;
                dom(j,i)=true;
                
            end
            
        end
    end
    
    S=[Q.S];
    
    for i=1:nQ
        Q(i).R=sum(S(dom(:,i)));
    end
    
    Z=[Q.Cost]';
    SIGMA=pdist2(Z,Z,'seuclidean');
    SIGMA=sort(SIGMA);
    for i=1:nQ
        Q(i).sigma=SIGMA(:,i);
        Q(i).sigmaK=Q(i).sigma(K);
        Q(i).D=1/(Q(i).sigmaK+2);
        Q(i).F=Q(i).R+Q(i).D;
    end
    
    nND=sum([Q.R]==0);
    if nND<=nArchive
        F=[Q.F];
        [F, SO]=sort(F);
        Q=Q(SO);
        archive=Q(1:min(nArchive,nQ));
        POP=Q(min(nArchive,nQ)+1:end);
    else
        SIGMA=SIGMA(:,[Q.R]==0);
        archive=Q([Q.R]==0);
        
        k=2;
        while numel(archive)>nArchive
            while min(SIGMA(k,:))==max(SIGMA(k,:)) && k<size(SIGMA,1)
                k=k+1;
            end
            
            [~, j]=min(SIGMA(k,:));
            
            archive(j)=[];
            SIGMA(:,j)=[];
        end
        
    end
    
    PF=archive([archive.R]==0); % Approximate Pareto Front
    
    % Plot Pareto Front
    figure(1);
    PFC=[PF.Cost];
    plot(PFC(1,:),PFC(2,:),'*');
    xlabel('f_1');
    ylabel('f_2');
    grid('on');
    % Display Iteration Information
    disp(['Iteration ' num2str(it) ': Number of PF members = ' num2str(numel(PF))]);
    
    if it>=MaxIt
        break;
    end
    pause(1);
    % Crossover
    popc=repmat(empty_individual,nCrossover/2,2);
    for c=1:nCrossover/2
        
        p1=BinaryTournamentSelection(archive,[archive.F]);
        p2=BinaryTournamentSelection(archive,[archive.F]);
        
        [popc(c,1).Position, popc(c,2).Position]=PermutationCrossover(p1.Position,p2.Position);
        
        [popc(c,1).Cost popc(c,1).sol]=CostFunction(popc(c,1).Position,model);
        [popc(c,2).Cost popc(c,2).sol]=CostFunction(popc(c,2).Position,model);
        
    end
    popc=popc(:);
    
    % Mutation
    popm=repmat(empty_individual,nMutation,1);
    for m=1:nMutation
        
        p=BinaryTournamentSelection(archive,[archive.F]);
        
        popm(m).Position=CreateNeighbor(p.Position);
        
        [popm(m).Cost popm(m).sol]=CostFunction(popm(m).Position,model);
        
    end
    
    % Create New Population
    pop=[popc
         popm];
     
     
     toc;
    
end



