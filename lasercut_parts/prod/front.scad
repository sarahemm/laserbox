// front - not sure how this will attach yet but it goes on the front and covers the infrastructure bits
// makes 1, the total number required

// ASSEMBLY:
// TBD!
// TODO: figure out how this will attach, ideally hinges of some kind
// TODO: add windows for various sensors and resource collection

include <common.scad>

difference() {
    // main plate
    square([box_height, box_width]);
    
    // cutout for the interesting bits
    translate([plate_height, plate_height])
        square([box_height - plate_height*2, box_width - plate_height*2]);
}
