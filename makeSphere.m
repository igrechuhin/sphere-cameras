function [ x, y, z, c ] = makeSphere(phiStep, thetaStep, rows, fov_h_center, fov_v_center)
r = 1.0;

half_fov_h = rad2deg(fov_h_center/2);
half_fov_v = rad2deg(fov_v_center/2);

i = 1;
c = zeros(180/thetaStep + 1, 360/phiStep + 1);
x = zeros(180/thetaStep + 1, 360/phiStep + 1);
y = zeros(180/thetaStep + 1, 360/phiStep + 1);
z = zeros(180/thetaStep + 1, 360/phiStep + 1);
for theta = 0:thetaStep:180
    j = 1;
    for phi = 0:phiStep:360
        x(i,j) = r * sin(theta*pi/180) * cos(phi*pi/180);
        y(i,j) = r * sin(theta*pi/180) * sin(phi*pi/180);
        z(i,j) = r * cos(theta*pi/180);

        color = 0;
        for r = 1:length(rows)
            if abs(theta - rows{r}.theta) < half_fov_v
                mark = false;
                color = 16*(r-1)/length(rows);
                rowColor = color;
                if length(rows{r}.phi) == 1
                    mark = true;
                else
                    for col = 1:length(rows{r}.phi)
                        if abs(phi - rows{r}.phi(col)) < half_fov_h || ...
                                abs(phi - rows{r}.phi(col) - 360) < half_fov_h
                            mark = true;
                            color = color + 10;
                        end
                    end
                end
                if mark
                    c(i,j) = c(i,j) + color;
                end
            end
        end
        j = j + 1;
    end
    i = i + 1;
end

end

