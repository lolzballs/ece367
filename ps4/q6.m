%% Part a)

h = 50;
w = 50;
n = h * w;
m = 1950;

A = zeros(m, n);
I = eye(n);

for i = 1:n
    A(:,i) = scanImage(reshape(I(i,:), h, w));
end

imshow(-A, [])

%% Part b) SVD

Yun = scanImage();
[U,S,V] = svd(A);

title('Singular values of estimated A')
plot(diag(S))
xlabel('i')
ylabel('\sigma_i')

%% Part b) Reconstruction

r = 1225;
A_pr = V(:,1:r) * diag(1./diag(S(1:r,1:r))) * U(:,1:r)';

M = reshape(A_pr * Yun, w, h);
imshow(M, [])