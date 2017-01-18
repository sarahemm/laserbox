$fa = 0.05;
$fs = 0.05;

// 0 = empty box (no lasers)
// 1 = full grid (non-animated)
// 2 = animated single-laser (fairly obsolete now that demo 4 exists)
// 3 = animated flickering laser grid
// 4 = animated multi-laser

demo_type = 4;
cover_closed = 1;
glass_exists = 0;
cut_away = 0;

// animation frame data for demo 2
v_frames = [
    [6,1],
    [5,2],
    [4,3],
    [3,4],
    [2,5],
    [1,6],
    [2,5],
    [3,4],
    [4,3],
    [5,2]
];

h_frames = [
    [1,1],
    [2,2],
    [3,3],
    [4,4],
    [5,5],
    [6,6],
    [5,1],
    [4,2],
    [2,3],
    [1,4]
];

// animation frame data for demo 4
multiframes_circlemissing = [
    [/*[4,3], [4,4],*/ [5,5], [6,6], [7,6], [8,5], [9,4], [9,3], [8,2], [7,1], [6,1], [5,2]],
    [[4,3], /*[4,4], [5,5],*/ [6,6], [7,6], [8,5], [9,4], [9,3], [8,2], [7,1], [6,1], [5,2]],
    [[4,3], [4,4], /*[5,5], [6,6],*/ [7,6], [8,5], [9,4], [9,3], [8,2], [7,1], [6,1], [5,2]],
    [[4,3], [4,4], [5,5], /*[6,6], [7,6],*/ [8,5], [9,4], [9,3], [8,2], [7,1], [6,1], [5,2]],
    [[4,3], [4,4], [5,5], [6,6], /*[7,6], [8,5],*/ [9,4], [9,3], [8,2], [7,1], [6,1], [5,2]],
    [[4,3], [4,4], [5,5], [6,6], [7,6], /*[8,5], [9,4],*/ [9,3], [8,2], [7,1], [6,1], [5,2]],
    [[4,3], [4,4], [5,5], [6,6], [7,6], [8,5], /*[9,4], [9,3],*/ [8,2], [7,1], [6,1], [5,2]],
    [[4,3], [4,4], [5,5], [6,6], [7,6], [8,5], [9,4], /*[9,3], [8,2],*/ [7,1], [6,1], [5,2]],
    [[4,3], [4,4], [5,5], [6,6], [7,6], [8,5], [9,4], [9,3], /*[8,2], [7,1],*/ [6,1], [5,2]],
    [[4,3], [4,4], [5,5], [6,6], [7,6], [8,5], [9,4], [9,3], [8,2], /*[7,1], [6,1],*/ [5,2]]    
];

multiframes_square = [
    [[1,1],[1,2],[1,3],[1,4],[1,5],[1,6]],
    [[1,1],[2,1],[3,1],[4,1],[5,1],[6,1],[7,1],[8,1],[9,1]],
    [[9,1],[9,2],[9,3],[9,4],[9,5],[9,6]],
    [[1,6],[2,6],[3,6],[4,6],[5,6],[6,6],[7,6],[8,6],[9,6]],
    
    [[1,1],[1,2],[1,3],[1,4],[1,5],[1,6]],
    [[1,1],[2,1],[3,1],[4,1],[5,1],[6,1],[7,1],[8,1],[9,1]],
    [[9,1],[9,2],[9,3],[9,4],[9,5],[9,6]],
    [[1,6],[2,6],[3,6],[4,6],[5,6],[6,6],[7,6],[8,6],[9,6]],
    
    [[1,1],[1,2],[1,3],[1,4],[1,5],[1,6]],
    [[1,1],[2,1],[3,1],[4,1],[5,1],[6,1],[7,1],[8,1],[9,1]]
];

multiframes_xy = [
    [[1,1],[1,2],[1,3],[1,4],[1,5],[1,6],  [1,1],[2,1],[3,1],[4,1],[5,1],[6,1]],
    [[2,1],[2,2],[2,3],[2,4],[2,5],[2,6],  [1,2],[2,2],[3,2],[4,2],[5,2],[6,2]],
    [[3,1],[3,2],[3,3],[3,4],[3,5],[3,6],  [1,3],[2,3],[3,3],[4,3],[5,3],[6,3]],
    [[4,1],[4,2],[4,3],[4,4],[4,5],[4,6],  [1,4],[2,4],[3,4],[4,4],[5,4],[6,4]],
    [[5,1],[5,2],[5,3],[5,4],[5,5],[5,6],  [1,5],[2,5],[3,5],[4,5],[5,5],[6,5]],
    
    [[6,1],[6,2],[6,3],[6,4],[6,5],[6,6],  [1,6],[2,6],[3,6],[4,6],[5,6],[6,6]],
    
    [[5,1],[5,2],[5,3],[5,4],[5,5],[5,6],  [1,5],[2,5],[3,5],[4,5],[5,5],[6,5]],
    [[4,1],[4,2],[4,3],[4,4],[4,5],[4,6],  [1,4],[2,4],[3,4],[4,4],[5,4],[6,4]],
    [[3,1],[3,2],[3,3],[3,4],[3,5],[3,6],  [1,3],[2,3],[3,3],[4,3],[5,3],[6,3]],
    [[2,1],[2,2],[2,3],[2,4],[2,5],[2,6],  [1,2],[2,2],[3,2],[4,2],[5,2],[6,2]],
];

multiframes_grid_v = [
    [[1,1],[1,2],[1,3],[1,4],[1,5],[1,6]],
    [[2,1],[2,2],[2,3],[2,4],[2,5],[2,6]],
    [[3,1],[3,2],[3,3],[3,4],[3,5],[3,6]],
    [[4,1],[4,2],[4,3],[4,4],[4,5],[4,6]],
    [[5,1],[5,2],[5,3],[5,4],[5,5],[5,6]],
    
    [[6,1],[6,2],[6,3],[6,4],[6,5],[6,6]],
    
    [[5,1],[5,2],[5,3],[5,4],[5,5],[5,6]],
    [[4,1],[4,2],[4,3],[4,4],[4,5],[4,6]],
    [[3,1],[3,2],[3,3],[3,4],[3,5],[3,6]],
    [[2,1],[2,2],[2,3],[2,4],[2,5],[2,6]],
];

multiframes_grid_h = [
    [[1,1],[2,1],[3,1],[4,1],[5,1],[6,1]],
    [[1,2],[2,2],[3,2],[4,2],[5,2],[6,2]],
    [[1,3],[2,3],[3,3],[4,3],[5,3],[6,3]],
    [[1,4],[2,4],[3,4],[4,4],[5,4],[6,4]],
    [[1,5],[2,5],[3,5],[4,5],[5,5],[6,5]],
    
    [[1,6],[2,6],[3,6],[4,6],[5,6],[6,6]],
    
    [[1,5],[2,5],[3,5],[4,5],[5,5],[6,5]],
    [[1,4],[2,4],[3,4],[4,4],[5,4],[6,4]],
    [[1,3],[2,3],[3,3],[4,3],[5,3],[6,3]],
    [[1,2],[2,2],[3,2],[4,2],[5,2],[6,2]],
];

multiframes_multigrid_v = [
    [[1,1],[1,2],[1,3],[1,4],[1,5],[1,6],  [9,1],[9,2],[9,3],[9,4],[9,5],[9,6]],
    [[2,1],[2,2],[2,3],[2,4],[2,5],[2,6],  [8,1],[8,2],[8,3],[8,4],[8,5],[8,6]],
    [[3,1],[3,2],[3,3],[3,4],[3,5],[3,6],  [7,1],[7,2],[7,3],[7,4],[7,5],[7,6]],
    [[4,1],[4,2],[4,3],[4,4],[4,5],[4,6],  [6,1],[6,2],[6,3],[6,4],[6,5],[6,6]],
    
    [[5,1],[5,2],[5,3],[5,4],[5,5],[5,6]],
    [[5,1],[5,2],[5,3],[5,4],[5,5],[5,6]],
    
    [[4,1],[4,2],[4,3],[4,4],[4,5],[4,6],  [6,1],[6,2],[6,3],[6,4],[6,5],[6,6]],
    [[3,1],[3,2],[3,3],[3,4],[3,5],[3,6],  [7,1],[7,2],[7,3],[7,4],[7,5],[7,6]],
    [[2,1],[2,2],[2,3],[2,4],[2,5],[2,6],  [8,1],[8,2],[8,3],[8,4],[8,5],[8,6]],
    [[1,1],[1,2],[1,3],[1,4],[1,5],[1,6],  [9,1],[9,2],[9,3],[9,4],[9,5],[9,6]],
];

multiframes_multigrid_h = [
    [[1,1],[2,1],[3,1],[4,1],[5,1],[6,1],  [1,9],[2,9],[3,9],[4,9],[5,9],[6,9]],
    [[1,2],[2,2],[3,2],[4,2],[5,2],[6,2],  [1,8],[2,8],[3,8],[4,8],[5,8],[6,8]],
    [[1,3],[2,3],[3,3],[4,3],[5,3],[6,3],  [1,7],[2,7],[3,7],[4,7],[5,7],[6,7]],
    [[1,4],[2,4],[3,4],[4,4],[5,4],[6,4],  [1,6],[2,6],[3,6],[4,6],[5,6],[6,6]],
    
    [[1,5],[2,5],[3,5],[4,5],[5,5],[6,5],  [1,5],[2,5],[3,5],[4,5],[5,5],[6,5]],
    [[1,5],[2,5],[3,5],[4,5],[5,5],[6,5],  [1,5],[2,5],[3,5],[4,5],[5,5],[6,5]],

    [[1,4],[2,4],[3,4],[4,4],[5,4],[6,4],  [1,6],[2,6],[3,6],[4,6],[5,6],[6,6]],
    [[1,3],[2,3],[3,3],[4,3],[5,3],[6,3],  [1,7],[2,7],[3,7],[4,7],[5,7],[6,7]],
    [[1,2],[2,2],[3,2],[4,2],[5,2],[6,2],  [1,8],[2,8],[3,8],[4,8],[5,8],[6,8]],
    [[1,1],[2,1],[3,1],[4,1],[5,1],[6,1],  [1,9],[2,9],[3,9],[4,9],[5,9],[6,9]],
];

multiframes_empty = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
];

v_multiframes = multiframes_multigrid_v;
h_multiframes = multiframes_multigrid_h;

// STRUCTURE
// outer box
if(!cut_away)
    color([0.7,0.7,0.7,1]) {
        // bottom
        translate([-1,0,-0.5])
            cube([37,36,1]);
        // left side
        rotate([90,0,0])
            translate([-1,-0.5,-0.5])
                cube([37,37.5,1]);
        // back
        rotate([0,-90,0])
            cube([36,36,1]);
        // top
        translate([-1,0,36])
            cube([37,36,1]);
        // right side
        translate([-1,36.5,-0.5])
            rotate([90,0,0])
                cube([37,37.5,1]);
    }

// dividers for electronics/water reservoir/fog distribution chamber
color([0.5,0.5,0.5,1]) {
    // bottom divider
    translate([0,0.5,4])
        cube([36,31,0.5]);
    
    // water divider
    rotate([90,0,0]) {
        translate([0,0.5,-(36-4)]) {
            difference() {
                cube([36,35.5,0.5]);
                // holes for fog to pass through
                for(x=[1:4]) {
                    translate([x*7.5-0.5,34.25,-0.25])
                        cylinder(h=1, d=1.25);
                }
            }
        }
    }
    // left laser chamber divider
    rotate([90,0,0])
        translate([0,0.5,-4])
            cube([36,35.5,0.5]);
    
    // fog distribution plate
    translate([0,0.5,33]) {
        difference() {
            cube([36,31,0.5]);
            for(x=[1:10], y=[1:10]) {
                translate([x*3.2+1,y*2.8+1.75,-0.4])
                    cylinder(h=1, d=0.5);
            }
        }
    }
}

// fans in reservoir
translate([-0.75,31.5,34])
    rotate([90,0,0])
        for(x=[1:4])
            translate([x*7.5-0.5,0,0])
                fan();

// water in reservoir
color([0.5,0.6,0.7,0.5])
        translate([0,32,0.5])
            cube([35,3.5,25.25]);

// fogger in water reservoir
translate([20,34,26]) {
    // fogger body
    color([0.5,0.5,0.5,1]) {
        union() {
            translate([-1,0,-0.25])
                cylinder(d=1, h=0.25);
            translate([6,0,-0.25])
                cylinder(d=1, h=0.25);
            translate([-1,-0.5,-0.25])
                cube([7,1,0.25]);
        }
    }
    
    // fogging elements
    color([1,1,1,1]) {
        for(x=[0:5])
            translate([x*1,0,0])
                cylinder(d=0.7, h=0.1);
    }
}

// front cover
if(!cut_away)
    translate([36,0,0]) {
        rotate([cover_closed ? 0 : 90,0,cover_closed ? 0 : 45]) {
            color([1,1,1,1]) {
                difference() {
                    // cover
                    cube([0.5,36,36.5]);
                    // cutout for viewing
                    translate([-0.1,4,4.5])
                        cube([0.7,27.5,28.5]);
                    if(cover_closed) {
                        // gesture sensor
                        translate([-0.1,17,2])
                            cube([0.7,1.5,1]);
                    }
                }
            }
            // hide the gesture sensor if the cover is open
            // ideally it would appear both ways but getting it in the right place is hard
            if(cover_closed) {
                // gesture sensor glass
                translate([-0.1,17,2])
                    color([0,0.1,0.1,0.5])
                        cube([0.7,1.5,1]);
            }
            // cutout for viewing
            if(cover_closed == 0 || glass_exists == 1)
                translate([-0.1,4,4.5])
                    color([0,1,1,0.2])
                        cube([0.7,27.5,28.5]);
        }
    }

// circuit board
color([0,0.7,0,1])
    translate([28,15,0.5])
        cube([5,5,0.25]);
 
// LASERS
nbr_lasers_x = 9;
nbr_lasers_y = 6;
nbr_lasers_z = 6;
laser_space_x = 32;
laser_space_y = 28;
laser_space_z = 29;

// laser modules
translate([0.5,3.5,3]) {
    // vertical laser modules
    for(x = [1 : nbr_lasers_x], y = [1 : nbr_lasers_y]) {
        translate([x*laser_space_x/(nbr_lasers_x+1),y*laser_space_y/(nbr_lasers_y+1),0])
            color([1,1,0,1])
                cylinder(h=1, r=0.254);
    }
    
    // horizontal laser modules
    rotate([-90,-90,0]) {
        for(x = [1 : nbr_lasers_z], y = [1 : nbr_lasers_x]) {
            translate([x*laser_space_z/(nbr_lasers_z+1)+1,y*laser_space_x/(nbr_lasers_x+1),-1])
                color([1,1,0,1])
                    cylinder(h=1, r=0.254);
        }
    }
}

// DEMOS

// full laser grid (non-animated) and flickering laser grid
// which one just changes the 'flicker' parameter
if(demo_type == 1 || demo_type == 3) {
    translate([0.5,3.5,4]) {
        laser_grid(
            how_many_x=nbr_lasers_x, how_many_y=nbr_lasers_y,
            size_x=laser_space_x, size_y=laser_space_y,
            length=laser_space_z,
            flicker=((demo_type % 3) - 1)
        );
        rotate([-90,-90,0])
            laser_grid(
                how_many_x=nbr_lasers_z, how_many_y=nbr_lasers_x,
                size_x=laser_space_z, size_y=laser_space_x,
                length=laser_space_y,
                flicker=((demo_type % 3)-1)
            );
    }
}

// single-laser animation
if(demo_type == 2) {
    translate([0.5,3.5,4]) {
        one_laser(
            how_many_x=nbr_lasers_x, how_many_y=nbr_lasers_y,
            size_x=laser_space_x, size_y=laser_space_y,
            length=laser_space_z,
            x_lit=v_frames[$t*10][0], y_lit=v_frames[$t*10][1]
        );
        rotate([-90,-90,0])
            one_laser(
                how_many_x=nbr_lasers_y, how_many_y=nbr_lasers_y,
                size_x=laser_space_z, size_y=laser_space_x,
                length=laser_space_y,
                x_lit=h_frames[$t*10][0], y_lit=h_frames[$t*10][1]
            );
    }
}

// multi-laser animation
if(demo_type == 4) {
    translate([0.5,3.5,4]) {
        for(idx=[0:len(v_multiframes[$t*10])-1]) {
            one_laser(
                how_many_x=nbr_lasers_x, how_many_y=nbr_lasers_y,
                size_x=laser_space_x, size_y=laser_space_y,
                length=laser_space_z,
                x_lit=v_multiframes[$t*10][idx][0], y_lit=v_multiframes[$t*10][idx][1]
            );
        }
        for(idx=[0:len(h_multiframes[$t*10])-1]) {
            rotate([-90,-90,0])
                one_laser(
                    how_many_x=nbr_lasers_z, how_many_y=nbr_lasers_x,
                    size_x=laser_space_z, size_y=laser_space_x,
                    length=laser_space_y,
                    x_lit=h_multiframes[$t*10][idx][0], y_lit=h_multiframes[$t*10][idx][1]
                );
        }
    }
}

module laser_grid(how_many_x, how_many_y, size_x, size_y, length, flicker=0) {
    for(x = [1 : how_many_x], y = [1 : how_many_y]) {
        translate([x*size_x/(how_many_x+1),y*size_y/(how_many_y+1),0])
            if(flicker==0) {
                color([1,0,0,0.4])
                    cylinder(h=length, r=0.2);
            } else {
                for(z=[1 : 1 : length-1]) {
                    translate([0,0,z])
                        color([1,0,0,rands(0,0.5,1)[0]])
                            cylinder(h=1, r=0.2);
                }
            }
    }
}

module one_laser(how_many_x, how_many_y, size_x, size_y, length, x_lit, y_lit) {
    translate([x_lit*size_x/(how_many_x+1),y_lit*size_y/(how_many_y+1),0])
        color([1,0,0,0.4])
            cylinder(h=length, r=0.2);
}

module fan() {
    color([0.3,0.3,0.3,1]) {
        difference() {
            // fan body
            cube([1.57,1.57,0.5]);
            // cutout for impeller/motor
            translate([1.57/2,1.57/2,-0.1])
                cylinder(h=0.7, d=1);
        }
        translate([1.57/2,1.57/2,0]) {
            // motor hub
            cylinder(h=0.5,d=0.5);
            rotate([0,0,rands(0,360,1)[0]]){
                // blades (positions are if rotation is disabled)
                // right blade
                translate([0.325,0,0.25])
                    rotate([45,0,0])
                        cube([0.25,0.25,0.1], center=true);
                // left blade
                translate([-0.325,0,0.25])
                    rotate([-45,0,0])
                        cube([0.25,0.25,0.1], center=true);
                // bottom blade
                translate([0,0.325,0.25])
                    rotate([0,45,0])
                        cube([0.25,0.25,0.1], center=true);
                // top blade
                translate([0,-0.325,0.25])
                    rotate([0,-45,0])
                        cube([0.25,0.25,0.1], center=true);
            }
        }
    }
}
