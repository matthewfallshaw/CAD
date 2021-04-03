include <stdlib.scad>

$fn=64;

BIGNUM=200;
cl=0.35;

plates=[152,20,9.5];
gaps=[0,4,2.5];
th=2.5;
magnet_d=15;
magnet_th=2;

cl3=repeat3(cl);

// MODE="pad_plus_left";
MODE="pad_plus_right";
// MODE="pad";

if(MODE=="pad") pad();
else if(MODE=="pad_plus_left")  pad_plus(side="left");
else if(MODE=="pad_plus_right") pad_plus(side="right");

module pad() {
  union() {
    difference() {
      cuboid(plates+repeat3(2*th)+2*cl3,anchor=ALLNEG);

      // void
      translate(repeat3(th)) cuboid(plates+2*cl3,anchor=ALLNEG);
      // rear
      translate(repeat3(th)+gaps) cuboid(repeat3(1000),anchor=ALLNEG);
      translate(repeat3(th)+[gaps.x,gaps.y,plates.z-3]) xrot(45) cuboid([plates.x+2*cl,4,4],anchor=ALLNEG);
      // strategy 1: vertical print bridge
      // translate([th+cl+plates.x+cl-0.01,th+gaps.y,th]) cuboid([0.2+0.01,plates.y+2*cl-gaps.y,gaps.z+cl],anchor=ALLNEG);
    }
    // strategy 2: horizontal bridge supports
    translate([plates.x/2+th,th,0]) xcopies(n=8,l=plates.x*8/10) up(th+cl+plates.z+cl+0.01) yrot(90) right_triangle([2,2,0.45*2]);
  }
}

module pad_plus(side) {
  assert(side);

  bump=2*th+2*cl;
  s=[plates.x+bump,plates.y+bump,5];

  if(side=="left") shape();
  else if(side=="right") yflip() shape();

  module shape() {
    difference() {
      union() {
        pad();
        cuboid(s,anchor=TOP+LEFT+FRONT);
        let(s=plates) translate([s.x+th+2*cl+c_lh,th+gaps.y,th+gaps.z]) right_triangle([s.z-gaps.z+2*cl+th,s.y-gaps.y+2*cl+th,c_lh],orient=LEFT);
      }

      translate([s.x/2,s.y/2,-s.z]) {
        cyl(d=5,l=BIGNUM,orient=RIGHT);
        cyl(d=5,l=BIGNUM,orient=FRONT);
        xcopies(spacing=50) cyl(d=2,l=BIGNUM,orient=FRONT);
        left(50) cyl(d=10,l=BIGNUM,orient=FRONT);
        right(50) zrot(45) cyl(d=10,l=BIGNUM,orient=FRONT);
        // magnets
        up(s.z+th-c_lh) xcopies(spacing=45,n=3) cyl(d=magnet_d,l=magnet_th,anchor=TOP);
      }
    }
  }
}

function repeat3(a)=repeat(a,3);
