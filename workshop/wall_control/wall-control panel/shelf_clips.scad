include <stdlib.scad>
include <chamfer_calcs.scad>

$fn=0;
$fa=12;
$fs=2;
// $fn=64;

th=2;
lw=0.45;

// MODE="cup";
// MODE="spring";
MODE="assy";

if(MODE=="cup") cup();
else if(MODE=="spring") spring();
else {
  cup();
  translate([th,0,-14.75]) spring();
}


// ---------------

module wall_control_clip() {
  difference() {
    left_half() hull() {
      translate([-3.25,0,11.25-16.75]) cyl(d=20,h=th,orient=BACK,anchor=BOTTOM);
      translate([-13.25,0,-12-16.75]) cyl(d=3,h=th,orient=BACK,anchor=BOTTOM);
      translate([-3,0,-13.5-16.75]) cyl(d=2,h=th,orient=BACK,anchor=BOTTOM);
      translate([-3,0,-13.5-16.75-2/2]) cuboid([3,th,3],anchor=FRONT+LEFT+BOTTOM);
    }

    // bottom
    let(spread=9) translate([-8,-0.01,-13.5-16.75]) yrot(-20) left(spread/2) xrot(-90)
      linear_extrude(th+0.02) glued_circles(d=8,spread=spread,tangent=55);
    let(spread=8.75) translate([-8,-0.01,-13.5-16.75]) yrot(30) right(spread/2) xrot(-90)
      linear_extrude(th+0.02) glued_circles(d=8,spread=spread,tangent=58);
    translate([0.01,-0.01,-14.5-16.75]) cuboid([2.01,th+0.02,4],anchor=FRONT+RIGHT+BOTTOM);
    // top
    translate([0,-0.01,19.4-16.75]) yrot(25) cuboid([2.1,th+0.02,10.7],anchor=FRONT+RIGHT+TOP);
    translate([0.01,-0.01,15.75-16.75]) cuboid([2.01,th+0.02,10.7],anchor=FRONT+RIGHT+BOTTOM);
    difference() {
      translate([0,-0.01,9.8-16.75]) yrot(25) cuboid([5,th+0.02,6],anchor=FRONT+RIGHT+BOTTOM);
      translate([0,-0.01,15.8-16.75]) yrot(9.5) cuboid([5,th+0.02,6],anchor=FRONT+LEFT+TOP);
    }
  }
}

// ---------------

module spring() {
  translate([0,th+0.2]) cuboid([th,10,4],anchor=BOTTOM+LEFT+FRONT);
  back(th/2) cuboid([th-0.3,th+1,4],anchor=BOTTOM+LEFT);
  skew(sxy=0.3) cuboid([th,10,4],anchor=BOTTOM+LEFT+BACK);
}

// ---------------

module cup() {
  union() {
    wall_control_clip();
    difference() {
      union() {
        cuboid([29,29,60],rounding=3,edges=[RIGHT+FRONT,RIGHT+BACK],anchor=FRONT+LEFT+TOP);
        fixed_spring();
      }

      translate([th,th,0.01]) cuboid([29-2*th,29-2*th,60-th],rounding=internal_chamfer(3,2),edges=[RIGHT+FRONT,RIGHT+BACK],anchor=FRONT+LEFT+TOP);
      hole();
    }
  }

  module hole() {
    translate([th,0,-10.75]) cuboid([th,3*th,4],anchor=LEFT+TOP);
  }

  module fixed_spring(d=30) {
    left_half() translate([d/2-1,20,-15]) difference() {
      cyl(d=d,h=5);

      right(lw) cyl(d=d,h=5.01);
    }
  }
}
