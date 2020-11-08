N = 10;
H = zeros(3, N);
b = [0.5; 1];
A = [1 1; 0 1];
yN = [1; 0; 0]; % x(10), v(10), x(5)

for i = 1:N
    H(1:2,i) = A^(N-i) * b;
end
H(3,:) = [9/2 7/2 5/2 3/2 1/2 0 0 0 0 0]; % x(5) = 0 constraint

u = H' * ((H * H') \ yN);

y = zeros(2, 10);
y(:,1) = b*u(1);
for i = 2:N
    y(:,i) = A * y(:,i-1) + b*u(i);
end

figure 
stairs(0:10, u([1:end end]))
title('input control')
xlabel('t')
ylabel('$f(t)$', 'interpreter', 'latex')

figure
plot(0:10, [0 y(1,:)])
title('position')
xlabel('t')
ylabel('$x(t)$', 'interpreter', 'latex')

figure
plot(0:10, [0 y(2,:)])
title('velocity')
xlabel('t')
ylabel('$\dot{x}(t)$', 'interpreter', 'latex')