include <stdlib.scad>
include <BOSL2/rounding.scad>

$fn=64;

wall=0.9;
gage=3;

difference() {
  union() {
    hull() {
      cuboid([75,75,1.5],rounding=3,edges="Z",anchor=TOP);
      down(2.5) linear_extrude(1) rect([75-2,75-2],rounding=3-1,center=true);
    }
    cuboid([61,61,16],chamfer=3,edges="Z",anchor=BOTTOM);
    let(step=16/4) for(z=[step:step:16]) up(z) fin();
  }

  cuboid([61-3*wall,61-3*wall,16.01],chamfer=3-wall,edges="Z",anchor=BOTTOM);
}

module fin() {
  difference() {
    cuboid([75-2*gage,75-2*gage,wall/2],chamfer=3,edges="Z",anchor=TOP);

    up(0.01) cuboid([61,61,wall/2+0.02],chamfer=3,edges="Z",anchor=TOP);
  }
}
