include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
use <BOSL/masks.scad>
use <polyholes.scad>

$fn=128;

emboss=1;
center_clearance=1;
height=14+emboss+center_clearance;
clearance=0.3;
d1=38;
h1=3.5;
d2=23;
h2=height-h1-1;

union() {
  difference() {
    union() {
      // basic shape stack
      cyl(h=h1,d1=d1,d2=d1-1,align=V_TOP);
      up(h1) cyl(h=1,d1=d1-1,d2=d2,align=V_TOP);
      up(h1+1) cyl(h=h2,d1=d2,d2=d2-1,align=V_TOP);

      // texture ring
      up(h1+1-1) for(i=[0:9:360]) zrot(i) right(23/2) yrot(-atan(0.5/(h2)))
        cyl(h=h2-0.5,d=1,align=V_TOP);
    }
    // top center cutaway
    up(height-1) cyl(h=center_clearance+0.01,d1=d2-4,d2=d2-3,align=V_TOP);
    // marker cut
    up(height-1) cuboid([d1/2,3.5,10],align=V_TOP+V_RIGHT);
    // underside mount hole cut
    down(0.01) cyl(h=height-emboss-center_clearance,d=10.5,align=V_TOP);
    cyl(h=4,d=12.5,chamfer=2);  // chamfer
    // screw hole
    up(height-5.5) zrot(-45) right(23/2) yrot(90) polycyl(h=20,d=3+clearance,realign=true);
    up(height-5.5) zrot(-45) right(23/2) yrot(90) cyl(h=3,d=6);  // countersink
  }
  // pointer
  up(height-1) right(20/2) cuboid([4,0.8,1],align=V_TOP+V_LEFT);
}
