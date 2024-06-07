function [integration_error, Nt, ft_5, integral_1000] = zadanie3()
    % Wartość referencyjna całki
    ref_value = 0.0473612919396179;

    % Wektor liczby podprzedziałów
    Nt = 5:50:10^4;
    error_values = zeros(1, length(Nt));

    % Obliczenie wartości funkcji gęstości prawdopodobieństwa dla t = 5
    ft_5 = probability_density(5);

    % Obliczenie wartości całki dla 1000 podprzedziałów
    integral_1000 = numerical_integration(@probability_density, 1000);

    % Pętla po liczbach podprzedziałów
    for i = 1:length(Nt)
        num_intervals = Nt(i);

        % Obliczenie wartości całki dla num_intervals podprzedziałów
        integration_result = numerical_integration(@probability_density, num_intervals);

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
    saveas(gcf, 'zadanie3.png');
end

function integral_result = numerical_integration(func_handle, num_divisions)
    integral_result = 0;
    lower_bound = 0;
    upper_bound = 5;
    step_size = (upper_bound - lower_bound) / num_divisions;

    for k = 1:num_divisions
        x_start = lower_bound + (k - 1) * step_size;
        x_end = lower_bound + k * step_size;
        integral_result = integral_result + func_handle(x_start) + func_handle(x_end) + 4 * func_handle((x_start + x_end) / 2);
    end

    integral_result = integral_result * step_size / 6;
end

function output = probability_density(input)
    stddev = 3;
    mean_value = 10;

    output = 1 / (stddev * sqrt(2 * pi)) * exp(-(input - mean_value)^2 / (2 * stddev^2));
end
