function velocity_delta = rocket_velocity(t)

    % Dane wejściowe
    m0 = 150000; % kg
    u = 2000; % m/s
    q = 2700; % kg/s
    M = 750; % m/s
    g = 1.622; % m/s^2

    if t <= 0
        error('Wartość t musi być większa od zera.');
    end
    
    % Wzór na prędkość lotu rakiety
    v = u * log(m0 / (m0 - q * t)) - g * t;
    
    % Różnica prędkości
    velocity_delta = v - M;

end