function [lake_volume, x, y, z, zmin] = zadanie5()

    num_points = 1e6;
    zmin = -50;
    x = 100 * rand(1,num_points); % [m]
    y = 100 * rand(1,num_points); % [m]
    z = zmin * rand(1,num_points); % [m]

    z_lake = arrayfun(@get_lake_depth, x, y);

    num_below_lake = sum(z > z_lake);

    V = 100 * 100 * -zmin;
    lake_volume = num_below_lake  / num_points * V;

end