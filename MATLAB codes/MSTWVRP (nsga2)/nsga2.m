clc;
clear;
close all;

tic;

%% Problem Definition

model=CreateModel();

model.eta=0.1;

CostFunction=@MyCost;

%% NSGA-II Settings

MaxIt=100;

nPop=10;

pCrossover=0.5;
nCrossover=round(pCrossover*nPop/2)*2;

pMutation=0.5;
nMutation=round(pMutation*nPop);

TournamentSelectionSize=2;

%% Initialization

individual.Position=[];
individual.Cost=[];
individual.Sol=[];
individual.Rank=[];
individual.CrowdingDistance=[];
individual.DominationSet=[];
individual.DominatedCount=[];

pop=repmat(individual,nPop,1);

for i=1:nPop
    pop(i).Position=CreateRandomSolution(model);
    [pop(i).Cost, pop(i).Sol]=CostFunction(pop(i).Position,model);
end

[pop, F]=NonDominatedSorting(pop);

pop=CalcCrowdingDistance(pop,F);

[pop, F]=SortPopulation(pop);

% A=[pop.Cost]';
%     [a1,a2,a3]=unique(A(:,1));
%     b=unique(a3);
%     nb=numel(b);
%     C=zeros(nb,2);
    
     
%     for i=1:nb
%         C(i,1)=a1(i);
%         f=find(a3==i,1,'first');
%         C(i,2)=A(f,2);
%     end


figure(1);
PlotFronts(pop,F);


% MID=zeros(MaxIt+1,1);
% MID(1)=sum(sqrt(C(:,1).^2+C(:,2).^2)/nb);



%% NSGA-II Main Loop

for it=1:MaxIt
    
    % Crossover
      pop2=repmat(individual,nCrossover/2,2);
      for k=1:nCrossover/2
  
          
          i1=TournamentSelection(pop);
          i2=TournamentSelection(pop);

          p1=pop(i1);
          p2=pop(i2);
            
           [pop2(k,1).Position, pop2(k,2).Position]=PermutationCrossover(p1.Position,p2.Position);         
           [pop2(k,1).Cost, pop2(k,1).Sol]=CostFunction(pop2(k,1).Position,model);
           [pop2(k,2).Cost, pop2(k,2).Sol]=CostFunction(pop2(k,2).Position,model);
  
      end
      pop2=pop2(:);
     
     % Mutation
      pop3=repmat(individual,nMutation,1);
      for k=1:nMutation
          
           i=TournamentSelection(pop);         

           pop3(k).Position=CreateNeighbor(pop(i).Position);
           [pop3(k).Cost, pop3(k).Sol]=CostFunction(pop3(k).Position,model); 
                   
      end
        
    
    % Merge Populations
    pop=[pop
         pop2
         pop3         
         ]; %#ok
    
    % Non-Dominated Sorting
    [pop, F]=NonDominatedSorting(pop);

    % Calculate Crowding Distance
    pop=CalcCrowdingDistance(pop,F);    
    
    % Sort
    [pop F]=SortPopulation(pop); %#ok
    
    % Delete Extra Members
    pop=pop(1:nPop);
    
    % Non-Dominated Sorting
    [pop, F]=NonDominatedSorting(pop);
    
    % Calculate Crowding Distance
    pop=CalcCrowdingDistance(pop,F);
    
    % Sort
    [pop, F]=SortPopulation(pop);

    % Plot Fronts
    figure(1);
    PlotFronts(pop,F);
     grid('on');
    
    % Display Results
    disp(['Iteration ' num2str(it) ': Number of F1 Members = ' num2str(numel(F{1}))]);
    
%     % Objective Function Value
% 
%      A=[pop.Cost]';
%      [a1,a2,a3]=unique(A(:,1));
%      b=unique(a3);
%      nb=numel(b);
%      C=zeros(nb,2);
%      for i=1:nb
%          C(i,1)=a1(i);
%          f=find(a3==i,1,'first');
%          C(i,2)=A(f,2);
%      end
    pause(1);
%      MID(it+1)=sum(sqrt(C(:,1).^2+C(:,2).^2)/nb);

    
    % Plot Solution
%     figure(2);
%     PlotSolution(pop(1).sol,model);
%     
    toc;
    
end

%% Results


% figure(2);
% plot(MID,'-','color','b');








