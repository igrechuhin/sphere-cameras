function [ rows, overlap_v, fov_h_center, fov_v_center ] = calcAngles(fov_h, fov_v, focus_distance, sphere_radius, min_overlap_h, min_overlap_v)
fov_h_center = 2*atan(tan(fov_h/2) * focus_distance / (focus_distance + sphere_radius));
fov_v_center = 2*atan(tan(fov_v/2) * focus_distance / (focus_distance + sphere_radius));

% disp('fov from center');
% disp(['horizontal: ', num2str(rad2deg(fov_h_center)), '   vertical: ', num2str(rad2deg(fov_v_center))]);

rows_count = ceil(deg2rad(180) / fov_v_center);
overlap_v = rows_count * fov_v_center / deg2rad(180) - 1;
if overlap_v > 1
    overlap_v = Inf;
end


while (overlap_v < min_overlap_v)
    rows_count = rows_count + 1;
    overlap_v = rows_count * fov_v_center / deg2rad(180) - 1;
end

rows = cell(rows_count + 1, 1);

for i = 0 : rows_count
    theta = deg2rad(180)*i/rows_count;
    
    sn = sin(theta);
    if abs(sn) > 1e-10
        if theta < pi/2
            sn = sin(theta + fov_v_center/2);
        elseif theta > pi/2
            sn = sin(theta - fov_v_center/2);
        end
    else
        sn = 0;
    end
    
    distort_sphere = deg2rad(360) * sn;
    cols_count = ceil(distort_sphere / fov_h_center) + 1;
    overlap_h = cols_count * fov_h_center / distort_sphere - 1;
    if overlap_h > 1
        overlap_h = Inf;
    end

    while (overlap_h < min_overlap_h)
        cols_count = cols_count + 1;
        overlap_h = cols_count * fov_h_center / distort_sphere - 1;
    end
    
    step = 360 / cols_count;
    
    row_info = struct('num_of_pic', cols_count, ...
                      'overlap_h', floor(overlap_h*100), ...
                      'theta', rad2deg(theta), ...
                      'step', step, ...
                      'phi', (0:cols_count-1) * step...
                      );
    
    rows{i+1} = row_info;
end

end

