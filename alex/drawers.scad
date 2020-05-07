include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
// use <BOSL/masks.scad>
// use <BOSL/math.scad>

lw=0.50;  // line width
lh=0.2;   // layer height

w=245;    // width
h=160;    // height
d=194;    // depth

n=5;      // number of drawers
side_wall=2*lw;          // side wall thickness
floor_wall=3*side_wall;  // horizontal wall thickness

// Prototype size
// w=50;              // width
// h=(160-4*lw)/5*2;  // height
// d=50;              // depth
// n=2;               // number of drawers

dcw=w-2*side_wall;                // drawer cavity width
dcd=d-side_wall;                  // drawer cavity depth
dch=(h-floor_wall)/n-floor_wall;  // drawer cavity height

cl=0.3;      // sliding clearance

track_h=10;                    // drawer track height (to centre)
track_w=3;                    // drawer track width (off side_wall)
track_pin_dia=5;              // drawer track sliding pin diameter
track_offset=2*side_wall+cl;  // track offset (inset from front)

dw=dcw-2*cl;  // drawer width
dd=dcd-cl;    // drawer depth
dh=dch-2*cl;  // drawer height

hw=min(dw/2,50);  // drawer handle width
hd=15+side_wall;  // drawer handle depth
hh=min(dh/2,15);  // drawer handle height


echo(lw=lw, lh=lh, w=w, h=h, d=d, n=n, side_wall=side_wall, floor_wall=floor_wall, cl=cl,
     dcw=dcw, dcd=dcd, dch=dch, dw=dw, dd=dd, dh=dh);

*right_half(s=dw*2,x=side_wall+1)
  assy();
zmove(d) xrot(-90) drawer_box();
// drawer(dogbones=true);
// right_track();

module assy() {
  drawer_box();
  for(i=[0:n-1]) translate([w/2,dd/2-side_wall,(dch+floor_wall)*i+dh/2+floor_wall]) drawer();
}

module drawer_box() {
  union() {
    difference() {
      // base
      cuboid([w,d,h], align=V_ALLPOS);
      // drawer cavities
      translate([side_wall,-1,floor_wall]) for(i=[0:n-1]) {
        zmove((dch+floor_wall)*i) cuboid([dcw,dcd+1,dch], align=V_ALLPOS);
      }
    }
    xmove(w/2) for(i=[0:n-1]) zmove((dch+floor_wall)*i) {
      // tracks
      xmove(dcw/2)  right_track();
      xmove(-dcw/2) left_track();
    }
    // floor stiffeners
    for(i=[1:n]) translate([w/2,d/5,(dch+floor_wall)*i])
      cuboid([w,4*d/5,2*floor_wall],align=V_BACK);
  }
}

module right_track() {
  slide_dia=track_pin_dia+2*cl;
  track_offset_inner=track_offset+side_wall*cos(45);
  track_w_clear=track_w+2;

  zmove(track_h) difference() {
    // track body
    ymove(track_offset)
      cuboid([track_w,dcd-track_offset,slide_dia+2*side_wall], align=V_LEFT+V_BACK);
    // track slot
    hull() {
      translate([1,dcd])
        cuboid([track_w_clear,1,slide_dia], align=V_LEFT+V_FRONT);
      translate([1,track_offset_inner])
        yflip() right_triangle([track_w_clear,track_w_clear,slide_dia],
                               align=V_LEFT+V_FRONT, orient=ORIENT_Z);
    }
    // pin entry
    hull() {
      translate([1,track_offset_inner,2*side_wall])
        yflip() right_triangle([track_w_clear,track_w_clear,slide_dia],
                               align=V_LEFT+V_FRONT, orient=ORIENT_Z);
      translate([1,track_offset_inner+3*track_w,2*side_wall])
        yflip() right_triangle([track_w_clear,track_w_clear,slide_dia],
                               align=V_LEFT+V_FRONT, orient=ORIENT_Z);
    }
  }
}

module left_track() {
  xflip() right_track();
}

module drawer(dogbones=false) {
  dbw=dw-2*(track_w+cl);    // drawer body width
  dbh=dh-track_h-cl;        // drawer body height

  union() {
    difference() {
      union() {
        // body shell
        zmove(-dh/2) cuboid([dbw,dd,dbh],align=V_TOP);
        // face plate
        ymove(-(dd-side_wall)/2) cuboid([dw+2*side_wall,side_wall,dh+floor_wall]);
        //   face plate supports
        translate([-side_wall/2,-dd/2+side_wall,dh/2-(dh-dbh)])
          xspread(spacing=dbw-side_wall, n=2)
            right_triangle([side_wall,max(dh-dbh,dd/3),dh-dbh], orient=ORIENT_X);
        // track pin
        translate([0,(dd-10)/2,-dh/2+track_h-floor_wall])
          cyl(h=dw, d=track_pin_dia, circum=false, realign=true, orient=ORIENT_X);
      }
      // cavity
      zmove(-dh/2+floor_wall) cuboid([dbw-2*side_wall,dd-2*side_wall,dh], align=V_TOP);
    }

    // Handle
    ymove(-dd/2) difference() {
      cuboid([hw,hd,hh], chamfer=2, edges=EDGES_Y_BOT+EDGES_Z_FR+EDGE_BOT_FR, align=V_FRONT);
      translate([0,0,floor_wall]) cuboid([hw-2*side_wall,hd-side_wall,hh],
                                   chamfer=2-side_wall*cos(45),
                                   edges=EDGES_Y_BOT+EDGES_Z_FR+EDGE_BOT_FR, align=V_FRONT);
    }
    if(dogbones) translate([0,-dd/2+side_wall/2,-dh/2]) {
      xspread(spacing=dw-5) cyl(h=lh,d=10,align=V_TOP);
    }
  }
}

function up(x)=ceil(x/lw)*lw;
