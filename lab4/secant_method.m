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
