function plot_problem_5(N, time_Jacobi, time_Gauss_Seidel, iterations_Jacobi, iterations_Gauss_Seidel)
    % Pierwszy wykres: zależność czasu obliczeń od rozmiaru macierzy
    subplot(2,1,1);
    plot(N, time_Jacobi, 'b', 'LineWidth', 2);
    hold on;
    plot(N, time_Gauss_Seidel, 'r', 'LineWidth', 2);
    hold off;
    title('Zależność czasu obliczeń od rozmiaru macierzy');
    xlabel('Rozmiar macierzy');
    ylabel('Czas [s]');
    legend('Metoda Jacobiego', 'Metoda Gaussa-Seidla', 'Location', 'eastoutside');

    % Drugi wykres: liczba iteracji wymagana do wyznaczenia rozwiązania
    subplot(2,1,2);
    bar(N, [iterations_Jacobi ; iterations_Gauss_Seidel]);
    title('Liczba iteracji wymagana do wyznaczenia rozwiązania');
    xlabel('Rozmiar macierzy');
    ylabel('Liczba iteracji');
    legend('Metoda Jacobiego', 'Metoda Gaussa-Seidla', 'Location', 'eastoutside');

    saveas(gcf, 'zadanie5.png');
end
