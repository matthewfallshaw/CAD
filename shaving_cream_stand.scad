use <MCAD/2Dshapes.scad>
use <MCAD/regular_shapes.scad>
use <MCAD/array.scad>

diameter=70;
wall=2;
height=5;
feet=5;
feet_dia=5;
holes=5;

$fn=100;

difference() {
  cylinder(max(wall, 3),d=diameter);
  Radial_Array(360/holes,holes,diameter/2/3*2) {
    translate([0,0,-1]) cylinder(wall*2+1,d=5);
  }
  rotate([0,0,360/holes/2]) Radial_Array(360/holes,holes,diameter/2/3) {
    translate([0,0,-1]) cylinder(wall*2+1,d=5);
  }
}
cylinder_tube(height,diameter/2,wall);
Radial_Array(360/feet,feet,diameter/2-feet_dia/2-2) {
  difference() {
    sphere(d=feet_dia);
    cylinder(5/2, d=feet_dia);
  }
}
