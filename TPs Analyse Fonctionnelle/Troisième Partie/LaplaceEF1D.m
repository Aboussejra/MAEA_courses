clear all;
a = 0;
b = 2;
n = 1000; % nb éléments maillage
f = @(x) (pi^2)*sin(pi*x);
h = (b-a)/(n);
x= a + (0:n)*h;
uan = sin(pi*x);


M = full(gallery('tridiag',n+1,-1/h,2/h,-1/h));
B = zeros(1,n+1);
B(1) = h*f(x(1));
for i=2:n;
    B(i) = h*f(x(i));
end

B(n+1) =  h*f(x(n));
B = B';
A = inv(M)*B;

plot(x,A,'--b', x, uan,'--r');