function [numer_indeksu, Edges, I, B, A, b, r] = page_rank()

    numer_indeksu = 193396;

    Edges = [ 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 6, 6, 7, 8, 4, 5 ; 
              4, 6, 4, 3, 5, 6, 5, 7, 6, 5, 6, 4, 7, 6, 3, 8, 4 ];

    n = 8;
    d = 0.85;

    I = speye(n);

    B = sparse(Edges(2,:), Edges(1,:), 1, n, n);

    e = 1./sum(B)';

    A = spdiags(e, 0, n, n);
    b = (1 - d) / n * ones(n, 1);

    M = I - d * B * A;
    r = M \ b;

end