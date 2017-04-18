// right vertical plate - slots into the right box rails and holds the fans, top plate, and bottom plate
// makes 1 plate (the total number required)

// MATERIAL:
// 6 square feet (24in x 36in)

include <common.scad>

wiring_hole_width = inch_to_mm(5);
wiring_hole_height = inch_to_mm(3);

difference() {
    // main plate
    square([box_height, box_depth]);
    
    // fan mounting holes
    translate([box_height-plate_height/2, box_depth/5])
        fan_holes();
    translate([box_height-plate_height/2, box_depth-box_depth/5])
        fan_holes();
    translate([box_height-plate_height/2, box_depth-box_depth/2])
        fan_holes();
    
    // wiring pass-through
    translate([plate_height/2, box_depth/2 - wiring_hole_width/2, 0])
        square([wiring_hole_height, wiring_hole_width]);
}

// holes for a Mechatronics G4020 fan
module fan_holes() {
    hole_spacing = 32;
    hole_dia = 4;
    
    // mounting holes
    translate([hole_spacing/2, hole_spacing/2])
        circle(hole_dia/2);
    translate([-hole_spacing/2, hole_spacing/2])
        circle(hole_dia/2);
    translate([hole_spacing/2, -hole_spacing/2])
        circle(hole_dia/2);
    translate([-hole_spacing/2, -hole_spacing/2])
        circle(hole_dia/2);

    // air hole
    circle(hole_spacing/2);
}
