use <MCAD/2Dshapes.scad>
use <MCAD/regular_shapes.scad>
use <MCAD/array.scad>

int_dia=70;
wall=2;
height=5;
feet=5;
feet_dia=5;
holes=5;

$fn=100;

union() {
  // base plate
  difference() {
    cylinder(max(wall, 3),d=int_dia+wall);
    Radial_Array(360/holes,holes,int_dia/2/3*2) {
      translate([0,0,-1]) cylinder(wall*2+1,d=5);
    }
    rotate([0,0,360/holes/2]) Radial_Array(360/holes,holes,int_dia/2/3) {
      translate([0,0,-1]) cylinder(wall*2+1,d=5);
    }
  }
  // outer wall
  cylinder_tube(height,(int_dia+wall)/2,wall);
}
