include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
use <polyholes.scad>

length=20;
width=12;
wall=2;
hole=3.6;

$fn=100;

difference() {
  brace();
  for (r=[0,90])
    rotate(r) translate([3*length/4,0]) rotate([90,0,0]) rot(360/polysides(d=hole)/4) polycyl(h=wall*3,d=hole);
}

module brace() {
  difference() {
    cuboid([length,length,width],align=V_BACK+V_RIGHT);

    translate([length,wall]) rot(-45) cuboid([2*length,2*length,2*width],align=V_BACK+V_LEFT);
    translate([length/2+wall,wall]) cuboid([length,length,width-wall],align=V_BACK+V_RIGHT);
    translate([wall,length/2+wall]) cuboid([length,length,width-wall],align=V_BACK+V_RIGHT);
    translate([length/2+wall,length/2+wall]) cyl(h=width-wall,d=length);
  }
}
