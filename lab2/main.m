clear all
close all
format compact

n_max = 200;
a = 10;
r_max = 5;

[circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max);
[numer_indeksu, Edges, I, B, A, b, r] = page_rank();
% plot_circles(a, circles, index_number); 
% plot_circle_areas(circle_areas)
% plot_counts_mean(counts_mean);
% plot_page_rank(r);
% print -dpng zadanie1.png 