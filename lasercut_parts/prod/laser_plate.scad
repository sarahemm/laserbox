// laser plate - slots into the left L-rails and under the bottom plate and holds all the lasers
// makes one, two are required

// ASSEMBLY:
// left laser plate slides into the sets of L-rails provided to hold it
// bottom laser plate slides into the rails on the left/right vertical plates, under the bottom plate

// MATERIAL:
// 4 square feet each * 2

include <common.scad>

laser_dia = 4;
hole_grid_size = 6;
hole_spacing = box_depth / (hole_grid_size+2);

difference() {
    // main plate
    square([box_width-plate_height*2, box_depth]);
    
    // laser mounting holes
    for(x = [0 : hole_grid_size]) {
        for(y = [0 : hole_grid_size]) {
            translate([x*hole_spacing+hole_spacing, y*hole_spacing+hole_spacing])
                circle(laser_dia/2);
        }
    }
}
