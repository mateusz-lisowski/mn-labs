function [M,N,P,R,x_coarse,y_coarse,F_coarse,x_fine,y_fine,F_fine] = zadanie5()
    
    % Warunki dla zadania 5
    P = 60; % liczba unikalnych współrzędnych x punktów dla których będzie obliczana interpolacja
    R = 60; % liczba unikalnych współrzędnych y punktów dla których będzie obliczana interpolacja
    M = 40; % liczba węzłów interpolacji wzdłuż osi X (stopień wielomianu zmiennej x: M-1)
    N = 40; % liczba węzłów interpolacji wzdłuż osi Y (stopień wielomianu zmiennej y: N-1)
    
    % Generowanie węzłów interpolacji na płaszczyźnie
    x_coarse = linspace(0, 1, M);
    y_coarse = linspace(0, 1, N);
    [X_coarse, Y_coarse] = meshgrid(x_coarse, y_coarse);
    
    % Wyznaczenie wartości funkcji oryginalnej w węzłach
    F_coarse = sin(X_coarse*2*pi) .* abs(Y_coarse-0.5);
    
    % Sprawdzenie warunku na maksymalną wartość bezwzględna elementów macierzy F_coarse
    max_F_coarse = max(abs(F_coarse), [], 'all');
    while max_F_coarse >= 10
        % Jeśli warunek nie jest spełniony, wygeneruj nowe węzły i oblicz ponownie wartość funkcji oryginalnej
        M = randi([4, 40]);
        N = randi([4, 40]);
        x_coarse = linspace(0, 1, M);
        y_coarse = linspace(0, 1, N);
        [X_coarse, Y_coarse] = meshgrid(x_coarse, y_coarse);
        F_coarse = sin(X_coarse*2*pi) .* abs(Y_coarse-0.5);
        max_F_coarse = max(abs(F_coarse), [], 'all');
    end
    
    % Tworzenie wektora danych wejściowych dla interpolacji
    MN = M*N;
    xvec_coarse = reshape(X_coarse, MN, 1);
    yvec_coarse = reshape(Y_coarse, MN, 1);
    fvec_coarse = reshape(F_coarse, MN, 1);
    
    % Macierz Vandermonde'a dla interpolacji 2D
    V = zeros(M*N, M*N);
    for i = 0:(M-1)
        for j = 0:(N-1)
            V(:, i*N + j + 1) = xvec_coarse.^i .* yvec_coarse.^j;
        end
    end
    
    % Współczynniki wielomianu interpolacyjnego
    coeffs = V \ fvec_coarse;
    
    % Obliczanie wartości funkcji interpolującej na gęstszej siatce
    x_fine = linspace(0, 1, P);
    y_fine = linspace(0, 1, R);
    [X_fine, Y_fine] = meshgrid(x_fine, y_fine);
    
    F_fine = zeros(size(X_fine));
    % Obliczenie wartości wielomianu interpolującego na gęstszej siatce
    for i = 0:(M-1)
        for j = 0:(N-1)
            F_fine = F_fine + coeffs(i*N + j + 1) * X_fine.^i .* Y_fine.^j;
        end
    end
    
    % Sprawdzenie warunku na maksymalną wartość bezwzględną elementów macierzy F_fine
    max_F_fine = max(abs(F_fine), [], 'all');
    while max_F_fine <= 100
        % Jeśli warunek nie jest spełniony, wygeneruj nowe punkty dla gęstej siatki i oblicz ponownie wartość interpolowaną
        P = randi([10, 200]);
        R = randi([10, 200]);
        x_fine = linspace(0, 1, P);
        y_fine = linspace(0, 1, R);
        [X_fine, Y_fine] = meshgrid(x_fine, y_fine);
        F_fine = zeros(size(X_fine));
        for i = 0:(M-1)
            for j = 0:(N-1)
                F_fine = F_fine + coeffs(i*N + j + 1) * X_fine.^i .* Y_fine.^j;
            end
        end
        max_F_fine = max(abs(F_fine), [], 'all');
    end
    
    % Wygenerowanie wykresów na osobnych subwykresach
    % Subwykres dla F_coarse
    subplot(1, 2, 1);
    surf(X_coarse, Y_coarse, F_coarse, 'FaceAlpha', 0.5);
    xlabel('X');
    ylabel('Y');
    zlabel('F(x,y)');
    title('F_{coarse}');
    
    % Subwykres dla F_fine
    subplot(1, 2, 2);
    surf(X_fine, Y_fine, F_fine, 'FaceAlpha', 0.5);
    xlabel('X');
    ylabel('Y');
    zlabel('F(x,y)');
    title('F_{fine}');
    
    % Zapisanie wykresów do pliku
    % saveas(gcf, 'zadanie5.png');
end
