// Bathroom door hook
include <stdlib.scad>

$fn=64;

od=21.9;
id=17.3;
cl=0.2;

l1=6.5;
l2=11.5;

difference() {
  union() {
    cyl(d=od+2*5,h=l1+2*5,chamfer=1,anchor=BOTTOM);
    scale([2,1,1]) left_half() cyl(d=od+2*5,h=5,chamfer=1,anchor=BOTTOM);
  }

  up(5) cyl(d=od+cl,h=l1+cl,anchor=BOTTOM) {
    attach(TOP,BOTTOM) cyl(d=od-cl,h=5-cl-3) {
      attach(TOP,BOTTOM) cyl(d1=od-cl,d2=od+2,h=3) {
        attach(TOP,BOTTOM) cyl(d=od+2,h=100);
      }
    }
  }
  // snap cut
  right(6) cuboid([od+2*5,0.4,100],rounding=0.2);
}
