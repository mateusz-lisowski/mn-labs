function [country, source, degrees, x_coarse, x_fine, y_original, y_yearly, y_approximation, mse] = zadanie3(energy)
    % Głównym celem tej funkcji jest wyznaczenie aproksymacji rocznych danych o produkcji energii elektrycznej w wybranym kraju i z wybranego źródła energii.
    % Wybór kraju i źródła energii należy określić poprzez nadanie w tej funkcji wartości zmiennym typu string: country, source.
    % Dopuszczalne wartości tych zmiennych można sprawdzić poprzez sprawdzenie zawartości struktury energy zapisanej w pliku energy.mat.
    % 
    % energy - struktura danych wczytana z pliku energy.mat
    % country - [String] nazwa kraju
    % source  - [String] źródło energii
    % degrees - wektor zawierający cztery stopnie wielomianu dla których wyznaczono aproksymację
    % x_coarse - wartości x danych aproksymowanych; wektor o rozmiarze [N,1].
    % x_fine - wartości, w których wyznaczone zostaną wartości funkcji aproksymującej; wektor o rozmiarze [P,1].
    % y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
    % y_yearly - wektor danych rocznych (wektor kolumnowy).
    % y_approximation - tablica komórkowa przechowująca cztery wartości funkcji aproksymującej dane roczne.
    %   - y_approximation{i} stanowi aproksymację stopnia degrees(i)
    %   - y_approximation{i} stanowi wartości funkcji aproksymującej w punktach x_fine.
    % mse - wektor o rozmiarze [4,1]: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia degrees(i).

    country = 'Germany'; % Przykładowy kraj
    source = 'Solar';    % Przykładowe źródło energii
    degrees = [1, 2, 3, 4]; % Stopnie wielomianów

    % Sprawdzenie dostępności danych
    if isfield(energy, country) && isfield(energy.(country), source)
        % Przygotowanie danych do aproksymacji
        y_original = energy.(country).(source).EnergyProduction;

        % Obliczenie danych rocznych
        n_years = floor(length(y_original) / 12);
        y_cut = y_original(end - 12 * n_years + 1:end);
        y4sum = reshape(y_cut, [12 n_years]);
        y_yearly = sum(y4sum, 1)';

        N = length(y_yearly);
        P = 10 * N;
        x_coarse = linspace(-1, 1, N)';
        x_fine = linspace(-1, 1, P)';

        y_approximation = cell(1, length(degrees));
        mse = zeros(1, length(degrees));

        % Pętla po wielomianach różnych stopni
        for i = 1:length(degrees)
            % Wyznaczenie współczynników wielomianu
            p = my_polyfit(x_coarse, y_yearly, degrees(i));
            % Wyznaczenie wartości aproksymowanych
            y_approximation{i} = polyval(p, x_fine);
            % Obliczenie błędu średniokwadratowego
            y_fit = polyval(p, x_coarse);
            mse(i) = mean((y_yearly - y_fit).^2);
        end

        % Rysowanie wykresów
        figure;
        % Górny wykres
        subplot(2, 1, 1);
        plot(x_coarse, y_yearly, 'k', 'DisplayName', 'Dane roczne'); hold on;
        colors = ['r', 'g', 'b', 'm'];
        for i = 1:length(degrees)
            plot(x_fine, y_approximation{i}, colors(i), 'DisplayName', ['Stopień ' num2str(degrees(i))]);
        end
        xlabel('Czas');
        ylabel('Produkcja Energii (TWh)');
        title('Aproksymacja wielomianowa rocznej produkcji energii');
        legend show;
        hold off;

        % Dolny wykres
        subplot(2, 1, 2);
        bar(mse);
        set(gca, 'XTickLabel', degrees);
        xlabel('Stopień wielomianu');
        ylabel('Błąd średniokwadratowy (MSE)');
        title('Błąd średniokwadratowy dla różnych stopni wielomianu');

        % Zapisanie wykresów do pliku
        saveas(gcf, 'zadanie3.png');
    else
        disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
    end
end

function p = my_polyfit(x, y, deg)
    % Wyznaczanie współczynników wielomianu przy użyciu metody najmniejszych kwadratów
    X = ones(length(x), deg + 1);
    for i = 1:deg
        X(:, i + 1) = x.^i;
    end
    p = (X' * X) \ (X' * y);
    p = flip(p');
end
