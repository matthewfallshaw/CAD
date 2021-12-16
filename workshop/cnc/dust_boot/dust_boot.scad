include <stdlib.scad>
include <BOSL2/threading.scad>
include <BOSL2/fnliterals.scad>

// $fn=0;
$fa=360/16;
$fs=2;

// $fn=16;
// $fn=32;
$fn=64;
// $fn=128;
// $fn=256;

// BIGNUM=100;

dust_dia=100;
spindle_dia=80;
th=5;
h=40;
v1bump = 10-6.5;
dust_closer_h=13.5;

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


MODE="boot";  // [ boot, bootv2, skirt, dust_mount, dust_mountv2, spindle_mount, spindle, assy, _assyv2 ]
// MODE="skirt";
// MODE="assy";

// top_half(z=0.5)
// bottom_half(z=-0.5)
// back_half()
if(MODE=="boot") boot();
else if(MODE=="bootv2") bootv2();
else if(MODE=="skirt") skirt();
else if(MODE=="dust_mount") dust_mount();
else if(MODE=="dust_mountv2") dust_mountv2();
else if(MODE=="spindle_mount") spindle_mount();
else if(MODE=="spindle") spindle();
else if(MODE=="_assyv2") assyv2();
else assy();

module assy() {
  union() {
    boot();
    down($slop) color("darkSlateGray") skirt();
    // spindle();
    // scan();
  }
}

module assyv2() {
  union() {
    bootv2();
    spindle();
    // scan();
  }
}

module boot() {
  difference() {
    union() {
      difference() {
        union() {
          boot_base();
          spindle_mount();
          move(loc_dust) dust_mount();
        }

        // dust_mount_flow_path(wall=th) ;
      }
      // magnet boss
      left_half(x=loc_dust.x+dust_dia/2)
      yflip_copy() path_spread(magnet_line, n=3) magnet_boss();
    }

    // magnet inserts
    yflip_copy() path_spread(magnet_line, n=3) up(0.2) magnet_hole(FRONT);

    spindle();
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
    up(th) cyl(d=spindle_dia+2*th, l=h+th, anchor=BOTTOM);
  }
}

module bootv2() {
  render()
  difference() {
    union() {
      spindle_mount(v=1);
      dust_mountv2();
      bootv2_supports();
    }

    // closing ring cut
    up(h+v1bump) difference() {
      cyl(d=spindle_dia+2*th+0.4, h=13.5, anchor=TOP);

      cyl(d=spindle_dia+2*th-0.8, h=BIGNUM);
    }
  }
}

module bootv2_supports() {
  union() {
    difference() {
      cyl(d=spindle_dia+2*th, l=2*c_lh, anchor=TOP);

      cyl(d=spindle_dia-6*th, l=BIGNUM);
      main_tube();
    }
    intersection() {
      main_tube();
      zrot_copies(n=12) cuboid([spindle_dia,4*c_lw,c_lh], anchor=LEFT+TOP);
    }
  }

  module main_tube() {
    difference() {
      cyl(d=spindle_dia+2*th-6*c_lw, l=BIGNUM);

      cyl(d=spindle_dia-6*th+6*c_lw, l=BIGNUM);
    }
  }
}

module spindle_mount(v=0) {
  difference() {
    cyl(d=spindle_dia+2*th, l=h+th+v*v1bump, anchor=BOTTOM);

    up(th) cyl(d=spindle_dia, l=BIGNUM, chamfer1=0.5, anchor=BOTTOM);
    let(n=5) zrot_copies(n=n) up(th+v*v1bump+10) {
      // for(i=[0:360/(2*n):360/n-c_eps]) zrot(i)
      up(8/2) {
        cyl(d=8, l=BIGNUM, orient=RIGHT, anchor=BOTTOM, $fn=6);
        cuboid([BIGNUM,2,BIGNUM], anchor=BOTTOM+LEFT);
      }
    }
    up(h+v*v1bump) difference() {
      cyl(d=spindle_dia+2*th+c_eps, h=dust_closer_h, anchor=TOP);

      cyl(d=spindle_dia+2*th-0.8, h=BIGNUM);
    }
    cyl(d=spindle_dia-6*th, l=BIGNUM);
  }
}

module dust_mount(anchor=BOTTOM, spin=0, orient=UP) {
  l=h+3*th;

  attachable(anchor=anchor, spin=spin, orient=orient, d=dust_dia, l=l, cp=[0,0,l/2]) {
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
    children();
  }
}

module dust_mountv2() {
  // r = -(loc_dust.x-dust_dia/2*cos(45));
  d = 124;
  d_=d;
  r=1.2*d_;
  spindle_pt = [0,0,0];
  scoop_d = spindle_dia+26;
  _th = 3;
  shift=120;

  render()
  top_half(z=-20)
  difference() {
    union() {
      // main hose
      move(x=-shift, z=50) yrot(-45) dust_mount()
        attach(BOTTOM, TOP) tube(od=dust_dia, wall=th, l=shift);
      // bottom ellipse
      difference() {
        intersection() {
          translate([-50,0,-20]) cyl(d=dust_dia/cos(45), l=_th, anchor=BOTTOM);
          move(x=-shift, z=50) yrot(-45) cyl(d=dust_dia, l=BIGNUM);
        }

        translate([-25,0,-20])  scale([1/cos(45),1,1]) cyl(d=dust_dia-3*th, l=3*_th);
      }
      // bottom skirt
      difference() {
        cyl(d=scoop_d, l=40, chamfer2=26/2);

        move(x=-shift, z=50) yrot(-45) cyl(d=dust_dia-2*th, l=BIGNUM);
      }
      // ring seal
      let(_th=3*c_lw)
      intersection() {
        up(h+v1bump+_th) cyl(d=spindle_dia+2*th+0.4+2*_th, h=13.5+2*_th, chamfer1=1.5*_th, anchor=TOP);

        move(x=-shift, z=50) yrot(-45) cyl(d=dust_dia-th, l=BIGNUM);
      }
    }

    down(_th*cos(45)) cyl(d=scoop_d-2*_th, l=40, chamfer2=26/2);
    cyl(d=spindle_dia-6*th, l=BIGNUM);
    up(th) cyl(d=spindle_dia, l=BIGNUM, chamfer1=0.5, anchor=BOTTOM);
  }

  module dust_path(d) {
    dust_pt = [-(d_/2-(spindle_dia/2+15)), 0, -25];
    sec = move(dust_pt, oval(d=d));

    sweep(
      sec
    , [ for(a=[0:5:45]) move(x=-a,z=-20)*yrot(-a, cp=[-r,0,0])*scale(1-a/(45*d/24)) ]
    );
  }
  // yrot(-45, cp=[r,0,r])
  // difference() {
  //   union() {
  //     up(r) trapezoidal_threaded_rod( d=dust_dia+8, l=h, pitch=15
  //                                      , thread_angle=35, left_handed=true, anchor=BOTTOM
  //                                      , higbee=20
  //                                      );
  //     up(r) cyl(d=dust_dia, l=h, anchor=BOTTOM);
  //   }

  //   cyl(d=dust_dia-2*th, l=BIGNUM);
  // }
}

module dust_mount_skirt() {

}

module dust_mount_flow_path(wall, r) {
  $fa=( $fa==0
      ? 360/$fn
      : $fa
      );
  assert(wall!=undef); assert(r!=undef);

  dia = dust_dia-2*th;
  function rounding(d,i) = let(final=8, f=($fa-i)*(d-2*final)/2/$fa+final) min(f,d/2);
  function yside(xside, rnd) = (6362+(4-PI)*rnd*rnd)/xside;
  function area(x, y, r) = let(as=x*y, ars=4*r*r, ar=PI*r*r) as-ars+ar;

  shapes = [
    for(i=[(wall==0?-1:0):$fa+(wall==0?1:0)])
    yrot( -i*180/$fa/4
        , cp=[r,0,0]
        , p=let( factor=min((1-i/$fa)/2+0.5,1), xside=(dia)*factor, rnd=rounding(xside,i)
               , yside=yside(xside, rnd)
               , s=rect( [xside+2*wall, yside+2*wall], rounding=rnd+wall, center=true)
               )
            path3d(s)
    )
  ];

  union() {
    up(r) skin(shapes, slices=0, convexity=10);
    up(r-c_eps) cyl(d=dia+2*wall, l=wall==0?BIGNUM:h, anchor=BOTTOM);
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

module spindle() {
  color("gray", 0.7) union() {
    up(th) cyl(d=spindle_dia, h=150, anchor=BOTTOM) attach(BOTTOM, TOP) cyl(d=35, l=5)
      attach(BOTTOM, TOP) cyl(d=20, l=40);
    move(x=spindle_dia/2+15, z=-20) cuboid([50,100,BIGNUM], anchor=LEFT+BOTTOM);
    move(z=57) let(l=110) cuboid([l-5,l,20], anchor=BOTTOM);
  }
}

module scan() {
  #translate([2,3]) import("scan1.stl");
}
