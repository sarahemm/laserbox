// right vertical rails - rails that go onto the vertical plate to hold the top plate and bottom plate
// makes all required rails for right vertical plate

// ASSEMBLY:
// one set of rails goes plate_height from the top on the vertical plate, to hold the top plate
// one set of rails goes plate_height from the bottom on the vertical plate, to hold the bottom plate

// MATERIAL:
// 0.42 square feet (24in x 2.5in)

include <common.scad>

rail_width = inch_to_mm(0.5);
rail_spacing = 3;

// rails to hold bottom and top plates
for(rail_nbr = [0 : 3]) {
    translate([0, rail_nbr * (rail_width+rail_spacing)])
        square([box_depth, rail_width]);
}
