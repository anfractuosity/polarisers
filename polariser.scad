$fn = 80;
depth = 7.10;
circd = 27.88;
circr = circd / 2;
leng = 90;

difference() {
	cube([leng, 31.78, depth]);
	translate([leng / 2, (31.78 - circr) - ((31.78 - circd)/2), 0])
		cylinder(depth, r = 27.88 / 2);
	_circd = circd + 2;
	translate([(90 / 2) - (_circd / 2), 0, (depth / 2) - (1.5/2)])
		cube([_circd, _circd, 1.5]);
}
