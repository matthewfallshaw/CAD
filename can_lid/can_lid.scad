include <stdlib.scad>

$fn=200;

dia=65.5;               // diameter including rim

wall=1.2;                // wall thickness
rimh=2.9;                // rim height
rimd=0.65;               // rim depth
lugs=5;                  // # of retaining lugs
cl=0.2;                  // clearance

r=dia/2+wall+rimd+cl/2;  // overall lid radius
h=rimh+wall*2;           // overall lid height

// MODE="dog";
MODE="cat";

if(MODE=="dog") echo(MODE);
else if(MODE=="cat") echo(MODE);

union () {
  difference() {
    union() {
      cyl(h=h,r=r,anchor=BOTTOM);
      right(dia/2) cyl(h=wall,d=10,anchor=BOTTOM);
    }
    up(wall) cyl(h=h,r=r-wall,anchor=BOTTOM);
    if(MODE=="dog") down(0.6) scale([2.3,1.8]) translate([-14,14]) import("noun_Dog_334812.stl");
    else if(MODE=="cat") down(0.1) linear_extrude(0.5) translate([-20,-25]) import("noun_Cat_691143.svg");
  }
  intersection() {
    cyl(h=h,r=r,anchor=BOTTOM);

    union() for(i=[0:360/lugs:360-360/lugs]) zrot(i)
      translate([r-wall,0,h-2*rimd/3]) scale([1,1,0.8]) yrot(45) cuboid([2*rimd,PI*dia/lugs/2,2*rimd]);
  }
}
