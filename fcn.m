function I= fcn(T, G, V)
clc;
K = 1.38065e-23;   %boltzman constatnt
q = 1.602e-19      %charge of electron
Iscn = 8.21;       %nominal SC current
Vocn = 32.9;       %nominal OC voltage
Kv = -0.123;       %tempreture voltage const
Ki = 0.0032;       %tempreture current const
Ns = 54;           %no of series connected cells
T = T+273;        %operating temp
Tn = 25+273;       %nominal temp
Gn = 1050;         %nominal Irradiance
a = 1.3;           %diode ideality constant
Eg = 1.12;         %band gap of SI @25deg
%G = 1000;          %actual irradition
Rs = 0.221;
Rp = 415.405;
I=0;
Vtn = Ns*(K*Tn/q);

Ion = Iscn/((exp(Vocn/(a*Vtn)))-1);

Io_part =  ((q*Eg/(a*K))*((1/Tn)-(1/T)));
Io = Ion*((Tn/T)^3)*exp(Io_part);
Ipvn = Iscn;

Ipv = (Ipvn + Ki*(T-Tn))*(G/Gn);

Vt = Ns*(K*T/q);
I_part = Io*(exp((V+(I*Rs))/(Vt*a))-1) + ((V+(Rs*I))/Rp);

I= Ipv - I_part;