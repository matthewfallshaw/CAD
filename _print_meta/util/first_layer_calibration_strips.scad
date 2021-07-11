include <stdlib.scad>
include <chamfer_calcs.scad>

$fn=16;

k=1.094;
b=0.042;
lw=0.5;
unit=lw*10/k;
n=15;

w=2*n*unit;
line=lw-b;

echo(unit=unit);

difference() {
  cuboid([w,10,0.2]);

  for(x=[0:n]) right(-w/2+x*2*unit) fwd((x%2==0?lw-b:-lw+b)) cuboid([unit,10,0.4]);
}
