include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
// use <BOSL/masks.scad>
// use <BOSL/math.scad>

lw=0.40;  // line width
lh=0.3;   // layer height

w=230;    // width
h=160;    // height
d=209.9;  // depth

n=5;         // number of drawers
wall=4*lw;   // wall thickness

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
track_offset=15;  // track offset (inset from front)

dw=dcw-2*cl;  // drawer width
dd=dcd-cl;    // drawer depth
dh=dch-2*cl;  // drawer height

echo(lw=lw, lh=lh, w=w, h=h, d=d, n=n, wall=wall, cl=cl, dcw=dcw, dcd=dcd, dch=dch,
     dw=dw, dd=dd, dh=dh);

right_half(x=wall+cl,s=2*w) assy();
// print();
// drawers();
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
      }
    }
  }
}

module right_track() {
  slide_dia=track_pin_dia+2*cl;

  zmove(track_h) difference() {
    // track
    hull() {
      ymove(dd)
        cuboid([track_w,1,slide_dia+2*wall], align=V_LEFT+V_BACK);
      ymove(track_offset)
        prismoid(h=slide_dia+2*wall, size1=[track_w,0], size2=[track_w,slide_dia+2*wall],
                 shift=[0,-(slide_dia+2*wall)/2], align=V_LEFT);
    }
    // slot
    hull() {
      translate([1,dd+1])
        cuboid([track_w+2,1,slide_dia], align=V_LEFT+V_FRONT);
      translate([1,track_offset+wall*cos(45)])
        prismoid(h=slide_dia, size1=[track_w+2,0], size2=[track_w+1,slide_dia],
                 shift=[0,-slide_dia/2], align=V_LEFT);
    }
    // pin entry
    translate([1,track_offset+wall*cos(45),wall])
      prismoid(h=slide_dia+2*wall, size1=[track_w+2,0], size2=[track_w+2,slide_dia+2*wall],
               shift=[0,-(slide_dia+2*wall)/2], align=V_LEFT);
    translate([1,track_offset+wall*cos(45)-1])
      cuboid([track_w+2,track_w/cos(45)+track_pin_dia/2+1,slide_dia/2+2*wall], align=V_TOP+V_LEFT+V_BACK);
  }
}

module left_track() {
  xflip() right_track();
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
          xspread(spacing=dbw-wall, n=2) right_triangle([wall,max(dh-dbh,dd/3),dh-dbh], orient=ORIENT_X);
        // track pin
        translate([0,(dd-10)/2,-dh/2+track_h-wall])
          cyl(h=dw, d=track_pin_dia, circum=false, realign=true, orient=ORIENT_X);
      }
      // cavity
      zmove(-dh/2+wall) cuboid([dbw-2*wall,dd-2*wall,dh], align=V_TOP);
    }

    // Handle
    ymove(-dd/2) difference() {
      hull() {
        xspread(spacing=max(dw/8, 20), n=2) union() {
          translate([0,-dh/6, dh/6]) sphere(d=4);
          translate([0, dh/6,-dh/6]) sphere(d=4+2);
        }
      }
      translate([0,wall,0]) cuboid([dw+1,dd+1,dh+2],align=V_BACK);
    }
  }
}

function up(x)=ceil(x/lw)*lw;
