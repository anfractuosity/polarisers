include <BOSL2/std.scad>
include <BOSL2/gears.scad>

$fn = 80;
depth = 3.5;
leng = 90 + 25;
width = 31.78;
lip_extra = 1;
gear_thickness = 2;
hole = 27.88 - 3.5;
offset = 25.5;
gear_shift = 23.2;
tol = 0.25;
tol_tight = 0.1;
tol_cyl_tight = 0.12;
pitch = 2.9;
teetha = 30;
teethb = 25;

// Bottom
difference() {
	cube([leng, width, depth]);
	translate([16, 16, 0]) {
		for ( i = [0 : 3] ){
			// Hole for gears to fit into
			translate([offset + (i * gear_shift), 0, 0])
				cylinder(h = depth, d = 3);
		}
		cylinder(h=depth, d=hole);
	}
	// Holes for top cylinders to clip into
	translate([3, width - 3, 0])
		cylinder(h = depth, d = 3);
	translate([3, 3, 0])
		cylinder(h = depth, d = 3);
	translate([leng - 15, 3, 0])
		cylinder(h = depth, d = 3);
	translate([leng - 15, width - 3, 0])
		cylinder(h = depth, d = 3);
}

// Top
translate([0, 0, depth]){
	difference() {
		cube([leng, width, depth]);
		translate([16, 16, 0]) {
			cylinder(h=depth, d=hole - lip_extra);
		}
		translate([16, 16, 0]) {
			color("green") {
				cylinder(h = gear_thickness + tol, d = 30)
				spur_gear(circ_pitch=pitch, mod=2, teeth=teetha, thickness=gear_thickness,
							shaft_diam=hole - lip_extra);
				for ( i = [0 : 3] ){
					translate([offset + (i * gear_shift), 0, 0]){
						spur_gear(circ_pitch=pitch, mod=2, teeth=teethb, thickness=gear_thickness,
									shaft_diam=3);
						cylinder(h = gear_thickness + tol, d = 28);
					}
				}
			}
		}
	}
	// Cylinders to clip into bottom holes
	translate([0, 0, -depth]){
		translate([3, width - 3, 0])
			cylinder(h = depth, d = 3-tol_cyl_tight);
		translate([3, 3, 0])
			cylinder(h = depth, d = 3-tol_cyl_tight);
		translate([leng - 15, 3, 0])
			cylinder(h = depth, d = 3-tol_cyl_tight);
		translate([leng - 15, width - 3, 0])
			cylinder(h = depth, d = 3-tol_cyl_tight);
	}
}

// Clip for polariser
difference() {
	cylinder(h = 1, d = hole - 1 + lip_extra - tol_tight);
	cylinder(h = 1, d = hole - 1 + lip_extra - 2);
}

translate([16, 16, depth + (gear_thickness/2)]) {
	// Gear that contains polariser
	rotate([0, 0, 27])
		color("red") {
			difference() {
				spur_gear(circ_pitch=pitch, mod=2, teeth=teetha, thickness=gear_thickness,
							shaft_diam=hole - 1 - lip_extra);
				cylinder(h = 1, d = hole - 1 + lip_extra);
			}
			translate([0, 0, -((gear_thickness/2) + depth)]) {
				difference() {
					cylinder(h = depth, d=hole-tol);
					cylinder(h = depth, d=hole-1-lip_extra);
				}
			}
		}
	// Gears that rotate polariser
	color("green") {
		for ( i = [0 : 3] ){
			translate([offset + (i * gear_shift), 0, 0]) {
				rotate([0, 0, i * 21.6]) {
					spur_gear(circ_pitch=pitch, mod=2, teeth=teethb, thickness=gear_thickness,
								shaft_diam=3 - tol);
					// Spindle for gears
					translate([0, 0, -((gear_thickness/2)+depth)]){
						cylinder(h = gear_thickness + depth, d = 3 - tol);
					}
				}
			}
		}
	}
}
