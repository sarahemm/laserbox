nbr_lasers = 36;
laser_spacing = 5;

for(x = [0 : sqrt(nbr_lasers)]) {
    for(y = [0 : sqrt(nbr_lasers)]) {
        translate([x * laser_spacing, y * laser_spacing])
            circle(2);
    }
}