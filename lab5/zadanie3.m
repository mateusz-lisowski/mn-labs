function [matrix_condition_numbers, max_coefficients_difference_1, max_coefficients_difference_2] = zadanie3()
    % Zwracane są trzy wektory wierszowe:
    % matrix_condition_numbers - współczynniki uwarunkowania badanych macierzy Vandermonde
    % max_coefficients_difference_1 - maksymalna różnica między referencyjnymi a obliczonymi współczynnikami wielomianu,
    %       gdy b zawiera wartości funkcji liniowej
    % max_coefficients_difference_2 - maksymalna różnica między referencyjnymi a obliczonymi współczynnikami wielomianu,
    %       gdy b zawiera zaburzone wartości funkcji liniowej
    
    N = 5:40;
    
    %% chart 1
    matrix_condition_numbers = zeros(1, length(N));
    for i = 1:length(N)
        ni = N(i);
        V = vandermonde_matrix(ni);
    
        matrix_condition_numbers(1, i) = cond(V);
    end
    
    subplot(3,1,1);
    semilogy(N, matrix_condition_numbers);
    xlabel('Rozmiar macierzy Vandermonde');
    ylabel('Współczynnik uwarunkowania');
    title('Wzrost współczynnika uwarunkowania macierzy Vandermonde');
    
    %% chart 2
    a1 = randi([20,30]);
    for i = 1:length(N)
        ni = N(i);
        V = vandermonde_matrix(ni);
        
        % Niech wektor b zawiera wartości funkcji liniowej
        b = linspace(0,a1,ni)';
        reference_coefficients = [ 0; a1; zeros(ni-2,1) ]; % tylko a1 jest niezerowy
        
        % Wyznacznie współczynników wielomianu interpolującego
        calculated_coefficients = V \ b;
    
        max_coefficients_difference_1(i) = max(abs(calculated_coefficients-reference_coefficients));
    end
    
    subplot(3,1,2);
    plot(N, max_coefficients_difference_1);
    xlabel('Rozmiar macierzy Vandermonde');
    ylabel('Maks. różnica współczynników');
    title('Błąd wyznaczania współczynników dla funkcji liniowej');
    legend('show');
    
    %% chart 3
    for i = 1:length(N)
        ni = N(i);
        V = vandermonde_matrix(ni);
        
        % Niech wektor b zawiera wartości funkcji liniowej nieznacznie zaburzone
        b = linspace(0,a1,ni)' + rand(ni,1)*1e-10;
        reference_coefficients = [ 0; a1; zeros(ni-2,1) ]; % tylko a1 jest niezerowy
        
        % Wyznacznie współczynników wielomianu interpolującego
        calculated_coefficients = V \ b;
        
        max_coefficients_difference_2(i) = max(abs(calculated_coefficients-reference_coefficients));
    end
    
    subplot(3,1,3);
    plot(N, max_coefficients_difference_2);
    xlabel('Rozmiar macierzy Vandermonde');
    ylabel('Maks. różnica współczynników');
    title('Błąd wyznaczania współczynników dla zaburzonej funkcji liniowej');
    legend('show');
    
    % print -dpng zadanie3.png;
end

function V = vandermonde_matrix(N)
    x_coarse = linspace(0,1,N);
    V = ones(N, N);

    for i = 2:N
        V(:, i) = V(:, i - 1) .* x_coarse';
    end
end
