%% Data loading and SVD

load('data/yalefaces.mat')

X_orig = reshape(M, 1024, 2414);
X_mean = mean(X_orig, 2);
X = X_orig - X_mean;

C = X * X';
[U,S,V] = svd(C);

%% Part b
% Plot eigenvalues
figure
plot(log(diag(S)))
ylabel('log(\lambda_j)')
xlabel('j')
title('eigenvalues of the covariance matrix')

eigenfaces = reshape(U, 32, 32, 1024);

%% Part c
% Top 10
figure
for i = 1:10
    subplot(2,5,i)
    imshow(eigenfaces(:,:,i), []) 
end
sgtitle('Top 10 Eigenfaces')

% Bottom 10
figure
for i = 1:10
    subplot(2,5,i)
    imshow(eigenfaces(:,:,1025-i), [])
end
sgtitle('Bottom 10 Eigenfaces')

%% Part d
% Projection
is = [1,1076,2043];
js = 2.^(1:10);
Y = zeros(size(X,1), length(is), length(js));
for ii = 1:length(is)
    for jj = 1:length(js)
        i = is(ii);
        j = js(jj);
        B = U(:,1:j);
        Y(:,ii,jj) = X(:,i)' * B * B';
    end
end

Y = reshape(Y, 1024, 3, 10);
Y_orig = Y + X_mean;
Y_disp = reshape(Y, 32, 32, 3, 10);

figure
for ii = 1:length(is)
    for jj = 1:length(js)
        i = (ii - 1) * 10 + jj;
        subplot(3, 10, i)
        imshow(Y_disp(:,:,ii,jj), [])
        title(sprintf('j = %d', js(jj)))
    end
end
sgtitle('approximated faces')

%% Part e
I = [1, 2, 7, 2043, 2044, 2045];
B25 = U(:,1:25);

C = zeros(size(B25,2), length(I));

for ii = 1:length(I)
    i = I(ii);
    C(:,ii) = X(:,i)' * B25;
end

diff = squareform(pdist(C'));