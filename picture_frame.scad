include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
use <BOSL/masks.scad>
use <BOSL/joiners.scad>
use <BOSL/math.scad>

lh=0.2;
lw=0.45;
print_bed=[250,210,210];

board_th=up(25.4/8);
frame_th=up(15);
frame_base_th=up(0.8);
frame_w=15;
frame_board_inset=5;

clearance=up(0.2);

// render(convexity=12) frame(w=500/4,h=500/4);


module frame(w,h) {
  // ps=[
  //   [-w/2,-h/2,   0],
  //   [-w/2, h/2, -90],
  //   [ w/2, h/2,-180],
  //   [ w/2,-h/2,-270],
  // ];
  ps=[
    [-w/2,-h/2,   0],
    [-w/2, h/2, -90],
    [ w/2, h/2,-180],
    [ w/2,-h/2,-270],
  ]+[
    [-2,-2,   0],
    [-2, 2,   0],
    [ 2, 2,   0],
    [ 2,-2,   0],
  ];
  for (p=ps) {
    translate([p.x,p.y]) rotate(p[2]) corner(w/2,h/2);
  }
}

module corner(w,h) {
  corner_piece(h);
  yflip() zrot(-90) corner_piece(w,odd=true);
}
module corner_piece(l,odd=false) {
  jh=frame_th;
  jw=3.6;
  js=jw+2*lw;
  union() {
    difference() {
      ymove(l) rotate([90,0]) linear_extrude(l+frame_th) frame_section();
      chamfer_mask(l=frame_w*2,chamfer=frame_w*2,align=V_FRONT+V_RIGHT);
      translate([-frame_w*2/3,l,jh/2-frame_base_th]) joiner_pair_clear(h=jh,w=jw,n=2,spacing=js);
    }
    translate([-frame_w*2/3,l,jh/2-frame_base_th]) joiner_pair(h=jh,w=jw,l=10,n=2,spacing=js,alternate=odd?"alt":true);
  }
}

module frame_section() {
  polygon([
    [                 0,0],
    [-frame_board_inset+1,0],
    [-frame_board_inset,1],
    [-frame_board_inset,board_th+clearance],
    [                 0,board_th+clearance+frame_board_inset/tan(55)],
    [                 0,frame_th-frame_base_th],
    [          -frame_w,frame_th-frame_base_th],
    [          -frame_w,-frame_base_th],
    [                 0,-frame_base_th]
  ]);
}

function up(x)=quantup(x,lh);

render(convexity=12) difference() {
  corner(w=500/4,h=500/4);
  cuboid(size=200);
}
