// left vertical plate - slots into the left box rails and holds the left laser plate, top plate, and bottom plate
// makes 1 plate (the total number required) and all required rails

// ASSEMBLY:
// one set of rails goes plate_height from the top to hold the top plate
// one set of rails goes plate_height from the bottom to hold the bottom plate
// one set of rails goes material_thickness under the bottom plate rail to hold the bottom laser plate
// the L-rails hold the left laser plate in the centre

include <common.scad>

rail_width = inch_to_mm(0.5);
rail_spacing = 3;

wiring_hole_width = inch_to_mm(5);
wiring_hole_height = inch_to_mm(3);

difference() {
    // main plate
    square([box_height, box_depth]);
    
    // wiring pass-through
    translate([plate_height/2, box_depth/2 - wiring_hole_width/2, 0])
        square([wiring_hole_height, wiring_hole_width]);
}

// rails to hold bottom and top plates
translate([0, box_depth + rail_spacing*2, 0]) {
    for(rail_nbr = [0 : 4]) {
        translate([0, rail_nbr * (rail_width+rail_spacing), 0])
            square([box_depth, rail_width]);
    }
}

// L-rails to hold slide-in left laser plate
translate([0, box_depth + rail_spacing*4 + 5*(rail_width + rail_spacing), 0]) {
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