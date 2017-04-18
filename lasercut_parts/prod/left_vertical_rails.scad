// left vertical rails - rails that go onto the left vertical plate to hold the
//                       left laser plate, top plate, and bottom plate
// makes all required rails

// ASSEMBLY:
// one set of rails goes plate_height from the top to hold the top plate
// one set of rails goes plate_height from the bottom to hold the bottom plate
// one set of rails goes material_thickness under the bottom plate rail to hold the bottom laser plate
// the L-rails hold the left laser plate in the centre

// MATERIAL:
// 1.5 square feet (24in x 9in)

include <common.scad>

rail_width = inch_to_mm(0.5);
rail_spacing = 3;

// rails to hold bottom and top plates
for(rail_nbr = [0 : 4]) {
    translate([0, rail_nbr * (rail_width+rail_spacing), 0])
        square([box_depth, rail_width]);
}

// L-rails to hold slide-in left laser plate
translate([0, 5*(rail_width + rail_spacing), 0]) {
    l_rails(box_depth, rail_width*2, rail_spacing, 2);
}

// make both parts of one L-rail to hold a plate that slides in (normally need two sets of these)
module l_rails(length, width, spacing, sets_to_make) {
    for(rail_nbr = [0 : sets_to_make-1]) {
        translate([0, rail_nbr * (rail_width*2 + rail_width*2.5 + rail_spacing*6), 0]) {
            square([length, width]);
            translate([0, width + spacing, 0])
                square([length, width*1.5]);
        }
    }
}