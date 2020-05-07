include <NopSCADlib/lib.scad>
//include <../vitamins/screws.scad>
use <NopSCADlib/printed/flat_hinge.scad>

width = 235; // [20 : 100]
depth = 50; // [8  : 50]
thickness = 1.2; //[1 : 10]
pin_diameter = 4+0.4; // [1:  10]
knuckle_diameter = 7; //[4 : 15]
knuckles = 7; // [3 : 10]
// screw
screws = 2; // [1  : 20]
clearance = 0.2;
margin = 0; // [0 : 10]

angle = 0; // [-90 : 180]

hinge=["monitor",width,depth,thickness,pin_diameter,knuckle_diameter,
       knuckles,M3_dome_screw,screws,clearance,margin];

// build_plate();
// hinge_assembly(hinge,angle=-30);
male_hinge();
pin();

module build_plate() {
  male_hinge();

  translate([0,60]) female_hinge();

  // pin
  pin();
}

module pin() {
  translate([0,-10,pin_diameter/2-(pin_diameter/2-2*cos(360/16))]) rotate([0,90]) rotate(360/8/2)
    cylinder(h=width,d=pin_diameter,center=true,$fn=8);
}

module male_hinge() {
  difference() {
    union() {
      hinge_male(hinge);
      hinge_screw_positions(hinge) cylinder(h=thickness,d=4);
    }
    translate([-width/2+28,depth/2+5+1]) cube([60,depth-10+2,10],center=true);
  }
}

module female_hinge() {
  hinge_female(hinge);
  hinge_screw_positions(hinge) cylinder(h=thickness,d=4);
}
