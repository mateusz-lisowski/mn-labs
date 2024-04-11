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