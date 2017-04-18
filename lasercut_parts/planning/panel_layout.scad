module plate(x, y, height, width, rotation, name) {
    translate([x, y]) {
        rotate([0, 0, rotation]) {
            color(rands(0, 1, 3))
                square([height, width]);
            color([1, 1, 1])
                translate([height/2, width/2])
                    raised_text(name);
        }
    }
}

module raised_text(text_string) {
    translate([0, 0, 0.1])
        text(text_string, size=2, halign="center", valign="center");
}


// first sheet of material
color([0.8, 0.8, 0.8])
    translate([0, 0, -1])
        square([48, 96]);

// second sheet of material
color([0.8, 0.8, 0.8])
    translate([50, 0, -1])
        square([48, 48]);

// all the panels
plate(0,  0,    24, 24,  0,  "Laser Plate L");
plate(24, 0,    24, 24,  0,  "Laser Plate B");

plate(0,  24,   24, 24,  0,  "Top Plate");

plate(24, 24,   24, 9,   0,  "Box Rails");
plate(24, 33,   24, 2.5, 0,  "Right Rails");
plate(24, 35.5, 24, 9,   0,  "Left Rails");

plate(24, 48,   36, 24,  90, "Left Vert");
plate(48, 48,   36, 24,  90, "Right Vert");

plate(50,  0,   36, 36,  0,  "Front");
