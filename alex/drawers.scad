include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
// use <BOSL/masks.scad>
// use <BOSL/math.scad>

lw=0.50;  // line width
lh=0.3;   // layer height

w=245;    // width
h=160;    // height
d=205;    // depth

n=5;         // number of drawers
wall=2*lw;   // wall thickness

// Prototype size
// w=50;              // width
// h=(160-4*lw)/5*2;  // height
// d=50;              // depth
// n=2;               // number of drawers

dcw=w-2*wall;         // drawer cavity width
dcd=d-wall;           // drawer cavity depth
dch=(h-wall)/n-wall;  // drawer cavity height

cl=0.3;      // sliding clearance

track_h=7;  // drawer track height (to centre)
track_w=3;   // drawer track width (off wall)
track_pin_dia=5;  // drawer track sliding pin diameter
track_offset=2*wall+cl;  // track offset (inset from front)

dw=dcw-2*cl;  // drawer width
dd=dcd-cl;    // drawer depth
dh=dch-2*cl;  // drawer height

hw=min(dw/2,50);  // drawer handle width
hd=15+wall;       // drawer handle depth
hh=min(dh/2,15);  // drawer handle height


echo(lw=lw, lh=lh, w=w, h=h, d=d, n=n, wall=wall, cl=cl, dcw=dcw, dcd=dcd, dch=dch,
     dw=dw, dd=dd, dh=dh);

// assy();
// print();
zmove(d) xrot(-90) drawers();
// drawer();
// right_track();

module print() {
  zmove(d) xrot(-90) drawers();
  xmove(-5) orient_and_align(size=[dw,dd,dh],align=V_LEFT+V_BACK+V_TOP) drawer();
}

module assy() {
  drawers();
  for(i=[0:n-1]) translate([w/2,d/2,(dch+wall)*i+dh/2+wall]) drawer();
}

module drawers() {
  union() {
    difference() {
      cuboid([w,d,h], align=V_ALLPOS);
      translate([wall,-1,wall])
        for(i=[0:n-1]) {
          zmove((dch+wall)*i) cuboid([dcw,dcd+1,dch], align=V_ALLPOS);
        }
    }
    xmove(w/2) for(i=[0:n-1]) {
      zmove((dch+wall)*i) {
        xmove(dcw/2)  right_track();
        xmove(-dcw/2) left_track();
        xspread(l=dcw/2, n=3) support_rib();
        offset=track_offset+wall*cos(45)+3*track_w+track_w+2;
        translate([0,offset,dch]) zrot(90) {
          cuboid([wall,w,up(wall*3)], align=V_RIGHT);
          xmove(wall) zflip() right_triangle([up(wall*3),w,up(wall*3)], align=V_RIGHT);
        }
      }
    }
  }
}

module right_track() {
  slide_dia=track_pin_dia+2*cl;
  track_offset_inner=track_offset+wall*cos(45);
  track_w_clear=track_w+2;

  zmove(track_h) difference() {
    // track
    ymove(track_offset)
      cuboid([track_w,dd+wall-track_offset,slide_dia+2*wall], align=V_LEFT+V_BACK);
    // slot
    hull() {
      translate([1,dd+wall+1])
        cuboid([track_w_clear,1,slide_dia], align=V_LEFT+V_FRONT);
      translate([1,track_offset_inner])
        yflip() right_triangle([track_w_clear,track_w_clear,slide_dia],
                               align=V_LEFT+V_FRONT, orient=ORIENT_Z);
    }
    // pin entry
    hull() {
      translate([1,track_offset_inner,2*wall])
        yflip() right_triangle([track_w_clear,track_w_clear,slide_dia],
                               align=V_LEFT+V_FRONT, orient=ORIENT_Z);
      translate([1,track_offset_inner+3*track_w,2*wall])
        yflip() right_triangle([track_w_clear,track_w_clear,slide_dia],
                               align=V_LEFT+V_FRONT, orient=ORIENT_Z);
    }
  }
}

module left_track() {
  xflip() right_track();
}

module support_rib() {
  offset=track_offset+wall*cos(45)+3*track_w+track_w+2;

  translate([0,offset,dch]) cuboid([wall,dd-offset+wall,up(wall*3)], align=V_BACK);
}

module drawer() {
  dbw=dw-2*(track_w+cl);    // drawer body width
  dbh=dh-track_h-cl;  // drawer body height

  union() {
    difference() {
      union() {
        // body shell
        zmove(-dh/2) cuboid([dbw,dd,dbh],align=V_TOP);
        // face plate
        ymove(-(dd-wall)/2) cuboid([dw,wall,dh]);
        //   face plate supports
        translate([-wall/2,-dd/2+wall,dh/2-(dh-dbh)])
          xspread(spacing=dbw-wall, n=2) right_triangle([wall,max(dh-dbh,dd/3),dh-dbh],
                                                        orient=ORIENT_X);
        // track pin
        translate([0,(dd-10)/2,-dh/2+track_h-wall])
          cyl(h=dw, d=track_pin_dia, circum=false, realign=true, orient=ORIENT_X);
      }
      // cavity
      zmove(-dh/2+wall) cuboid([dbw-2*wall,dd-2*wall,dh], align=V_TOP);
    }

    // Handle
    ymove(-dd/2) difference() {
      cuboid([hw,hd,hh], chamfer=2, edges=EDGES_Y_BOT+EDGES_Z_FR+EDGE_BOT_FR, align=V_FRONT);
      translate([0,0,wall]) cuboid([hw-2*wall,hd-wall,hh],
                                   chamfer=2-wall*cos(45),
                                   edges=EDGES_Y_BOT+EDGES_Z_FR+EDGE_BOT_FR, align=V_FRONT);
    }
  }
}

function up(x)=ceil(x/lw)*lw;
