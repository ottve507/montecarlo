function callprice = MC_call_price(S0,r,stds,deltat,K,NS)

%Payoff matrix (S-K)
payoff=zeros(1,NS);

for i=1:length(payoff)
        random=randn;
        S=S0*exp((r-(stds^2)/2)*deltat+stds*sqrt(deltat)*random);
        payoff(i)=max(S-K,0);
end

callprice = exp(-r*deltat)*mean(payoff);

