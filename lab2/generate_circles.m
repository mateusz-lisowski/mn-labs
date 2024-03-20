function [circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max)
    
    index_number = 193396; % numer Twojego indeksu
    L1 = 6;
    circles = zeros(n_max, 3);
    circle_areas = zeros(1, n_max);
    rand_counts = zeros(1, n_max);

    n = 1;
    curr_tries = 0;
    while n <= n_max
        
        new_x = rand * a;
        new_y = rand * a;
        new_r = rand * r_max;
    
        
        curr_tries = curr_tries + 1;
        if new_x < new_r || new_y < new_r || a - new_x < new_r || a - new_y < new_r
            continue;
        end

        found = false;
        for i = 1:n
            cx = circles(i, 1);
            cy = circles(i, 2);
            cr = circles(i, 3);
    
            if (new_x - cx) * (new_x - cx) + (new_y - cy) * (new_y - cy) < (new_r + cr) * (new_r + cr)
                found = true;
                break;
            end
        end

        if ~found
            circles(i, 1) = new_x;
            circles(i, 2) = new_y;
            circles(i, 3) = new_r;

            rand_counts(1, n) = curr_tries;
            curr_tries = 0;

            n = n + 1;
        end
    
    end

    for i = 1:n_max
        circle_areas(i) = pi * circles(i, 3) * circles(i, 3); 
    end
    
    circle_areas = cumsum(circle_areas, 2);
    circle_areas = circle_areas';

    cum_sum = cumsum(rand_counts, 2);
    counts_mean = cum_sum ./ (1:numel(rand_counts));
    
end

