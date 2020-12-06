include <stdlib.scad>

// $fn=64;
$fn=180;

d1=64.5;
d2=5.75;
id=59;
wall=0.9;
h=15;
cl=0.3;

// color("green",alpha=0.6) scan();
// #guides();
// left_half() guard();
zflip() guard();

module guard() {
  difference() {
    cyl(d=d1+d2+2*wall,h=h,chamfer2=d2/2,chamfang=45/2,anchor=BOTTOM);

    torus(d=d1,d2=d2);
    down(0.01) cyl(d=id+cl,h=h+0.02,chamfer2=-0.5,anchor=BOTTOM);
    up(2) cyl(d=d1,h=h,anchor=TOP);
  }
}

module cage(wall=0) {
  top_half() torus(d=d1,d2=d2+2*wall);
}

module guides() {
  down(19.5-d/2) tube(od=40,id=20,h=0.5);
  down(10.0-d/2) tube(od=60,id=50,h=0.5);
}

module scan() {
  up(d/2) rotate([0,0.3,0]) translate([0.5,-0.8,-3.3]) import("scan.stl");
}

