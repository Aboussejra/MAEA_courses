clear all;
a = 0;
b = 2;%%
T = 1.;
M = 99;
k = 0.01;
h=(b-a)/M;
ksurh = k/h;
N=T/k;  
beta=1.;
x= a + (1:M)*h;
u0 = exp(-5*((5*x-1).^2));
uan = exp(-5*((5*(x-beta*T)-1).^2));

% We need to write the system as A*Unew = B*Uold

uold = u0';
unew = u0';
n = 10;
A = full(gallery('tridiag',M,-k*beta/(4*h),1,k*beta/(4*h)));
B = full(gallery('tridiag',M,k*beta/(4*h),1,-k*beta/(4*h)));

for i=1:N;
    unew = inv(A)*B*uold;
    % on approche unew(M+1) selon le schéma de courant
    unew(M) = (1 - k*beta/h)*uold(M) +(k*beta/h)*uold(M-1);
    uold = unew;
end

plot(x, unew, '--b',x,uan,'--r');
legend('sol approchée');
title('solution equation du transport par Crank Nicholson');
hold off