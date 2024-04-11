% Skrypt do zadania 8 - Wyznaczenie liczby parametrów N dla której algorytm realizuje działania w zadanym czasie

% Zdefiniowanie wartości granicznych
a = 1;
b = 60000;
ytolerance = 1e-12;
max_iterations = 100;
% Wyznaczenie częstości metodą bisekcji
[n_bisection, ~, ~, xtab_bisection, xdif_bisection] = bisection_method(a, b, max_iterations, ytolerance, @estimate_execution_time);

% Wyznaczenie częstości metodą siecznych
[n_secant, ~, ~, xtab_secant, xdif_secant] = secant_method(a, b, max_iterations, ytolerance, @estimate_execution_time);

% Tworzenie wykresu
figure;

% Górny wykres - zmiana przybliżenia rozwiązania w kolejnych iteracjach
subplot(2,1,1);
plot(xtab_bisection, 'b', 'LineWidth', 1.5);
hold on;
plot(xtab_secant, 'r', 'LineWidth', 1.5);
hold off;
title('Zmiana przybliżenia rozwiązania w kolejnych iteracjach');
xlabel('Iteracja');
ylabel('Przybliżenie rozwiązania');
legend('Metoda bisekcji', 'Metoda siecznych', 'Location', 'best');

% Dolny wykres - różnice pomiędzy przybliżeniami rozwiązania w kolejnych iteracjach
subplot(2,1,2);
semilogy(xdif_bisection, 'b', 'LineWidth', 1.5);
hold on;
semilogy(xdif_secant, 'r', 'LineWidth', 1.5);
hold off;
title('Różnice pomiędzy przybliżeniami rozwiązania');
xlabel('Iteracja');
ylabel('Różnica');
legend('Metoda bisekcji', 'Metoda siecznych', 'Location', 'best');

% print -dpng zadanie8.png;

function time_delta = estimate_execution_time(N)

    % time_delta - różnica pomiędzy estymowanym czasem wykonania algorytmu dla zadanej wartości N a zadanym czasem M
    % N - liczba parametrów wejściowych
    M = 5000; % [s]
    
    if N <= 0
        error('Wartość N musi być większa od zera.');
    end

    t = (N^(16/11) + N^(pi^2/8)) / 1000;
    
    time_delta = t - M;

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
