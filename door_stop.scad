// Door stop for sliding door, black, 35mm high, screw from top to floor
// Needs to be shock resistant - rubber washer for mounting screw + rubber stop face? PETG?

include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
use <BOSLext/joiners.scad>
use <BOSL/metric_screws.scad>

$fn=64;

h=35;
d=2*h;
w=30;
maj_rad=80;
a=20;
screwsize=6;
screw_shaft=10;

*difference() {
  scale([0.75,1,1]) hull() {
    back_half(cp=-25) top_half() sphere(d=d);
    back(-45) back_half() top_half() sphere(d=d);
  }
  up(h) screw(screwsize=6,screwlen=45,
              headsize=get_metric_bolt_head_size(6),
              headlen=get_metric_bolt_head_height(6),countersunk=true);
}

difference() {
  fwd(15) back_half(400) top_half(400)
    translate([0,15,-maj_rad+h]) cyl(h=w,r=maj_rad,chamfer=3,orient=ORIENT_X);
  for(i=[0,w]) ymove(i) {
    up(screw_shaft-0.01) cyl(h=h,d=get_metric_bolt_head_size(screwsize),align=V_TOP);
    up(screw_shaft) screw(screwsize=screwsize,screwlen=45,
                headsize=get_metric_bolt_head_size(screwsize),
                headlen=get_metric_bolt_head_height(screwsize),countersunk=true);
  }
}
