include <stdlib.scad>
include <BOSL2/metric_screws.scad>
include <BOSL2/rounding.scad>

$fn=64;

bolt_d=4;
plate_th=3;
plate_s=[30,40,plate_th];
plate_offset=bolt_d/2+5*c_lw;
axel_d=5;
leg_h=20+axel_d/2;
leg_offset=axel_d/2+5*c_lw;
axel_h=leg_h-leg_offset-5*c_lw;
axel_space=plate_s.x-4*plate_th;
cl=0.3;
interference_sphere_d=5;
interference=1.5;
ang=-147;

// MODE="plate";
// MODE="arm";
MODE="assy";
// MODE="assy_up";

// bottom_half()
if(MODE=="plate") plate();
else if(MODE=="arm") arm();
else if(MODE=="assy_up") assy(up=true);
else assy();

module assy(up) {
  back(axel_h) xrot(90) plate();
  xrot(up?ang:0) yrot(-90) down((axel_space-cl)/2) arm();
}

module plate() {
  difference() {
    union() {
      cuboid(plate_s,rounding=plate_offset,edges="Z",anchor=BOTTOM);
      xflip_copy() translate([axel_space/2,0,plate_th-0.01]) union() {
        rotate([90,0,90]) linear_extrude(2*plate_th)
          polygon(round_corners(let(w=plate_s.y-4*leg_offset) [[-w/2,0],[w/2,0],[0,leg_h+leg_offset]],radius=[0,0,leg_offset]));
      }
      // interference snap
      up(axel_h/2) xflip_copy() right(axel_space/2+interference_sphere_d/2-interference) spheroid(d=interference_sphere_d-cl);
    }

    for(i=[-1,1],j=[-1,1]) translate([i*(plate_s.x/2-plate_offset),j*(plate_s.y/2-plate_offset),plate_th+0.01]) metric_bolt(size=bolt_d,l=25,pitch=0,headtype="countersunk",anchor=TOP);
    up(axel_h) cyl(d=axel_d,l=plate_s.x+0.01,orient=RIGHT);
    up(axel_h) teardrop(d=axel_d,cap_h=axel_d/2+cl,l=plate_s.x+0.01,spin=90);
  }
}

module arm() {
  offset=65-25;
  height=70;

  up((axel_space-cl)/2) yrot(90)
  difference() {
    chain_hull() {
      cyl(r=axel_h-plate_th-2*cl,l=axel_space-cl,chamfer=1,orient=RIGHT);
      translate([0,-offset,-(height-10)]) let(s=axel_space-cl) cuboid(s,chamfer=s/3);
      translate([0,-offset,-height]) cyl(d=axel_space-cl,l=cl,circum=true,realign=true,$fn=8,anchor=BOTTOM);
    }

    // pivot
    cyl(d=axel_d,l=plate_s.x,orient=RIGHT);
    // foot screw
    translate([0,-offset,-height-0.01]) zrot(-90) teardrop(d=5-cl,h=11,cap_h=5/2,orient=BACK,anchor=BACK);
    // snap lock
    xrot(-ang-90)
      let(a=30) xflip_copy() {
        for(i=[0,a,a-180]) xrot(-i) up(axel_h/2) right(axel_space/2+interference_sphere_d/2-interference) sphere(d=interference_sphere_d,circum=true,$fn=12);
        xrot(-a) right(axel_space/2+interference_sphere_d/2-interference) yrot(90) rotate_extrude(angle=180) right(axel_h/2)
          zrot(180/12) circle(d=interference_sphere_d/cos(180/12),$fn=12);
      }
  }
}

