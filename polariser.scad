$fn = 80;
depth = 7.10;
circd = 27.88;
circr = circd / 2;
leng = 90;
tol_tight = 0.1;

// Holder for polariser
difference() {
	cube([leng, 31.78, depth]);
	translate([leng / 2, (31.78 - circr) - ((31.78 - circd)/2), 0]) {
		union() {
			cylinder(depth, d = circd);
			cylinder(1, d = circd + 2);
		}
	}
}

// Clip for polariser
difference() {
	cylinder(1, d = circd + 2 - tol_tight);
	cylinder(depth, d = circd);
}