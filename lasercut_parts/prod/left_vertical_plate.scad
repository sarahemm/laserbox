// left vertical plate - slots into the left box rails and holds the left laser plate, top plate, and bottom plate
// makes 1 plate (the total number required)

// MATERIAL:
// 6 square feet (24in x 36in)

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
