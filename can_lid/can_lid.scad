include <stdlib.scad>

$fn=200;

wall=1.2;        // wall thickness
// dia=66;        // diameter including rim
dia=86;          // diameter including rim
rimh=3;          // rim height
rimd=0.65;       //rim depth
lugs=13;          // # of retaining lugs

r=dia/2+wall+rimd;  // overall lid radius
h=rimh+wall*2;      // overall lid height

union () {
  difference() {
    union() {
      cyl(h=h,r=r,anchor=BOTTOM);
      right(dia/2) cyl(h=wall,d=10,anchor=BOTTOM);
    }
    up(wall) cyl(h=h,r=r-wall,anchor=BOTTOM);
    // up(0.6) yrot(180) linear_extrude(0.7) {
    //   translate([0,1])  text("Charlie is",halign="center",valign="bottom",size=8);
    //   translate([0,-1]) text("a poo",halign="center",valign="top",size=8);
    // }
    down(0.6) scale([2.3,1.8]) translate([-14,14]) import("noun_Dog_334812.stl");
    // down(0.1) linear_extrude(0.5) translate([-20,-25]) import("noun_Cat_691143.svg");
  }
  intersection() {
    cyl(h=h,r=r,anchor=BOTTOM);

    union() for(i=[0:360/lugs:360-360/lugs]) zrot(i)
      translate([r-wall,0,h-2*rimd/3]) scale([1,1,0.8]) yrot(45) cuboid([2*rimd,PI*dia/lugs/2,2*rimd]);
  }
}
