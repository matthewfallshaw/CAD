include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
use <BOSL/masks.scad>
use <polyholes.scad>

x=150;
y=135;
wall=2;
head=10;
screw=6;
sx=49;
sy=116;
screws=[
  [-sx/2,-sy/2],
  [ sx/2,-sy/2],
  [ sx/2, sy/2],
  [-sx/2, sy/2],
];

sup=y-sy;

yrot(90)
// ydistribute(spacing=y+2) {
  // cage(cut=false);
  cage(cut=true);
// }

module cage(cut=false) {
  difference() {
    union() {
      yspread(spacing=sy) cuboid([x,sup,wall],align=V_BOTTOM);
      translate([-x/2,  y/2-sup, -wall]) zflip() right_triangle([x,2,2], orient=ORIENT_X);
      translate([-x/2,-(y/2-sup),-wall]) zflip() yflip()
        right_triangle([x,2,2], orient=ORIENT_X);
      difference() {
        cuboid([x,sy-(y-sy),20],align=V_BOTTOM);
        zmove(wall)
          cuboid([2*x,sy-(y-sy)-2*wall,20],chamfer=2,edges=EDGES_X_ALL,align=V_BOTTOM);
      }
    }
    for(p=screws) {
      translate(p) {
        polycyl(l=100,d=screw+0.5);
        xmove(head+screw) polycyl(l=100,d=head+1);
        cuboid([head+screw,screw+0.3,100],align=V_RIGHT);
        if(cut) {
          zmove(-wall/2) {
            cuboid([head+screw,head+0.3+2,100],chamfer=2,align=V_RIGHT+V_BOTTOM);
            polycyl(l=wall,d2=head+0.3,d1=head+0.3+2*wall,align=V_BOTTOM);
          }
        }
      }
    }
  }
}
