clear all;
a = 0;
b = pi;
M = 100;
h=(b-a)/M;
x= a + (1:M)*h;
% Notre comparatif exemple sera toujours par rapport à -u''(x) = f(x) avec
% u(0)=u(pi)=0, la solution analytique est u(x) = 0
uan = sin(x)';
f = sin(x)';
A = full(gallery('tridiag',M,-1,2,-1))/(h^2);
% Notre problème se ré-écrit comme AU=F
un = inv(A)*f;
plot(x, un, '--b',x,uan,'--r');
legend('sol approchée');
title('solution equation de laplace différences finies');

K = [2:9];
M = 2.^K;

err_list = [];
for i =1:length(K);
    h=(b-a)/M(i);
    x= a + (1:M(i))*h;
    uan = sin(x)';
    f = sin(x)';
    A = gallery('tridiag',M(i),-1,2,-1)/(h^2);
    % Notre problème se ré-écrit comme AU=F
    un = inv(A)*f;
    err = max(abs(un - uan));
    err_list(i) = err;
end
err_list_h = err_list/h;
err_list_h_square = err_list/h^2;

plot(K, err_list_h_square)