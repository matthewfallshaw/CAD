include <stdlib.scad>

$fn=128;

*union() {
  xspread(spacing=14,n=2) {
    difference() {
      union () {
        cyl(h=4,d=15, anchor=CENTER, orient=RIGHT);
        cuboid([4,15,10],anchor=TOP,chamfer=-1.5,edges=BOTTOM);
      }
      up(2.5) polycyl(h=100,d=3,realign=true,orient=RIGHT);
    }
  }
  down(10) cuboid([50,50,2],rounding=5,edges="Z",anchor=TOP);
}

union() {
  difference() {
    union() {
      translate([-28/2,-16,-9.75]) import("_print_meta/_Ender3/done/_otherpeople/Ender_3_RasPi_Cam_V2_articulated_arm_with_Led_stand/files/camerasupport2top.STL");
      cuboid([10,10,1],anchor=TOP);
    }
    fwd(1) cyl(h=10,d=8);
    translate([0,-12.5/2,-1]) xspread(spacing=21,n=2) yspread(spacing=12.5) cyl(h=10,d=4,anchor=TOP);
  }
  translate([0,-12.5/2,-1]) xspread(spacing=21,n=2) yspread(spacing=12.5) cyl(h=6.66,d=1.9,rounding2=-1.1,anchor=TOP);
}
