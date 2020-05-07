include <stdlib.scad>

$fn=128;

h=10;
w=48;
wall=1.2;
d1=22;
d2=28;

union() {
  difference() {
    hull() {
      base(d1=d1+2*wall,d2=d2+2*wall,w=w+2*wall);
      back(d2/2+wall) cuboid([w,wall,h],chamfer=wall/2,edges=BOTTOM,anchor=BOTTOM);
    }
    up(wall) base(d1=d1,d2=d2,w=w);
    up(h) hull() {
      resize([0,0,0.01]) base(d1=d1+wall,d2=d2+wall,w=w+wall);
      down(wall/2) resize([0,0,0.01]) base(d1=d1,d2=d2,w=w);
    }
  }
  up(h) back(d2/2+wall) cuboid([w,wall,h],chamfer=wall/2,edges=edges("Y",except=BOTTOM),anchor=BOTTOM);
  up(h-0.5) back(d2/2+wall) xrot(45) cuboid([w,wall,wall],anchor=BOTTOM);
}

module base(d1,d2,w,neg) {
  hull() {
    xspread(n=2,spacing=w-d1) cyl(h=h,d=d1,chamfer1=wall/2,anchor=BOTTOM);
    scale([w/d2*0.9,1,1]) cyl(h=h,d=d2,chamfer1=wall/2,anchor=BOTTOM);
  }
}
