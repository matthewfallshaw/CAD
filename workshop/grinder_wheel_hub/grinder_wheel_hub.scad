include <stdlib.scad>

// $fn=0;
$fa=12;
$fs=2;
$fn=64;

// MODE="hub";
// MODE="ring";
// MODE="shaft";
MODE="build";

BIGNUM=100;

od=25.45;
l=14;
id=13+$slop;
in_wall=1.5;
bolt_d=3;
worm_d=3;

bolt_d_cl=bolt_d+0.5;
worm_d_cl=worm_d+0.5;

*xrot(180) translate([0,0,15]) rotate([46,8,0]) translate([11,-21,220])
  import("./scan.amf");

if(MODE=="hub") hub();
else if(MODE=="ring") xrot(180) ring();
else if(MODE=="shaft") shaft();
else union() {
  hub();
  right(od+10) xrot(180) ring();
  left(od+10) shaft();
}

module shaft() {
  difference() {
    cyl(d=id-$slop,l=2*l);

    for(i=[0:90:360-1]) zrot(i) right(id/2-1-$slop/2) cuboid([BIGNUM,BIGNUM,BIGNUM],anchor=LEFT);
    cyl(d=8+$slop,l=BIGNUM);
  }
}

module hub() {
  difference() {
    full();

    ring_mask(male=true);
    up(2+bolt_d_cl/2) {
      zcopies(spacing=1.5) cyl(d=worm_d_cl,l=BIGNUM,orient=LEFT,anchor=TOP);
      cuboid([BIGNUM,worm_d_cl,1.5],anchor=LEFT);
    }
  }
}

module ring() {
  difference() {
    intersection() {
      full();

      ring_mask(male=false);
    }

    up(2+bolt_d_cl/2) cyl(d=worm_d-0.2,l=BIGNUM,orient=LEFT,anchor=TOP);
  }
}

module full() {
  echo("slop",$slop);
  diff(neg="neg") {
    cyl(d=od,l=l,anchor=TOP) {
      position(TOP)
        cyl(d=od+2*5,l=bolt_d_cl+2*2,anchor=BOTTOM)
          // screws
          position(TOP) down(bolt_d_cl+2*2-3)
            for(i=[45:90:360]) zrot(i) right(od/2+1.0) {
              cyl($tags="neg",d=bolt_d_cl,l=BIGNUM,anchor=TOP);
              // up(0.01)
              up(0.2)
                cyl($tags="neg",d=5.4/cos(30)+$slop,l=BIGNUM,spin=30,$fn=6,anchor=BOTTOM);
            }
      position(BOTTOM)
        cyl(d2=od,d1=od+2*8,l=8,anchor=TOP);
    }
    // shaft
    difference() {
      cyl(d=id,l=BIGNUM,$tags="neg");

      right(id/2-1) cuboid([BIGNUM,BIGNUM,BIGNUM],anchor=LEFT,$tags="neg");
    }
  }
}

module ring_mask(male) {
  assert(!is_undef(male));

  down(4) tube(id=id+2*in_wall+(male?0:$slop),od=BIGNUM,l=BIGNUM,anchor=BOTTOM);
}
