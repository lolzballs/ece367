N = 10;
H = zeros(2, N);
b = [0.5; 1];
A = [1 1; 0 1];
y = [1; 0];

for i = 1:N
    H(:,i) = A^(N-i) * b;
end

c = ones(N, 1);
G = [H; -H];
h = [y; -y];

p = linprog(c, G, h);

y = zeros(2, 10);
y(:,1) = b*p(1);
for i = 2:N
    y(:,i) = A * y(:,i-1) + b*p(i);
end

figure 
stairs(0:10, p([1:end end]))
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