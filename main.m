%mex cec13_func.cpp
close all;
func_num=1;
D=30;  % Dimensions of the Problem
Xmin=-100; % Minimum Search Bounds
Xmax=100; % Maximum Search Bounds
pop_size=30; % Swarm Size
iter_max=1000; % Total number of generations
fileID = fopen('ranking.txt','w');

runs=10; % Total number of times the algorithm required to be experimented
fhd=str2func('cec13_func'); % calling the CEC2013 Benchmark Functions
fbest = zeros(1,runs); % For initialization::: Set it to zeros(a,runs) where a is the number of total functions 

for i=1:28 % i is used for the number of functions to be run
          % Presently it will run the first 5 functions
            % If required to run for only one functions set i = 1:1 or a:a where a is any number from 1-28.    
    func_num=i;
    for j=1:runs % Total number of required runs,  Here it will run for 5 times
    [gbest,gbestval,FES]= PSO_levy_br(fhd,D,pop_size,iter_max,Xmin,Xmax,func_num); % For running the PSO algorithm
    %[gbest,gbestval,FES]= SRPSO_func(fhd,D,pop_size,iter_max,Xmin,Xmax,func_num); % For running the SRPSO algorithm
    %[gbest,gbestval,FES]= pso_simpleF(fhd,D,pop_size,iter_max,Xmin,Xmax,func_num); % For running the SRPSO algorithm
    %[gbest,gbestval,FES]= srpso_randomChaos(fhd,D,pop_size,iter_max,Xmin,Xmax,func_num); % For running the SRPSO algorithm
    %[gbest,gbestval,FES]= srpso_descendingChaos(fhd,D,pop_size,iter_max,Xmin,Xmax,func_num); % For running the SRPSO algorithm
    %[gbest,gbestval,FES]= pso_chaos(fhd,D,pop_size,iter_max,Xmin,Xmax,func_num); % For running the SRPSO algorithm
    %[gbest,gbestval,FES]= pso_descendingChaos(fhd,D,pop_size,iter_max,Xmin,Xmax,func_num); % For running the SRPSO algorithm
    %[gbest,gbestval,FES]= hybrid(fhd,D,pop_size,iter_max,Xmin,Xmax,func_num); % For running the SRPSO algorithm
    %[gbest,gbestval,FES]= chaos_c1c2(fhd,D,pop_size,iter_max,Xmin,Xmax,func_num); % For running the SRPSO algorithm
    %[gbest,gbestval,FES]= ranking(fhd,D,pop_size,iter_max,Xmin,Xmax,func_num);
    fbest(i,j)=gbestval;
        %[i, j] 
    fbest(i,j);
    end
    %i
     f_mean=mean(fbest(i,:))
     
     fprintf(fileID,'%d \n',f_mean);
     %figure
     %boxplot(fbest(i,:));
end
save result fbest f_mean % save the results
fclose(fileID);


