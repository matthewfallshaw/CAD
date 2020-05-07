include <stdlib.scad>

$fn=64;

lw=0.45;
lh=0.3;

w=100;
d=50;
h=100;

difference() {
  cuboid([w,d,h],anchor=BOTTOM);

  up(lh) cuboid([w-2*lw,d-2*lw,h],anchor=BOTTOM);
  down(0.01) cuboid([w-15*lw,d-15*lw,2*h],anchor=BOTTOM);
}
