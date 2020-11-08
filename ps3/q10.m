load('../ps1/data/wordVecV.mat')

%% Part c)
M = double(V > 0);
M_norm = M ./ vecnorm(M);

[U,S,V] = svd(M_norm);
s = diag(S);
s(1:10)

%% Part d)

m = size(M, 2);
d = zeros(m, m);
C = U(:,1:9) * U(:,1:9)';
for i = 1:m
    for j = 1:m
        if i >= j
            d(i,j) = 0;
        else
            di = C * M_norm(:,i);
            dj = C * M_norm(:,j);
            d(i,j) = di' * dj ./ (norm(C * di) * norm(C * dj));
        end
    end
end

[dists, inds] = maxk(d(:), 1);
[r, c] = ind2sub(size(d), inds)

%% Part e)

for k = 1:8
    m = size(M, 2);
    d = zeros(m, m);
    C = U(:,1:k) * U(:,1:k)';
    for i = 1:m
        for j = 1:m
            if i >= j
                d(i,j) = 0;
            else
                di = C * M_norm(:,i);
                dj = C * M_norm(:,j);
                d(i,j) = di' * dj ./ (norm(C * di) * norm(C * dj));
            end
        end
    end

    [dists, inds] = maxk(d(:), 1);
    [r, c] = ind2sub(size(d), inds);
    fprintf("k=%d, d(%d,%d)\n", k, r, c);
end