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
% On veut u1,m pour pouvoir démarrer le schéma, ainsi, avec u0 et u1, cela,
% on pourra travailler sur le pas de temps d'ordre 2. 
%  On utilise le schéma de courant
    u1(1) = (1 - k*beta/h)*u0(1);
    for j=2:M;    
        u1(j) = (1 - k*beta/h)*u0(j) +(k*beta/h)*u0(j-1);
    end
% On a maitenant u1(M) dans u1.
uolder = u0;
uold = u1;
for i=1:N;
    unew(1) = uolder(1) - (k*beta/h)*uold(2);
    for j=2:M-1;    
         unew(j) =  uolder(j) -(k*beta/h)*(uold(j+1) - uold(j-1));
    end
    % on approche unew(M+1) selon le schéma de courant
    unew(M) = (1 - k*beta/h)*uold(M) +(k*beta/h)*uold(M-1);
      hold on	
uolder = uold;
uold = unew;
un=unew;
%plot(x, un, '--b');
end
plot(x, un, '--b',x,uan,'--r');
legend('sol approchée');
title('solution equation du transport par schema explicite');
hold off