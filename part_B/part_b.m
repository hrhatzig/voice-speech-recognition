clear; clc;

Fs = 10e3; Ts = 1/Fs;    % sampling frequency and period
total_duration = 2;      % total duration time (sec)
phonem_duration = 0.5;   % phonem duration time (sec)

%% B1) 

Tp = 8e-3;
Np = Tp*Fs;

n = (0:8191);
p = zeros(1, 8192);
for i = 1 : 80 : length(p)
    p(i) = 0.9999^i;
end
% figure(1);
% plot(n,p);
% title('Voiced Excitation (time-domain)');
% xlabel('n');
% ylabel('p[n]');

a = (1);
b = zeros(1, 81);
b(1) = 1;
b(81) = -0.9999;

[z, p, k] = tf2zpk(b, a);
% 
% fvtool(a,b);
% fvtool(a,b,'Analysis','polezero');

%%

g = zeros(1, 8192);
for i = 1 : 25
    g(i) = 0.5*(1-cos(pi*(n(i)+1)/25));
end
for i = 26 : 34
    g(i) = cos(0.5*pi*(n(i)-24)/10);
end
% 
% figure(2);
% plot(g(1:50));
% 
% figure(3);
% plot(abs(fft(g)));
% 
% wvtool(g(1:64));
% 
% figure(4);
% zplane(g(1:64));

%% 
f = [570, 840, 2410];
s = 30; %Hz

a = 1;
b = 1;
for k = 1 : 3
  denpoly = [1, -2*exp(-2*pi*s*Tp)*cos(2*pi*f(k)*Tp), exp(-4*pi*s*Tp)];
  b = conv(b, denpoly);
end


% [z, p, k] = tf2zpk([1], den);

fvtool(a, b);
fvtool(a, b, 'Analysis','polezero');

%%

r = zeros(1,16);
r(1) = 1;
r(2) = -0.96;

title('Radiation load r[n]');
fvtool(r);
