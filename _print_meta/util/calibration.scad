include <stdlib.scad>

lh=0.2;
lw=0.45;

bed=[250,210];

$fn=64;

locs=[for(x=[25,bed.x/2,bed.x-25],y=[25,bed.y/2,bed.y-25]) [x,y] ];

for(p=locs) translate(p) pattern();
for(x=[-1,1],y=[-1,1]) translate([bed.x/2+x*(bed.x/2-15)/2,bed.y/2+y*(bed.y/2-15)/2]) sq([(bed.x/2-15),(bed.y/2-15)]);

module pattern() {
  grid2d(size=[20,20],spacing=5,n=4)
    if(($col%2)+($row%2)==1) sq([5,5]);

  // linear_extrude(lh) {
  //   difference() {
  //     square(s1,center=true);
  //     square(s1-2*lw,center=true);
  //   }
  //   for(x=[-1,0,1],y=[-1,0,1]) translate([x*s2os,y*s2os]) difference() {
  //     square(s2,center=true);
  //     square(s2-2*lw,center=true);
  //   }
  // }
}

module sq(s) {
  linear_extrude(lh) difference() {
    square([s.x+lw,s.y+lw],center=true);
    square([s.x-lw,s.y-lw],center=true);
  }
}
