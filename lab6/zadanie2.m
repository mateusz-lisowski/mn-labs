function [country, source, degrees, y_original, y_movmean, y_approximation, mse] = zadanie2(energy)
    % Głównym celem tej funkcji jest wyznaczenie aproksymacji wygładzonych danych o produkcji energii elektrycznej w wybranym kraju i z wybranego źródła energii.
    % Wygładzenie danych wykonane jest poprzez wywołanie funkcji movmean.
    % Wybór kraju i źródła energii należy określić poprzez nadanie w tej funkcji wartości zmiennym typu string: country, source.
    % Dopuszczalne wartości tych zmiennych można sprawdzić poprzez sprawdzenie zawartości struktury energy zapisanej w pliku energy.mat.
    % 
    % energy - struktura danych wczytana z pliku energy.mat
    % country - [String] nazwa kraju
    % source  - [String] źródło energii
    % degrees - wektor zawierający cztery stopnie wielomianu dla których wyznaczono aproksymację
    % y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
    % y_movmean - średnia 12-miesięczna danych wejściowych, y_movmean = movmean(y_original,[11,0]);
    % y_approximation - tablica komórkowa przechowująca cztery wartości funkcji aproksymującej wygładzone dane wejściowe. y_approximation stanowi aproksymację stopnia degrees(i).
    % mse - wektor o rozmiarze 4x1: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia degrees(i).

    country = 'Germany'; % Przykładowy kraj
    source = 'Solar';    % Przykładowe źródło energii
    degrees = [1, 5, 10, 20]; % Stopnie wielomianów

    % Sprawdzenie dostępności danych
    if isfield(energy, country) && isfield(energy.(country), source)
        % Przygotowanie danych do aproksymacji
        y_original = energy.(country).(source).EnergyProduction;
        y_movmean = movmean(y_original, [11, 0]);

        x = linspace(-1, 1, length(y_original))';

        y_approximation = cell(1, length(degrees));
        mse = zeros(1, length(degrees));

        % Pętla po wielomianach różnych stopni
        for i = 1:length(degrees)
            % Wyznaczenie współczynników wielomianu
            p = polyfit(x, y_movmean, degrees(i));
            % Wyznaczenie wartości aproksymowanych
            y_approximation{i} = polyval(p, x);
            % Obliczenie błędu średniokwadratowego
            mse(i) = mean((y_movmean - y_approximation{i}).^2);
        end

        % Rysowanie wykresów
        figure;
        % Górny wykres
        subplot(2, 1, 1);
        plot(x, y_original, 'k', 'DisplayName', 'Oryginalne dane'); hold on;
        plot(x, y_movmean, 'b', 'DisplayName', 'Dane wygładzone');
        colors = ['r', 'g', 'm', 'c'];
        for i = 1:length(degrees)
            plot(x, y_approximation{i}, colors(i), 'DisplayName', ['Stopień ' num2str(degrees(i))]);
        end
        xlabel('Czas');
        ylabel('Produkcja Energii (TWh)');
        title('Aproksymacja wielomianowa produkcji energii (dane wygładzone)');
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
        saveas(gcf, 'zadanie2.png');
    else
        disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
    end
end
