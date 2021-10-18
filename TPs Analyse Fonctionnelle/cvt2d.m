clear all;
M_list = [99,199,399,799];
hold on

err_list = [];
for p=1:length(M_list);
a = 0;
b = 2;%%
T = 1.;
M = M_list(p);
h=(b-a)/M;
k = 0.5*h;
N=T/k;
beta=1.;
x= a + (1:M)*h;
u0 = exp(-5*((5*x-1).^2));
uan = exp(-5*((5*(x-beta*T)-1).^2));
un = u0;
for i=1:N;
    unew(1) = un(1) - (k*beta/(2*h))*un(2) + ((beta^2)*(k^2)/(2*h^2))*(un(2) - 2*un(1));
    for j=2:M-1;    
         unew(j) = un(j) -(k*beta/(2*h))*(un(j+1) - un(j-1)) + ((beta^2)*(k^2)/(2*h^2))*(un(j+1) - 2*un(j) + un(j-1));
    end
    % on approche unew(M+1) selon le schéma de courant
    unew(M) = (1 - k*beta/h)*un(M) +(k*beta/h)*un(M-1);
      hold on
un=unew;
%plot(x
end
err = max(abs(un - uan));
err_l2 = sqrt(sum((un - uan).*(un - uan)));
err_list(p) = err_l2;

plot(x, un);
title('solution equation du transport par schema explicite');

end
% plot(log(M_list),err_list)
plot(x,uan,'--r');
