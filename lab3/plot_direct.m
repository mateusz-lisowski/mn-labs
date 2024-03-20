function plot_direct(N, vtime_direct)
  
    plot(N, vtime_direct, '-o', 'LineWidth', 2);

    title('Czas wyznaczenia rozwiązania równania macierzowego (metoda bezpośrednia)');
    xlabel('Rozmiar macierzy (N)');
    ylabel('Czas [s]');
    
    grid on;
    
    legend('Czas wyznaczenia rozwiązania', 'Location', 'northwest');

end
