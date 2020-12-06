include <stdlib.scad>

$fn=128;

// color("green") down(33.2) yrot(-0.5) xrot(48.85) translate([9.25,44.25,290.5]) import("sink_plug_hole_scan.stl");

top_rad=5;
hole_dia=80;
h=30;
cl=0.2;

MODE="base";  // ["base", "seal", "assy"]

if(MODE=="base") base();
else if(MODE=="seal") fin(0.6);
else {
  union() {
    base();
    for(z=[-h/2]) color("green") up(z+0.4/cos(45)+cl) fin(0.6);
  }
}

module base() {
  union() {
    difference() {
      union() {
        down(h) cyl(d=hole_dia-2,h=h,chamfer1=3,chamfer2=-top_rad,anchor=BOTTOM);
        cyl(d=hole_dia+2*top_rad-2,h=3,chamfer2=1,anchor=BOTTOM);
      }

      up(3.01) cyl(d=30,h=20,chamfer1=3,chamfer2=-5,anchor=TOP);
    }

    up(3) cuboid([50,3,21],chamfer=-2,edges=TOP,anchor=TOP);
    for(i=[h/2:2.4:h-2]) down(i) fin();
  }
}

module fin(interference) {
  d=(interference?hole_dia+interference:hole_dia+0.3);

  difference() {
    cyl(d=d,h=top_rad,chamfer1=top_rad);

    up(0.4/cos(45)) cyl(d=d,h=top_rad,chamfer1=top_rad);
    cyl(d=hole_dia-2.01,h=10*top_rad,chamfer1=top_rad);
  }
}
