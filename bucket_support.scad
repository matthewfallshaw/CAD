include <BOSL/constants.scad>
use <BOSL/shapes.scad>

wall=3;
w=80;
h=w;
d=60;

union() {
  prismoid(size1=[d,10], size2=[d,wall], shift=[0,-(10-wall)/2], h=h);
  translate([-d/2,0,0]) {
    cube([d,w,wall]);
    /* cube([d,wall,h]); */
  }
  translate([0,wall,wall]) interior_fillet(l=d,r=15);
}
