include <BOSL/constants.scad>
use <BOSL/transforms.scad>
include <NopSCADlib/core.scad>

lw=0.45;
lh=0.2;

board_width=230;
board_height=33;
board_thickness=1;
ribbon_face=22;
step=13;

// board
xmove(-board_width/2) {
  union() {
    board();
    // mount pins with retaining snap
    h=board_thickness+7*lh;
    for (x=[board_width-ribbon_face:-step:0]) {
      xmove(x) cube([lw,board_height,board_thickness+2*lh]);
      translate([x+ribbon_face/2,33-18]) cylinder(h=h,r=(5/2)/(corrected_radius(2.5)/2.5));
      translate([x+ribbon_face/2,33-18,h]) cylinder(h=lh,r=(5/2)/(corrected_radius(2.5)/2.5)+lw);
      translate([x+ribbon_face/2,33-18,h+lh]) cylinder(h=lh,r=(5/2)/(corrected_radius(2.5)/2.5));
    }
  }

  ymove(board_height+5) difference() {
    board();

    // mount holes
    for (x=[board_width-ribbon_face:-step:0]) {
      translate([x+ribbon_face/2,33-18,-1]) poly_cylinder(h=board_thickness+7*lh+2,r=(5/2)/(corrected_radius(2.5)/2.5));
    }
  }
}

module board() {
  cube([board_width,board_height,board_thickness]);
}
