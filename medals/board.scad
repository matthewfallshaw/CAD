include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

lw=0.45;
lh=0.2;

$fn=30;

board_width=230;
board_height=33;
board_thickness=1;
ribbon_face=22;
step=13;
clip_height=0.4+0.4+2;

// board
xmove(-board_width/2) {
  union() {
    board();
    // mount pins with retaining snap
    h=up(board_thickness+2);
    for (x=[board_width-ribbon_face:-step:0]) {
      xmove(x) cube([lw,board_height,board_thickness+2*lh]);
      translate([x+ribbon_face/2,33-18]) cylinder(h=h,r=(5/2));
      translate([x+ribbon_face/2,33-18,h]) cylinder(h=lh,r=(5/2)+lw);
      translate([x+ribbon_face/2,33-18,h+lh]) cylinder(h=lh,r=(5/2));
    }
  }

  ymove(board_height+5) difference() {
    board();

    // mount holes
    for (x=[board_width-ribbon_face:-step:0]) {
      translate([x+ribbon_face/2,33-18,-1]) cyl(h=board_thickness+7*lh+2,r=(5/2));
    }
  }
}

module board() {
  cube([board_width,board_height,board_thickness]);
}

function up(x)=ceil(x/lh)*lh;
