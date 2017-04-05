// top plate - slots into the left and right plates and diffuses the fog
// makes 1, the total number required

// ASSEMBLY:
// slides into top rails provided by left and right plates, smallest holes on the right near the fog output

include <common.scad>

hole_dia_max = 10;
hole_dia_min = 3;
hole_grid_size = 15;
hole_spacing = box_depth / (hole_grid_size+2);

function map(x, in_min, in_max, out_min, out_max) = (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;

difference() {
    // main plate
    square([box_width-plate_height*2, box_depth]);
    
    // fog diffusion holes
    for(x = [0 : hole_grid_size]) {
        for(y = [0 : hole_grid_size]) {
            translate([x*hole_spacing+hole_spacing, y*hole_spacing+hole_spacing])
                circle(map(y, 0, hole_grid_size, hole_dia_min, hole_dia_max) / 2);
        }
    }
}
