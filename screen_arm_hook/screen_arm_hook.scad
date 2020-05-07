include <stdlib.scad>

lw=0.4;
lh=0.2;

cl=0.25;
pole_dia=21.75;
pole_fillet=2;
l=25;
wall=quantup(1,lw);

pole_hook();

module pole_hook() {
  intersection() {
    difference() {
      union() {
        cyl(h=l+2*wall,d=(pole_dia+cl+2*wall)/cos(180/8),chamfer2=pole_fillet-cl,realign=true,align=V_UP,$fn=8);
        up(l-3) hook();
        up(l+2*wall) yspread(spacing=7) xrot(45) cuboid([pole_dia+cl+2*wall-4,1,1]);
      }
      difference() {
        down(1)
          cyl(h=l+1,d=(pole_dia+cl)/cos(180/8)
             ,chamfer2=pole_fillet-cl-wall,realign=true,align=V_UP,$fn=8);
        up(l/2) zrot(90) zspread(spacing=l/2) xspread(spacing=pole_dia+cl)
          prismoid(size1=[2,pole_dia], size2=[0,pole_dia], h=quantup(1,lw), orient=ORIENT_ZNEG);
      }
    }
    cyl(h=2*l-3,d=(pole_dia+cl+2*wall)/cos(180/8),chamfer2=pole_fillet-cl,realign=true,align=V_UP,$fn=8);
  }

  *color("green",0.5) cyl(h=2*l,d=pole_dia,fillet2=pole_fillet);
}

module hook() {
  difference() {
    union() {
      cuboid([pole_dia+cl+2*wall,7,l],chamfer=2,edges=EDGES_Z_ALL+EDGES_TOP,align=V_UP);
      difference() {
        translate([0,-(7/2-2)-2,l-2]) xrot(45)
          cuboid([pole_dia+cl+2*wall-4,7,2.5],chamfer=1,edges=EDGES_X_FR,align=V_BOTTOM+V_FRONT);
        translate([0,14.59,l-4]) difference() {
          zrot(45) cuboid([60,60,10]);
          zrot(45) cuboid([40,40,11]);
        }
      }
    }
    translate([0,-3,l-8]) xrot(45) cuboid([pole_dia+cl+2*wall+1,10,4.5],chamfer=1,edges=EDGES_X_ALL);
    // translate([0,-4,l-7]) cuboid([pole_dia+cl+2*wall,7,4.5],chamfer=1,edges=EDGES_X_ALL);
  }
}
