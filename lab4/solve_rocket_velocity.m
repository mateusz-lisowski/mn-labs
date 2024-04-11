% Skrypt do wyznaczania czasu t, w którym rakieta osiągnie zadaną prędkość

% Granice poszukiwań miejsca zerowego
a = 1;
b = 50;

% Dokładność rozwiązania
ytolerance = 1e-12;

% Maksymalna liczba iteracji
max_iterations = 100;

% Wyznaczenie czasu metodą bisekcji
[time_bisection, ~, ~, xtab_bisection, xdif_bisection] = bisection_method(a, b, max_iterations, ytolerance, @rocket_velocity);

% Wyznaczenie czasu metodą siecznych
[time_secant, ~, ~, xtab_secant, xdif_secant] = secant_method(a, b, max_iterations, ytolerance, @rocket_velocity);

% Wygenerowanie wykresu
figure;

% Górny wykres
subplot(2, 1, 1);
plot(xtab_bisection, '-o', 'DisplayName', 'Bisection');
hold on;
plot(xtab_secant, '-x', 'DisplayName', 'Secant');
hold off;
xlabel('Iterations');
ylabel('t');
legend('Location', 'eastoutside');
title('Iterations vs. t');

% Dolny wykres
subplot(2, 1, 2);
semilogy(xdif_bisection, '-o', 'DisplayName', 'Bisection');
hold on;
semilogy(xdif_secant, '-x', 'DisplayName', 'Secant');
hold off;
xlabel('Iterations');
ylabel('Difference');
legend('Location', 'eastoutside');
title('Iterations vs. Difference');

% print -dpng zadanie6.png;

function velocity_delta = rocket_velocity(t)

    % Dane wejściowe
    m0 = 150000; % kg
    u = 2000; % m/s
    q = 2700; % kg/s
    M = 750; % m/s
    g = 1.622; % m/s^2

    if t <= 0
        error('Wartość omega musi być większa od zera.');
    end
    
    % Wzór na prędkość lotu rakiety
    v = u * log(m0 / (m0 - q * t)) - g * t;
    
    % Różnica prędkości
    velocity_delta = v - M;

end

function [xsolution,ysolution,iterations,xtab,xdif] = bisection_method(a,b,max_iterations,ytolerance,fun)

    % Inicjalizacja zmiennych
    xsolution = [];
    ysolution = [];
    iterations = 1;
    xtab = [];
    xdif = [];
    
    % Sprawdzenie warunku początkowego
    fa = fun(a);
    fb = fun(b);
    if sign(fa) == sign(fb)
        error('Funkcja nie zmienia znaku na krańcach przedziału. Brak miejsca zerowego.');
    end
    
    % Iteracyjne wyznaczanie miejsca zerowego
    while iterations < max_iterations
        % Wyznaczenie środka przedziału
        c = (a + b) / 2;
        fc = fun(c);
        
        % Zapis wartości x i różnicy x w historii
        xtab = [xtab; c];
        if size(xtab, 1) > 1
            xdif = [xdif; abs(xtab(end) - xtab(end - 1))];
        end
        
        % Sprawdzenie warunku zakończenia
        if abs(fc) < ytolerance
            xsolution = c;
            ysolution = fc;
            return;
        end
        
        % Aktualizacja przedziału
        if sign(fc) == sign(fa)
            a = c;
            fa = fc;
        else
            b = c;
            fb = fc;
        end
        
        iterations = iterations + 1;
    end
    
    % Informacja o nieosiągnięciu wymaganej dokładności
    warning('Nie osiągnięto wymaganej dokładności w maksymalnej liczbie iteracji.');

end

function [xsolution, ysolution, iterations, xtab, xdif] = secant_method(a, b, max_iterations, ytolerance, fun)

    % Inicjalizacja zmiennych
    xsolution = [];
    ysolution = [];
    iterations = 1;
    xtab = [];
    xdif = [];

    % Iteracja
    while iterations < max_iterations
        % Obliczanie kolejnej wartości x
        x = b - (fun(b) * (b - a)) / (fun(b) - fun(a));
        
        % Zapisywanie historii wartości x
        xtab = [xtab; x];
        if size(xtab, 1) > 1
            xdif = [xdif; abs(xtab(end) - xtab(end - 1))];
        end
        
        % Sprawdzenie warunku stopu
        if abs(fun(x)) < ytolerance
            xsolution = x;
            ysolution = fun(x);
            break;
        end
        
        % Przesunięcie wartości x
        a = b;
        b = x;
        
        % Inkrementacja liczby iteracji
        iterations = iterations + 1;
    end
    
end
