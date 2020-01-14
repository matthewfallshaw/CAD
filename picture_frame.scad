include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
use <BOSL/masks.scad>
use <BOSL/math.scad>
use <BOSLext/joiners.scad>
// use <BOSL/joiners.scad>

lh=0.2;
lw=0.45;
print_bed=[250,210,210];

board_th=up(25.4/8);
frame_base_th=up(0.8);
frame_w=15;
frame_board_inset=5;

clearance=up(0.2);
overhang=50;
frame_th=up(max(6,board_th+clearance+frame_board_inset/tan(overhang)+frame_base_th+lh*3));

frame=[222,222];
// frame(w=frame.x,h=frame.y);
corner(w=frame.x/2,h=frame.y/2);
// h=frame.x;
// w=frame.y;
*right_half(cp=-w/2-$t*(frame_w+0.1),s=w*2) {
  translate([-w/2,-h/2]) rotate(  0) corner(w/2,h/2);
  translate([-w/2, h/2]) rotate(-90) corner(w/2,h/2);
}
*xdistribute(spacing=frame_w+5) {
  corner_piece(l=20);
  corner_piece(l=20, odd=true);
}




// w=15;
// h=w*2;
// align=V_FRONT;
// orient=ORIENT_Y;
// // ydistribute(spacing=w+20) {
// difference() {
// // intersection() {
//   cuboid([w,20,h]);
//   half_joiner(w=w,h=w*2,l=w,orient=orient,force=true)
//     cuboid([w+2,w+2,h+2],align=align);
//   yflip() half_joiner2(w=w,h=w*2,l=w,orient=orient,force=true)
//     cuboid([w+2,w+2,h+2],align=align);
// }


module frame(w,h) {
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
  jh=frame_th*0.9;
  jw=0.35*frame_w;
  union() {
    difference() {
      ymove(l) rotate([90,0]) linear_extrude(l+frame_w) frame_section();
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
    [                 0,board_th+clearance+frame_board_inset/tan(overhang)],
    [                 0,frame_th-frame_base_th],
    [          -frame_w,frame_th-frame_base_th],
    [          -frame_w,-frame_base_th],
    [                 0,-frame_base_th]
  ]);
}

module joiners_clear(h,w) {
  for(i=[h,w]) assert_defined(i);

  half_joiner_clear(h=h,w=w,force=true);
}

module joiners(h,w,odd) {
  for(i=[h,w,odd]) assert_defined(i);

  if(odd) {
    half_joiner( h=h,w=w,l=15,slop=0.1,force=true);
  } else {
    half_joiner2(h=h,w=w,l=15,force=true);
  }
}


module assert_defined(x,msg) {
  assert(!is_undef(x),msg);
}
function up(x)=quantup(x,lh);
