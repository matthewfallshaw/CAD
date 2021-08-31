include <stdlib.scad>
include <BOSL2/threading.scad>
include <BOSL2/fnliterals.scad>

// $fn=0;
// $fa=12;
// $fs=2;

// $fn=16;
// $fn=32;
// $fn=64;
// $fn=128;
$fn=256;

// BIGNUM=100;

dust_dia=100;
spindle_dia=80;
th=5;
h=40;

magnet=[5,5,4];

skirt_skirt = hashmap(items=[
  ["w", 4.5],
  ["h", 15]
]);
// function skirt_skirt(prop)=(prop=="w"?2
//                            :prop=="h"?12
//                            :assert(false, "bad property"));

loc_dust=[-(spindle_dia/2 + th + 10 + th + dust_dia/2),0,0];

tangents=circle_circle_tangents(c1=[0,0],d1=spindle_dia+2*th,c2=point2d(loc_dust),d2=dust_dia);
tangent_line=tangents[1];
normal_line=line_normal(tangent_line);
magnet_line=[for(i=[0:1]) let(d=magnet.x/2+3*0.9, tl=tangent_line, nl=normal_line) [tl[i].x+d*nl.x, tl[i].y+d*nl.y]];


MODE="boot";  // [ boot, skirt, assy ]
// MODE="skirt";
// MODE="assy";

// top_half(z=0.5)
// bottom_half(z=-0.5)
// back_half()
if(MODE=="boot") boot();
else if(MODE=="skirt") skirt();
else {
  union() {
    boot();
    down($slop) color("darkSlateGray") skirt();
  }
}

module boot() {
  difference() {
    union() {
      boot_base();
      spindle_mount();
      move(loc_dust) dust_mount();
      // magnet boss
      left_half(x=loc_dust.x+dust_dia/2)
      yflip_copy() path_spread(magnet_line, n=3) magnet_boss();
    }

    // magnet inserts
    yflip_copy() path_spread(magnet_line, n=3) up(0.2) magnet_hole(FRONT);
  }
}

module boot_prof() {
  hull() {
    oval(d=spindle_dia+2*th);
    move(loc_dust) oval(d=dust_dia);
  }
}

module boot_base() {
  difference() {
    linear_extrude(3*th) boot_prof();

    up(th+3*c_lh) linear_extrude(BIGNUM) offset(-1.4*th) boot_prof();
    up(th) cyl(d=spindle_dia+2*th, l=BIGNUM, anchor=BOTTOM);

    // dust hose
    move(loc_dust) {
      cyl(d=dust_dia-2*th, l=BIGNUM);
    }

    // spindle
    cyl(d=spindle_dia-6*th, l=BIGNUM);
  }
}

module spindle_mount() {
  difference() {
    cyl(d=spindle_dia+2*th, l=h+th, anchor=BOTTOM);

    up(th) cyl(d=spindle_dia, l=BIGNUM, chamfer1=0.5, anchor=BOTTOM);
    zrot_copies(n=3) up(th) {
      for(i=[0:360/9:360/3-c_eps]) zrot(i) up(8/2) cyl(d=8, l=BIGNUM, orient=RIGHT, anchor=BOTTOM);
      cuboid([BIGNUM,2,BIGNUM], anchor=BOTTOM+LEFT);
    }
    up(h) difference() {
      cyl(d=spindle_dia+2*th+c_eps, h=13.5, anchor=TOP);

      cyl(d=spindle_dia+2*th-0.8, h=BIGNUM);
    }
    cyl(d=spindle_dia-6*th, l=BIGNUM);
  }
}

module dust_mount() {
  difference() {
    union() {
      cyl(d=dust_dia, l=h+3*th, anchor=BOTTOM);
      up(3*th) trapezoidal_threaded_rod( d=dust_dia+5, l=h, pitch=15
                                       , thread_angle=35, left_handed=true, anchor=BOTTOM
                                       , higbee=20
                                       );
    }

    cyl(d=dust_dia-2*th, l=BIGNUM);
  }
}

module skirt() {
  xrot(180)
  difference() {
    union() {
      difference() {
        down(1+$slop) linear_extrude(skirt_skirt("h")+th+1+$slop) offset(1+$slop) boot_prof();

        // clear locating skirt
        down(1+$slop+c_eps) linear_extrude(1+$slop) offset($slop) boot_prof();
        // central clearance hole
        down(BIGNUM/2) linear_extrude(BIGNUM) offset(1+$slop-skirt_skirt("w")-th) boot_prof();
      }
      // magnet boss
      down(c_eps) yflip_copy() path_spread(magnet_line, n=3) magnet_boss();
    }

    // magnet inserts
    yflip_copy() path_spread(magnet_line, n=3) up(0.2) magnet_hole(BACK);
    // brush clutch
    difference() {
      up(th) linear_extrude(skirt_skirt("h")+c_eps) offset(1+$slop-th/2) boot_prof();

      up(th) linear_extrude(BIGNUM) offset(1+$slop-th/2-skirt_skirt("w")) boot_prof();
    }
  }
}

module magnet_boss() {
  d=(magnet.x+$slop+4*c_lw)/cos(45);

  top_half() cyl(d=d, l=2*d, chamfer=d/2);
}

module magnet_hole(hole_orientation=DOWN) {
  union() {
    cuboid(magnet+r3($slop), anchor=BOTTOM);
    up(magnet.z/2) cyl(d=0.1, l=magnet.z*2, orient=hole_orientation, anchor=BOTTOM);
  }
}
