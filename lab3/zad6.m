% 1. Wczytaj dane z pliku 'filtr_dielektryczny.mat'
load('filtr_dielektryczny.mat');

% Metoda 1: Metoda bezpośrednia
x_direct = A\b; % Rozwiązanie równania A*x = b
norm_residual_direct = norm(A * x_direct - b);

% Metoda 2: Metoda Jacobiego
[A_Jacobi, b_Jacobi, ~, bm_Jacobi, x_Jacobi, err_norm_Jacobi, ~, ~] = solve_Jacobi_2(A, b);
norm_residual_Jacobi = norm(A * x_Jacobi - b); % Norma błędu rezydualnego

% Metoda 3: Metoda Gaussa-Seidla
[A_Gauss_Seidel, b_Gauss_Seidel, ~, bm_Gauss_Seidel, x_Gauss_Seidel, err_norm_Gauss_Seidel, ~, ~] = solve_Gauss_Seidel_2(A, b);
norm_residual_Gauss_Seidel = norm(A * x_Gauss_Seidel - b); % Norma błędu rezydualnego

