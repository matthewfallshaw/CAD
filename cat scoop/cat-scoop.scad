include <stdlib.scad>

hole_dia=6.5;

$fn=128;

// xdistribute(spacing=75) {
  // scoop(slots=true);
  scoop(slots=false);
// }

module scoop(slots=true) {
  difference() {
    scale([1,1,15/12]) xrot(90) translate([0,-75,-7]) rotate(-90,[1,0,0]) import("cat-scoop-newhole-fixed.stl");
    xrot(90) if(slots) {
      for (a=[0:30:360])
        rotate(a+15) translate([20,0]) cylinder(h=50,d=hole_dia,center=true);
      for (a=[0:60:360])
        rotate(a) translate([10,0]) cylinder(h=50,d=hole_dia,center=true);
      cylinder(h=50,d=hole_dia,center=true);
    }
  }
}
