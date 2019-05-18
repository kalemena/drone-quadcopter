$fn=150;

height=17;
bottomWidth=1;

difference() {
    hull() {
        cylinder(height,32/2,32/2,false);
        translate([20,0,0]) {
            translate([0,0,0]) cylinder(height/2,20/2,20/2,false);
        }
        translate([-20,-10,0]) cube([20,20,height/1.5]);
    }
    translate([0,0,bottomWidth]) 
    hull() {
        cylinder(height,30/2,30/2,false);
        translate([-20,-9,0]) cube([18,18,height/1.5]);
    }
    hull() {
        translate([0,0,bottomWidth]) cylinder(4.2,30/2,30/2,false);
        translate([20,0,bottomWidth]) cylinder(4.2,17/2,17/2,false);
    }
    translate([-40,-10,bottomWidth]) cube([40,20,height]);
    translate([0,0,-0.5]) cylinder(5,9/2,9/2,false);
    translate([12,0,-0.5]) cylinder(5,8/2,8/2,false);
    for(rot=[1:4]) {
          rotate([0,0,360 - 45 - rot * 360/4])
          hull() {
            translate([6.5,0,-0.5]) cylinder(h=3, r=3/2);
            translate([11,0,-0.5]) cylinder(h=3, r=3/2);
          }
    }
}