function plot_circles(a, circles, index_number)
    hold on;
    [n, ~] = size(circles); 
    for i = 1:n
        plot_circle(circles(i, 3), circles(i, 1), circles(i, 2));
    end
    hold off;
end
