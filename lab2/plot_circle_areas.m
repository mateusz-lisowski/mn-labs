function plot_circle_areas(circle_areas)
    
    hold on;
    
    plot(circle_areas, '-o');
    
    xlabel("number of areas")
    ylabel("area sum");
    title("Circle Areas");

    hold off;

    % print -dpng zadanie3.png 
end
