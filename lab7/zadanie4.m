function [integration_error, Nt, ft_5, xr, yr, yrmax] = zadanie4()
    % Wartość referencyjna całki
    ref_value = 0.0473612919396179;

    % Wektor liczby podprzedziałów
    Nt = 5:50:10^4;
    error_values = zeros(1, length(Nt));

    % Obliczenie wartości funkcji gęstości prawdopodobieństwa dla t = 5
    ft_5 = probability_density(5);
    yrmax = 0.034;

    % Przygotowanie zmiennych do przechowywania losowych punktów
    xr = cell(1, length(Nt));
    yr = cell(1, length(Nt));

    % Pętla po liczbach podprzedziałów
    for i = 1:length(Nt)
        num_intervals = Nt(i);

        % Obliczenie wartości całki dla num_intervals podprzedziałów
        [integration_result, x_rand, y_rand] = monte_carlo_integration(@probability_density, num_intervals, yrmax);
        xr{1, i} = x_rand;
        yr{1, i} = y_rand;

        % Obliczenie błędu całkowania
        error_values(i) = abs(integration_result - ref_value);
    end

    % Rysowanie wykresu błędu całkowania
    figure;
    loglog(Nt, error_values);
    title('Błąd całkowania w funkcji liczby podprzedziałów');
    xlabel('Liczba podprzedziałów');
    ylabel('Błąd');

    % Przypisanie wyników do zmiennych wyjściowych
    integration_error = error_values;

    % Zapisanie wykresu
    saveas(gcf, 'zadanie4.png');
end

function [integral_result, x_rand, y_rand] = monte_carlo_integration(func_handle, num_points, ymax)
    x_min = 0;
    x_max = 5;
    y_min = 0;

    % Generowanie losowych punktów
    x_rand = x_min + (x_max - x_min) .* rand(1, num_points);
    y_rand = y_min + (ymax - y_min) .* rand(1, num_points);

    num_under_curve = 0;

    % Sprawdzanie, ile punktów znajduje się pod krzywą
    for k = 1:num_points
        x_val = x_rand(k);
        y_val = y_rand(k);
        y_func = func_handle(x_val);

        if y_func >= y_val
            num_under_curve = num_under_curve + 1;
        end
    end

    % Obliczanie wartości całki metodą Monte Carlo
    area = (x_max - x_min) * (ymax - y_min);
    integral_result = num_under_curve / num_points * area;
end

function output = probability_density(input)
    stddev = 3;
    mean_value = 10;

    output = 1 / (stddev * sqrt(2 * pi)) * exp(-(input - mean_value)^2 / (2 * stddev^2));
end
