include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

lw=0.45;
lh=0.2;

$fn=100;

screw_int=0.2;

board_holes=[
  [0,0],
  [58,0],
  [58,49],
  [0,49],
];

%zmove(1.6) board();
bottom();

module bottom() {
  mount_height=5;
  mount_id=2.7;
  mount_od=2.7+fixlw(2);
  for (p=board_holes) {
    translate(p) down(mount_height) tube(h=mount_height,od=mount_od,id=mount_id);
  }
}

module board() {
  translate([39,24.5,-0.8]) scale(1000) rotate([90,0,0]) import("Raspberry Pi 4 Model B.stl",convexity=200);
}

function fixlw(x)=ceil(x/lw)*lw;
