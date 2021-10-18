a = 0;
b = 1;
M = 49;
T = 0.1;
h=(b-a)/(M+1);
x= a + (1:M)*h;
alpha = 1;
k = 0.0001;
N=T/k;
u0 = 2*x;
t = (0:N)*k; % No need much time, the solution falls fast
% Creating initial condition
for i=1:length(x);
    if (b+a)/2 <= x(i) && x(i) < b;
        u0(i) = 2*(a+b-x(i));
    end
end


uan = zeros(N,M);
for j=1:10;
for i=1:N;
for k=1:M;
    uan(i,k) = uan(i,k) + (8/((2*j-1)*pi)^2)*((-1)^(j-1))*sin((2*j-1)*pi*x(k))*exp((-((2*j-1)*pi)^2)*alpha*t(i));
end
end
end

uan_T = uan(N,:);
hold on
plot(x,uan_T);
uold = u0';
theta = 0.5;

A = full(gallery('tridiag',M,-(k*alpha*theta)/(h^2),1 + (2*k*alpha*theta)/(h^2),-(k*alpha*theta)/(h^2)));
B = full(gallery('tridiag',M,(k*alpha*(1-theta))/(h^2),1 - (2*k*alpha*(1-theta))/(h^2),(k*alpha*(1-theta))/(h^2)));

for i=1:N;
    unew = (A\B)*uold;
    if isequal(mod(i,100),0);
        plot(x, unew, '--b',x, uan(i,:), '--r');
        legend('sol approchée');
    end
    uold = unew;
end

