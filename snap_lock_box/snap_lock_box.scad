include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
// use <BOSL/masks.scad>
use <BOSL/math.scad>

lh=0.3;
lw=0.45;

w=145;
d=90;
h=120;
th=lw*2;

lid_h=20;
tab_w=20;
cl=0.4;

// box_assembly();
ydistribute(spacing=d+5) {
  box();
  lid();
}

module box_assembly() {
  box();
  zmove(h) xrot(180) lid();
}

module box() {
  bottom_half(s=w*2,z=h-th-cl-(3+th/2)*cos(45)) union() {
    difference() {
      cuboid([w,d,h-th-cl],chamfer=3,edges=EDGES_ALL,align=V_TOP);
      zmove(th) cuboid([w-2*th,d-2*th,h],chamfer=3,edges=EDGES_Z_ALL+EDGES_BOTTOM,align=V_TOP);
    }
    for(i=array_zip([w/2,d/2,w/2,d/2],[for(i=[0:90:270]) i]))
      zmove(h-15) rotate(i[1]) translate([i[0],0]) yrot(90) prismoid(size1=[2,tab_w-cl], size2=[0,tab_w-cl], h=1.5, align=V_TOP);
  }
}

module lid() {
  difference() {
    cuboid([w+2*th+2*cl,d+2*th+2*cl,20],chamfer=3,edges=EDGES_Z_ALL+EDGES_BOTTOM,align=V_TOP);
    zmove(th) cuboid([w+2*cl,d+2*cl,h],chamfer=3,edges=EDGES_Z_ALL+EDGES_BOTTOM,align=V_TOP);
    for(i=array_zip([w/2,d/2,w/2,d/2],[for(i=[0:90:270]) i])) {
      zmove(15) rotate(i[1]) translate([i[0]+cl,0]) {
        yrot(90) prismoid(size1=[2,tab_w], size2=[0,tab_w], h=1.5, align=V_TOP);
        yspread(n=2,l=tab_w*1.5) cuboid([th*3,lw,11]);
      }
    }
    zmove(20-(3+th)*cos(45)) cuboid([w+2*th+2*cl,d+2*th+2*cl,20],chamfer=3,edges=EDGES_Z_ALL+EDGES_BOTTOM,align=V_TOP);
  }
}
