include <stdlib.scad>
use <archimedean_spiral.scad>
include<chamfer_calcs.scad>

wall=0.9;
dia=12;
base=[15,30,1.2];
lw=0.45;

$fn=64;

// MODE="clip";
MODE="assy";

xrot(-90)
if(MODE=="clip") clip();
else if(MODE=="hemisphere") hemisphere();
else if(MODE=="lateral") lateral();
else if(MODE=="flat") flat();
else {
  xdistribute(spacing=base.y+5) {
    clip();
    flat();
    lateral();
    hemisphere();
  }
}

module flat() {
  union() {
    down(wall) cuboid(base);
    // clip
    down(wall/2) difference() {
      down(wall) cuboid([base.x,base.y,dia/2],chamfer=wall,edges="Y",anchor=BOTTOM);

      cuboid([base.x-2*wall,base.y+0.01,dia/2-2*wall],chamfer=internal_chamfer(wall,wall),edges="Y",anchor=BOTTOM);
      translate([(base.x-wall)/2,0,dia/16]) cuboid([wall+0.01,base.y+0.01,0.4]);
    }
  }
}

module lateral() {
  union() {
    _base();
    // clip
    zrot(90) translate([base.y/2,0,(dia-2.4*wall)/2]) yrot(-90) zrot(20) difference() {
      linear_extrude(base.y,convexity=12) archimedean_spiral(spirals=4.0,thickness=wall,rmax=dia/2);
      down(0.01) {
        linear_extrude(base.y+2,convexity=12) archimedean_spiral(spirals=2.9,thickness=wall+0.2,rmax=0.7*dia/2);
        cyl(h=base[0]+2,d=5);
      }
    }
  }
}

module clip() {
  union() {
    _base([base.y,base.x,base.z]);
    // _base();
    // clip
    translate([0,base[0]/2,(dia-2.4*wall)/2])
    // yrot(-90)
    xrot(90)
    zrot(20+90) difference() {
      linear_extrude(base[0],convexity=12) archimedean_spiral(spirals=4.0,thickness=wall,rmax=dia/2);
      down(0.01) {
        linear_extrude(base[0]+2,convexity=12) archimedean_spiral(spirals=2.9,thickness=wall+0.2,rmax=0.7*dia/2);
        cyl(h=base[0]+2,d=5);
      }
    }
  }
}

module hemisphere() {
  dia=28;
  rad=dia/2;
  xrot(90) difference() {
    // sphere
    top_half() sphere(d=dia,style="stagger");
    // cable hole
    up(rad-5.5) teardrop(d=8, l=dia, ang=45);
    // chamfer
    r=sqrt(rad*rad-1)+0.1;
    up(-0.001) tube(h=1, or1=rad+10, or2=r, ir1=r-1, ir2=r);
  }
}

module _base(base=base) {
  union() down(wall) {
    cuboid(size=base,chamfer=2,edges="Z");
    // support
    cuboid([base.x,base.y/2,lw],anchor=FRONT);
  }
}
