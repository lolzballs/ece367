N = 10;
H = zeros(2, N);
b = [0.5; 1];
A = [1 1; 0 1];
yN = [1; 0];

for i = 1:N
    H(:,i) = A^(N-i) * b;
end

u = H' * ((H * H') \ yN);

y = zeros(2, 10);
y(:,1) = b*u(1);
for i = 2:N
    y(:,i) = A * y(:,i-1) + b*u(i);
end

figure 
stairs(0:10, u([1:end end]))
xlabel('t')
ylabel('$f(t)$', 'interpreter', 'latex')

figure
plot(0:10, [0 y(1,:)])
xlabel('t')
ylabel('$x(t)$', 'interpreter', 'latex')

figure
plot(0:10, [0 y(2,:)])
xlabel('t')
ylabel('$\dot{x}(t)$', 'interpreter', 'latex')