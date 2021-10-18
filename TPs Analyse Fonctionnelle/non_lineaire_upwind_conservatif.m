clear all;
a = 0;
b = 5;%%
T = 1.;
M = 500;
h=(b-a)/M;
k = h*0.95;
ksurh = k/h;
N=T/k;
x= a + (1:M)*h;
u0 = exp(-((x-2).^2)/0.1);
un = u0;
%syms x
f = @(x) (x*x)/2;
%g=diff(f(x));
a = @(x) x;

for i=1:N;
    if a((un(2) + un(1))/2) >= 0;
        unew(1) = un(1) - (k/h)*(f(un(1)));
    else;
        unew(1) = un(1) - (k/h)*(f(un(2)));
    end
    for j=2:M-1;
        if a((un(j) + un(j+1))/2) >= 0;
            Fiplushalf = f(un(j));
        else;
            Fiplushalf = f(un(j+1));
        end
        if a((un(j-1) + un(j))/2) >= 0;
            Fiminushalf = f(un(j-1));
        else;
            Fiminushalf = f(un(j));
        end
         unew(j) = un(j) - (k/h)*(Fiplushalf - Fiminushalf);
    end
    % on approche unew(M+1) selon le schéma de courant
    unew(M) = (1 - k/h)*un(M) +(k/h)*un(M-1);
      hold on
un=unew;
%plot(x, un, '--b');
end
plot(x, un, '--b');