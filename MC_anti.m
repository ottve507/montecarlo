function callprice = MC_anti(S0,r,stds,deltat,K, NS)

%Average callprices
AVG=zeros(1,NS);

for i=1:NS

random1=randn;
random2=-random1;
       
S1=S0*exp((r-(stds^2)/2)*deltat+stds*sqrt(deltat)*random1);
S2=S0*exp((r-(stds^2)/2)*deltat+stds*sqrt(deltat)*random2);
        
%Callprices
callprice1 = exp(-r*deltat)*max(S1-K, 0);
callprice2 = exp(-r*deltat)*max(S2-K, 0);

AVG(i)=(callprice1+callprice2)/2;
end

callprice=mean(AVG);