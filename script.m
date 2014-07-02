% clear all;

text_output = true;
draw_sphere = true;

resolution_x = 1600;
resolution_y = 1200;

fov_h = deg2rad(64.6);

sphere_radius = 10;
focus_distance = 60;

min_overlap_v = 0;%.15;
min_overlap_h = 0;%.15;

aspect_ratio = resolution_y / resolution_x;

fov_v = aspect_ratio * fov_h;

[rows, overlap_v, fov_h_center, fov_v_center] = calcAngles(fov_h, fov_v, ...
                                                           focus_distance, sphere_radius, ...
                                                           min_overlap_h, min_overlap_v...
                                                           );
                           
if text_output
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
end

if draw_sphere
    phiStep = 5;
    thetaStep = 5;
    [x,y,z,c] = makeSphere(phiStep, thetaStep, rows, fov_h_center, fov_v_center);
    surf(x,y,z,c);
end
