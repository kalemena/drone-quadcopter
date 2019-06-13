$fn=100;

echo(version=version());

font1 = "Liberation Sans";
font2 = "Segoe UI Emoji";

module letter(font, letter_size, letter_height, text) {
  linear_extrude(height = letter_height) {
    text(text, size = letter_size, font = font, halign = "center", valign = "center");
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
        cylinder(z_h, (spacer_diam + spacer_width)/2, (spacer_diam + spacer_width)/2, true);
        cylinder(z_h, spacer_diam/2, spacer_diam/2, true);
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
    translate([part3_L+spacer_diam/2+width,-5,0]) {
        translate([-1,0,10]) cube([2, width, z_h-10]);
        translate([part2_L-spacer_diam-3,0,10]) cube([2, width, z_h-10]);
        difference() {
            hull() {
                translate([0,0,10]) cube([part2_L-spacer_diam-width-1,10,z_h-10]);
                translate([30,8,15]) sphere(32/2);
                translate([12,8,8]) cylinder(15,10,10);
                translate([49,8,8]) cylinder(15,10,10);
                translate([12,8,0]) cube([49-12,10,10]);          
            }
            translate([1,-1.5,-1])
            hull() {
                cube([part2_L-spacer_diam-width-3,10,z_h]);
                translate([29,8,15]) sphere(32/2);
                translate([11,8,0]) cylinder(20,10,10);
                translate([48,8,0]) cylinder(20,10,10);                
            }
            translate([part2_L/3+2,12,2]) cube([14, 10, 4]);
            translate([part2_L/3+2,6,z_h-5]) cube([14, 5, 10]);
            translate([12+14,10-10,0]) rotate([-90,0,45]) cylinder(40,11,10);
            translate([14+35-9,10-10,0]) rotate([-90,0,-45]) cylinder(40,11,10);
        }
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
