include <stdlib.scad>

// $fn=0;
// $fa=12;
// $fs=2;

// $fn=16;
// $fn=32;
$fn=64;

// BIGNUM=100;


MODE = "help"; // [ part, assy, help ]
MODES = [ "part", "assy", str("help") ];
if(MODE=="assy") assy();
else if(MODE=="part") part();
else echo(MODES=MODES);

SUPPORTS = false;

stop_depth=26.6;
d = 34.5;
l = 37.5;
w = 17.9;

nudge = 5.2;
edge = 26.5;
clip_h = 5.5;
clip_w = 6;
clip_th = 1;

back_s = [8.9,2*4.5,2*(8-1)];


module part() {
  diff("mask", "pos", "keep") {
    back(nudge) {
      // base
      tags("pos") down(d/2-8) intersection() {
        cyl(d=d, l=l, rounding=0.5, orient=BACK, anchor=TOP);
        up(d/2-8) cuboid([w,l,8], rounding=0.5, anchor=BOTTOM+BACK);
      }

      // base back chamfer
      chamfer_edge_mask(l=BIGNUM, chamfer=3, orient=LEFT, $tags="mask");

      // back side fillets
      cuboid([w,l,8], rounding=0.5, anchor=BOTTOM+BACK)
        edge_mask([BACK+LEFT, BACK+RIGHT]) rounding_edge_mask(l=BIGNUM, d=7.5);

      // front retainer (fixed) clip
      tags("pos") fwd(l) {
        cuboid([7.8,2*1.5,1.5], rounding=0.5, edges=BOTTOM+FRONT, anchor=BOTTOM)
          attach(TOP,BOTTOM) cuboid([7.8,2*1,1], rounding=0.5, edges=TOP+FRONT);
      }

      // back retainer clip
      //   cutout
      tags("mask") intersection() {
        cuboid(back_s, chamfer=1.5, edges="Y");
        down(d/2-8) cyl(d=d-2*1.5, l=BIGNUM, realign=true, orient=FRONT, $fn=32);
      }
      //   clip
      translate([0,1.5,clip_h]) cuboid([clip_w,3.5+1.5,clip_th], chamfer=0.5, edges=BOTTOM+BACK, anchor=TOP+BACK, $tags="keep")
        position(FRONT+TOP) back(2) skew(syz=0.5) cuboid([6,2,clip_h], anchor=TOP+BACK);

      // spring retainer avoider
      translate([0,-9.5,-c_eps]) cyl(d=7, l=2+2*$slop, chamfer2=7/4, anchor=BOTTOM, $tags="mask");
    }

    // dyson v<=6 clip slot
    translate([0,-edge,8]) cuboid([BIGNUM,8,2*1.8], chamfer=1.8, edges=BOTTOM+BACK, anchor=FRONT, $tags="mask");

    // supports
    if(SUPPORTS) tags("keep") {
      translate([0,nudge,clip_h-clip_th]) cuboid([clip_w,4,c_lh], anchor=BOTTOM+FRONT);
      intersection() {
        down(d/2-8) difference() {
          cyl(d=d-2*1.5+2*(c_lh+c_eps), l=BIGNUM, realign=true, orient=FRONT, $fn=32);

          cyl(d=d-2*1.5, l=BIGNUM, realign=true, orient=FRONT, $fn=32);
        }
        back(nudge+4) cuboid([back_s.x,nudge+4,BIGNUM], anchor=BOTTOM+BACK);
      }
      intersection() {
        back(nudge+4) cuboid([back_s.x,4*c_lw,BIGNUM], anchor=BOTTOM+BACK);
        down(d/2-8) cyl(d=d-2*1.5+2*(c_lh+c_eps), l=BIGNUM, realign=true, orient=FRONT, $fn=32);
      }
    }
  }
}

module assy() {
  part();
}

module originals() {
  translate([-6,9,0])
  import("./Dyson+V6+Drill+Dust+Vacuum+(Bohrstaub-Sauger)/files/2020-10-26_DysonBohrSauger.stl");

  *zrot(180)
  translate([100,-50,-50])
  import("./Dyson+V7+-+V11+Drill+Dust+Collector/files/Dyson_V7_V8_V9_V10_V11_Drill_Dust_Collector.stl");

  xrot(-90)
  translate([100,-70,-40])
  import("./Dyson+V7+-+V11+Drill+Dust+Collector/files/Dyson_V7_V8_V9_V10_V11_Drill_Dust_Collector.stl");

  %xrot(-45) cyl(d=d, l=100, anchor=BOTTOM);
}
