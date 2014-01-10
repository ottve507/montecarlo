clc
clear all
%__________________________________________________
%%Monte-carlo simulation of a stock (ABB)

%Initial price
S0=123.8;

%Average return (yearly)
r=0.0082;

%Daily standard deviation (yearly)
stds=0.25400;

%Difference in time (years)
deltat=1;

%Strike price call option
K=120;

%Number of simulations
NS=500;

%Black-Scholes value
d1=(log(S0/K)+(r+(stds^2)/2)*deltat)/(stds*sqrt(deltat));
d2=d1-stds*sqrt(deltat);
BSC=S0*normcdf(d1,0,1)-K*normcdf(d2,0,1)*exp(-r*deltat);

%___________________________________________________
%Comparing different variance reduction techniques

%Matrices for deviations
MCdev=zeros(1,1000);
ANTIdev=zeros(1,1000);
STRATdev=zeros(1,1000);


for j=1:50
%---------- Price of option
    %MC-simulation
    callprice=MC_call_price(S0, r, stds,deltat,K,NS);
    MCdev(j)=abs(callprice-BSC);

    %Antithetic Variable Technique
    callprice=MC_anti(S0, r, stds,deltat,K, NS);
    ANTIdev(j)=abs(callprice-BSC);

    %Stratified Sampling
    callprice=MC_strat(S0, r, stds,deltat,K, NS);
    STRATdev(j)=abs(callprice-BSC);
end

disp('Mean deviations')
MMCdev=mean(MCdev)
MANTIdev=mean(ANTIdev)
MSTRATDEV=mean(STRATdev)
Dev=[MMCdev MANTIdev MSTRATDEV];
Smallestdev=min(Dev);

disp('And the best technique is...')
switch Smallestdev
    case MMCdev
        disp('Regular Monte Carlo');
    case MANTIdev
        disp('Antithetic Variable Technique');
    otherwise
        disp('Stratified sampling');
end





