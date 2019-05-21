echo(version=version());

font1 = "Liberation Sans";
font2 = "Segoe UI Emoji";

module letter(font, letter_size, letter_height, text) {
  linear_extrude(height = letter_height) {
    text(text, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);
  }
}

width=1;
z_h=34.5;
//z_h=10;
y_l=32;
part1_L=45.5;
part2_L=70;
part3_L=42.5;
spacer_diam=6;
spacer_width=2;

module spacer() {
    difference() {
        cylinder(z_h, (spacer_diam + spacer_width)/2, (spacer_diam + spacer_width)/2, true, $fn=50);
        cylinder(z_h, spacer_diam/2, spacer_diam/2, true, $fn=50);
    }
}

module front() {
    difference() {
        union() {
            translate([+part3_L+part2_L,0,z_h/2]) spacer();
            translate([+part3_L+part2_L+part1_L,0,z_h/2]) spacer();            
            translate([+part3_L+part2_L+spacer_diam/2,0,0]) cube([part1_L-(spacer_diam), width, z_h]);
            
            translate([part1_L+part2_L+part3_L,-y_l/2,0]) cube([width, (y_l-spacer_diam)/2, z_h*2/3]);
            translate([part2_L+part3_L-spacer_diam/2-width,-spacer_diam/2,0]) cube([width, spacer_diam, z_h]);
        }
        translate([part2_L+part3_L+spacer_diam/2, -4,z_h-4]) cube([15, 10, 4]); // strap front
    }
}

module middle() {
    difference() {
        union() {      
            translate([part3_L+spacer_diam/2+width,-4.5,10]) {
                cube([width, 10, z_h-10]);
                translate([-1,0,0]) cube([2, width, z_h-10]);
                translate([-1,8,0]) cube([2, width, z_h-10]);
                translate([-1,9,0])  rotate([0,0,-45]) cube([width, 13, z_h-10]);
            }
            translate([part2_L+part3_L-spacer_diam+1,-4.5,10]) {
                cube([width, 10, z_h-10]);
                cube([2, width, z_h-10]);
                translate([0,8,0]) cube([2, width, z_h-10]);
                translate([1.5,8.3,0]) rotate([0,0,45]) cube([width, 13, z_h-10]);
            }
            translate([part3_L+12.3,12.8,10]) cube([part2_L-24.5, width, z_h-10]);
            translate([part3_L+5,-2,z_h-width]) cube([part2_L-10, 15, width]);
        }
        translate([part3_L+part2_L/3+4.5,12,12]) cube([14, width*2, 4]);
        translate([part3_L+part2_L/3+4.5,3,z_h-width]) cube([14, 4, width*2]);
        translate([part3_L+3.7,5,30]) rotate([0,0,45]) cube([14, 6, 10]);
        translate([part3_L+part2_L-12.65,14,30]) rotate([0,0,-45]) cube([14, 6, 10]);
    }
}

module back() {
    difference() {
        union() {
            translate([0,0,z_h/2]) spacer();
            translate([+part3_L,0,z_h/2]) spacer();
            translate([(spacer_diam)/2,0,0]) cube([part3_L-(spacer_diam), width, z_h]);
            
            translate([-width,-y_l/2,0]) cube([width, (y_l-spacer_diam)/2, z_h]);
            translate([part3_L+spacer_diam/2,-spacer_diam/2,0]) cube([width, spacer_diam, z_h]);
        }
        translate([part3_L-19,-5,z_h-4]) cube([15, 10, 4]); // strap back        
    }
}

module side() {
    front();
    middle();
    back();
}

// FULL set with mirror
difference() {
    union() {
        side(); // left
        translate([0,-y_l,0]) mirror([0,1,0]) side(); // right
    }
    
    // center-back
    translate([0,-y_l/2,7.5]) rotate([0,90,0]) cylinder(z_h,3.5,3.5, true);
    translate([-10/2,-(y_l+10)/2,z_h-5]) cube([10,10,5]);
    
    // center front
    translate([part1_L+part2_L+part3_L,-y_l/2,22]) rotate([0,90,0]) cylinder(z_h,y_l/2-spacer_diam/2,y_l/2-spacer_diam/2,true);    
}
