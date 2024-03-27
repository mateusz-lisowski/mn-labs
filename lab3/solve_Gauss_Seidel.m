function [A, b, M, bm, x, err_norm, time, index_number, iterations] = solve_Gauss_Seidel(N)
    
    index_number = 193396;
    L1 = 6;
    
    % Generowanie macierzy A i wektora b przy użyciu funkcji generate_matrix
    [A, b] = generate_matrix(N, L1);
    
    % Podział macierzy A na macierze trójkątne dolną (L), górną (U) i diagonalną (D)
    L = tril(A, -1);
    U = triu(A, 1);
    D = diag(diag(A));
    
    % Inicjalizacja macierzy M jako odwrotność sumy macierzy D i L
    M = -(D + L) \ U;
    
    % Inicjalizacja wektora bm jako iloczyn macierzy odwrotności (D + L) i wektora b
    bm = (D + L) \ b;
    
    % Inicjalizacja wektora x jako wektora jednostkowego
    x = ones(N, 1);
    
    % Inicjalizacja licznika iteracji
    iterations = 0;
    
    % Warunek zakończenia algorytmu
    max_iterations = 100;
    residual_threshold = 1e-12;
    
    % Pomiar czasu
    tic;
    
    % Iteracyjne wyznaczanie rozwiązania metodą Gaussa-Seidla
    while true
        x_prev = x; % Przechowanie poprzedniego przybliżenia
        
        % Obliczenie nowego przybliżenia x
        x = M * x_prev + bm;
        
        % Zwiększenie licznika iteracji
        iterations = iterations + 1;
        
        % Obliczenie błędu rezydualnego
        residual = A * x - b;
        residual_norm = norm(residual);
        
        % Wypisanie normy błędu rezydualnego w każdej iteracji
        fprintf('Iteracja %d: Norma błędu rezydualnego = %e\n', iterations, residual_norm);
        
        % Sprawdzenie warunku zakończenia
        if residual_norm < residual_threshold || iterations >= max_iterations
            break;
        end
    end
    
    % Pomiar czasu
    time = toc;
    
    % Obliczenie normy błędu rezydualnego
    err_norm = norm(A * x - b);
end
