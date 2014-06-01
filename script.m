clear all;

resolution_x = 1600;
resolution_y = 1200;

fov_h = deg2rad(64.6);

sphere_radius = 10;
focus_distance = 60;

min_overlap_v = 0;%.15;
min_overlap_h = 0;%.15;

aspect_ratio = resolution_y / resolution_x;

fov_v = aspect_ratio * fov_h;

fov_h_center = 2*atan(tan(fov_h/2) * focus_distance / (focus_distance + sphere_radius));
fov_v_center = 2*atan(tan(fov_v/2) * focus_distance / (focus_distance + sphere_radius));

% disp('fov from center');
% disp(['horizontal: ', num2str(rad2deg(fov_h_center)), '   vertical: ', num2str(rad2deg(fov_v_center))]);

rows_count = floor(deg2rad(180) / fov_v_center);
overlap_v = (rows_count+1) * fov_v_center / deg2rad(180) - 1;
if overlap_v > 1
    overlap_v = Inf;
end


while (overlap_v < min_overlap_v)
    rows_count = rows_count + 1;
    overlap_v = (rows_count+1) * fov_v_center / deg2rad(180) - 1;
end

rows = cell(rows_count+1, 1);

for i = 0 : rows_count
    theta = deg2rad(180)*i/rows_count;
    
    distort_sphere = deg2rad(360) * sin(theta);
    cols_count = floor(distort_sphere / fov_h_center  + 1);
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

total_num = 0;
for i = 1 : length(rows)
    r = rows{i};
    disp(['Row: ',num2str(i),'  Pics: ',num2str(r.num_of_pic),'  Overlap (%): ',num2str(r.overlap_h),'  Theta (deg): ', num2str(r.theta), '  Step (deg): ', num2str(r.step)]);
    for j = 1:r.num_of_pic
        disp(['   Pic#: ',num2str(j),'  Theta (deg): ', num2str(r.theta), '  Phi (deg): ', num2str(r.phi(j))]);
    end
    total_num = total_num + r.num_of_pic;
end

disp(['Vertical overlap (%): ', num2str(floor(overlap_v*100))]);
disp(['Total number of images: ', num2str(total_num)]);