function [A, b, x, time_direct, err_norm, index_number] = solve_direct(N)
    
    index_number = 193396;
    L1 = 6;
    
    [A, b] = generate_matrix(N, L1);
    
    tic;
    x = A\b;
    time_direct = toc;
    
    err_norm = norm(A*x - b);
end
