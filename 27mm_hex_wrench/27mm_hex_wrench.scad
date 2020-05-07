include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

$fn=180;

union() {
  right(7.7) left_half() left(7.7) difference() {
    cyl(h=30,d=60,chamfer=3);
    cyl(h=31,d=27,circum=true,$fn=6);
  }
  left(20) cuboid([120,27,30],chamfer=3,align=V_LEFT);
}
