function [nodes_Chebyshev, V, V2, original_Runge, interpolated_Runge, interpolated_Runge_Chebyshev] = zadanie2()
    % Funkcja zadanie2 wykonuje interpolację funkcji Rungego na dwa sposoby:
    %   1. Za pomocą standardowej macierzy Vandermonde'a.
    %   2. Za pomocą macierzy Vandermonde'a dla węzłów Czebyszewa.

    % Liczba węzłów interpolacji
    N = 16;

    % Utworzenie gęstej siatki punktów x
    x_fine = linspace(-1, 1, 1000);

    % Tworzenie macierzy Vandermonde'a dla standardowych węzłów równoodległych
    V = vandermonde_matrix(N);

    % Tworzenie macierzy Vandermonde'a dla węzłów Czebyszewa
    V2 = chebyshev_vandermonde_matrix_(N);
    
    % Węzły równoodległe i wartości funkcji Rungego w tych węzłach
    x_coarse1 = linspace(-1, 1, N);
    y_coarse1 = 1 ./ (1 + 25 * x_coarse1' .^ 2);

    % Obliczanie współczynników interpolacji dla standardowych węzłów równoodległych
    c_runge1 = V \ y_coarse1;

    % Interpolacja funkcji Rungego na gęstej siatce punktów x
    interpolated_Runge = polyval(flipud(c_runge1), x_fine);

    % Węzły Czebyszewa i wartości funkcji Rungego w tych węzłach
    x_coarse2 = get_Chebyshev_nodes(N);
    y_coarse2 = 1 ./ (1 + 25 * x_coarse2' .^ 2);

    % Obliczanie współczynników interpolacji dla węzłów Czebyszewa
    c_runge2 = V2 \ y_coarse2;

    % Interpolacja funkcji Rungego na gęstej siatce punktów x przy użyciu węzłów Czebyszewa
    interpolated_Runge_Chebyshev = polyval(flipud(c_runge2), x_fine);
    
    % Zapisanie węzłów Czebyszewa
    nodes_Chebyshev = get_Chebyshev_nodes(N);

    % Obliczenie wartości funkcji Rungego na gęstej siatce punktów x
    original_Runge = 1 ./ (1 + 25 * x_fine .^ 2);

    % Wyświetlenie dwóch wykresów:
    %   1. Interpolacja za pomocą standardowej macierzy Vandermonde'a
    %   2. Interpolacja za pomocą macierzy Vandermonde'a dla węzłów Czebyszewa
    subplot(2,1,1);
    plot(x_fine, original_Runge);
    hold on
    plot(x_coarse1, y_coarse1, 'o');
    plot(x_fine, interpolated_Runge);
    hold off
    title("Interpolated Runge");
    xlabel("x");
    ylabel("y");
    legend('show');

    subplot(2,1,2);
    plot(x_fine, original_Runge);
    hold on
    plot(x_coarse2, y_coarse2, 'o');
    plot(x_fine, interpolated_Runge_Chebyshev);
    hold off
    title("Interpolated Runge with Chebyshev");
    xlabel("x");
    ylabel("y");
    legend('show');

    % Opcjonalne: zapisz wykres do pliku PNG
    % print -dpng zadanie2.png;
end

function nodes = get_Chebyshev_nodes(N)
    % Funkcja get_Chebyshev_nodes generuje węzły Czebyszewa
    nodes = cos(((0:N-1) .* pi) ./ (N - 1));
end

function V = vandermonde_matrix(N)
    % Funkcja vandermonde_matrix generuje macierz Vandermonde'a dla standardowych węzłów równoodległych
    x_coarse = linspace(-1,1,N);
    V = ones(N, N);
    for i = 2:N
        V(:, i) = V(:, i - 1) .* x_coarse';
    end
end

function V = chebyshev_vandermonde_matrix_(N)
    % Funkcja chebyshev_vandermonde_matrix_ generuje macierz Vandermonde'a dla węzłów Czebyszewa
    x_coarse = get_Chebyshev_nodes(N);
    V = ones(N, N);
    for i = 2:N
        V(:, i) = V(:, i - 1) .* x_coarse';
    end
end
