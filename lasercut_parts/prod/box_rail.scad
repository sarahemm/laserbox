// box rail - these screw into the main box and provide slots for the vertical plates to go into
// makes 8, the total number required

// MATERIAL:
// 1.51 square feet

include <common.scad>

rail_width = inch_to_mm(1);
rail_spacing = 3;
hole_dia = 7;

for(rail_nbr = [0 : 7]) {
    translate([0, rail_nbr * (rail_width+rail_spacing), 0])
        box_rail();
}

module box_rail() {
    difference() {
        square([box_depth, rail_width]);
        translate([box_depth/8, rail_width/2, 0])
            circle(hole_dia/2);
        translate([box_depth/2, rail_width/2, 0])
            circle(hole_dia/2);
        translate([box_depth-box_depth/8, rail_width/2, 0])
            circle(hole_dia/2);
    }
}