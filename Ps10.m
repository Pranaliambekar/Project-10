clc;
clear all;
K = 1.38065e-23;   %boltzman constatnt
q = 1.602e-19      %charge of electron
Iscn = 8.21;       %nominal SC current
Vocn = 32.9;       %nominal OC voltage
Kv = -0.123;       %tempreture voltage const
Ki = 0.0032;       %tempreture current const
Ns = 54;           %no of series connected cells
T = 25+273;        %operating temp
Tn = 25+273;       %nominal temp
Gn = 1050;         %nominal Irradiance
a = 1.3;           %diode ideality constant
Eg = 1.12;         %band gap of SI @25deg
G = 1000;          %actual irradition
Rs = 0.221;
Rp = 415.405;
I=0;
Vtn = Ns*(K*Tn/q);

Ion = Iscn/((exp(Vocn/(a*Vtn)))-1);

Io = Ion*((Tn/T)^3)*exp(((q*Eg/(a*K))*((1/Tn)-(1/T))));

Ipvn = Iscn;

Ipv = (Ipvn + Ki*(T-Tn))*(G/Gn);

Vt = Ns*(K*T/q);

I = zeros(330,1);
i = 1;
I(1,1)=0;

for V=32.9:0.1:0
    
    I_part = Io*(exp((V+(I(i,1)*Rs))/(Vt*a))-1) + ((V+(Rs*I(i,1)))/Rp);
    
    I(i+1)= Ipv - I_part;
    
    V2(i) = V;
    P(i) = V*I(i);
    i = i+1;
end
V2(i)=V2(i-1);
P(i)=P(i-1);
V2=transpose(V2);
plot(V2,I);

