function impedance_delta = impedance_magnitude(omega)
    % Parametry obwodu
    R = 525;
    C = 7e-5;
    L = 3;
    M = 75; % docelowa wartość modułu impedancji

    % Sprawdzenie warunku na omega
    if omega <= 0
        error('Wartość omega musi być większa od zera.');
    end

    % Obliczenie modułu impedancji
    Z = abs(1 / sqrt( (1 / R^2 + (omega * C - 1/(omega * L))^2 )));

    % Obliczenie różnicy między modułem impedancji a M
    impedance_delta = Z - M;
end