function [V, original_Runge, original_sine, interpolated_Runge, interpolated_sine] = zadanie1()
    % Rozmiar tablic komórkowych (cell arrays) V, interpolated_Runge, interpolated_sine: [1,4].
    % V{i} zawiera macierz Vandermonde wyznaczoną dla liczby węzłów interpolacji równej N(i)
    % original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
    % original_sine - wektor wierszowy zawierający wartości funkcji sinus dla wektora x_fine
    % interpolated_Runge{i} stanowi wierszowy wektor wartości funkcji interpolującej 
    %       wyznaczonej dla funkcji Runge (wielomian stopnia N(i)-1) w punktach x_fine
    % interpolated_sine{i} stanowi wierszowy wektor wartości funkcji interpolującej
    %       wyznaczonej dla funkcji sinus (wielomian stopnia N(i)-1) w punktach x_fine
    N = 4:4:16;
    x_fine = linspace(-1, 1, 1000);
    original_Runge = runge_function(x_fine);

    subplot(2,1,1);
    plot(x_fine, original_Runge);
    hold on;
    for i = 1:length(N)
        V{i} = vandermonde_matrix(N(i)); % macierz Vandermonde
        x_coarse = linspace(-1,1,N(i)); % węzły interpolacji
        y_coarse = runge_function(x_coarse); % wartości funkcji interpolowanej w węzłach interpolacji
        c_runge = polyfit(x_coarse, y_coarse, N(i)-1); % współczynniki wielomianu interpolującego
        interpolated_Runge{i} = polyval(c_runge, x_fine); % interpolacja
        plot(x_fine, interpolated_Runge{i}); % dodaj do wykresu rezultat interpolacji dla N(i) węzłów interpolacji
    end
    hold off;
    xlabel('x');
    ylabel('y');
    title('Interpolacja funkcji Rungego');
    legend('show');

    original_sine = sin(2 * pi * x_fine);
    subplot(2,1,2);
    plot(x_fine, original_sine);
    hold on;
    for i = 1:length(N)
        x_coarse = linspace(-1,1,N(i)); % węzły interpolacji
        y_coarse = sin(2 * pi * x_coarse); % wartości funkcji interpolowanej w węzłach interpolacji
        c_sine = polyfit(x_coarse, y_coarse, N(i)-1); % współczynniki wielomianu interpolującego
        interpolated_sine{i} = polyval(c_sine, x_fine); % interpolacja
        plot(x_fine, interpolated_sine{i}); % dodaj do wykresu rezultat interpolacji dla N(i) węzłów interpolacji
    end
    hold off;
    xlabel('x');
    ylabel('y');
    title('Interpolacja funkcji sinus');
    legend('show');
    
    %print -dpng zadanie1.png;
end

function V = vandermonde_matrix(N)
    % Generuje macierz Vandermonde dla N równomiernie rozmieszczonych w przedziale [-1, 1] węzłów interpolacji
    x_coarse = linspace(-1,1,N);
    V = zeros(N);
    for i = 1:N
        V(:,i) = x_coarse.^(i-1);
    end
end

function y = runge_function(x)
    y = 1 ./ (1 + 25 * x.^2);
end