include <stdlib.scad>

wall=1.2;
id1=5;
od2=(20+5)/2;
od3=20;
weight_od=31.72;
weight_id=7.4;
weight_th=4.45;
cl=0.15;
height=26;

$fn=180;

// back_half() assy();
// xdistribute(spacing=55) {
//   base();
//   top();
// }
base();
// top();

module assy() {
  base();
  up(height+weight_th+2*wall+cl) zflip() top();
}

module base() {
  union() {
    // base
    tube(h=wall,od=66,id=id1);
    up(wall) {
      // center
      difference() {
        cyl(h=height,d=id1+2*wall,chamfer1=-1,anchor=BOTTOM);

        down(0.01) cyl(h=height+0.02,d=id1,anchor=BOTTOM);
      }
      // outer
      difference() {
        cyl(h=height,d=od3,chamfer1=-1,anchor=BOTTOM);

        down(0.01) cyl(h=height+0.02,d=od3-2*wall,chamfer1=1,anchor=BOTTOM);
      }
    }
  }
}

module top() {
  od=max(od3,weight_od)+2*wall;

  union() {
    // base
    cyl(h=wall,d=od,anchor=BOTTOM) {
      // weight center post
      attach(TOP) cyl(h=weight_th+wall,d=weight_id-cl,anchor=BOTTOM);
      // weight outer skirt
      attach(TOP) tube(h=weight_th+wall,od=od,id=weight_od+cl) {
        // weight roof
        attach(TOP) cyl(h=wall,d=od,anchor=TOP);
        // valve skirt
        attach(TOP) difference() {
          cyl(h=height-2*wall,d=od2,chamfer1=-1,anchor=BOTTOM);
          down(0.01) cyl(h=height-2*wall+0.02,d=od2-2*wall,chamfer1=1,anchor=BOTTOM);
        }
      };
    };
  }
}
