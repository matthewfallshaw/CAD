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
frame_base_th=up(0.8);
frame_w=15;
frame_board_inset=5;

clearance=up(0.2);
frame_th=up(max(6,board_th+clearance+frame_board_inset/tan(55)+frame_base_th+lh*3));

render(convexity=12) frame(w=222,h=222);


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
  jh=frame_th*0.8;
  jw=3.4/15*frame_w;
  union() {
    difference() {
      ymove(l) rotate([90,0]) linear_extrude(l+frame_th) frame_section();
      chamfer_mask(l=frame_w*2,chamfer=frame_w*2,align=V_FRONT+V_RIGHT);
      translate([-frame_w*2/3,l,frame_th/2-frame_base_th]) joiners_clear(h=jh,w=jw);
    }
    translate([-frame_w*2/3,l,frame_th/2-frame_base_th]) joiners(h=jh,w=jw,odd=odd);
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

module joiners_clear(h,w) {
  x=w/2+lw/2;
  for(i=[h,w]) assert_defined(i);
  for(i=[-x,x]) xmove(i) half_joiner_clear(h=h,w=w);
}

module joiners(h,w,odd) {
  x=w/2+lw/2;
  for(i=[h,w,odd]) assert_defined(i);
  xmove((odd?-1:1)*x) half_joiner( h=h,w=w,l=10);
  xmove((odd?1:-1)*x) half_joiner2(h=h,w=w,l=10);
}


module assert_defined(x,msg) {
  assert(!is_undef(x),msg);
}
function up(x)=quantup(x,lh);
