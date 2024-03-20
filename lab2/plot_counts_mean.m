function plot_counts_mean(counts_mean)
    hold on;
    
    plot(counts_mean, '-o');
    
    xlabel("cumulativ probablity");
    ylabel("number of circles");
    title("Cumulative Probablility");

    hold off;
    % print -dpng zadanie5.png 
end
