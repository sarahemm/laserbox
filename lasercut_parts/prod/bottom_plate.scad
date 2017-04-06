// bottom plate - slots into the rails on the left/right vertical plates and holds the fog in
// makes 1, the total number required

// ASSEMBLY:
// bottom plate slides into the rails on the left/right vertical plates, above the bottom laser plate

// MATERIAL
// 4 square feet - fits in scrap from front

include <common.scad>

difference() {
    // main plate
    square([box_width-plate_height*2, box_depth]);
}
