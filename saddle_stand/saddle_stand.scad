include <stdlib.scad>
include <BOSL2/partitions.scad>
include <BOSL2/beziers.scad>
include <BOSL2/rounding.scad>

/* Bill of Materials
"end_part1.1" x 2
"end_part1.2" x 2
"end_part1.3" x 2
"end_part1.4" x 2
"end_part2.1" x 2
"end_part2.2" x 2
"end_part2.3" x 2
"end_part2.4" x 2
"plank0" x 2
"plank1" x 8
"shelf" x 2
"spine" x 1
 */

$fn=0;
// $fa=6;
$fa=floor(360/32);
$fs=2;

// $fn=16;
// $fn=32;
// $fn=64;

// BIGNUM=100;

h = 900;
w = 500;
d = 320;
th = 18;
ww = 50;
horse_h = 1.3;

_d_ = 30;
_d = d+_d_;

MODE="help";  // [ "_horse", "plank0", "plank1", "plank2", "spine", "_planks", "shelf", "_end", "end_part1.1", "end_part1.2", "end_part1.3", "end_part1.4", "end_part2.1", "end_part2.2", "end_part2.3", "end_part2.4", "assy", "help" ]
MODES=           [ "plank0", "plank1", "plank2", "spine", "_planks", "shelf", "_end", "end_part1.1", "end_part1.2", "end_part1.3", "end_part1.4", "end_part2.1", "end_part2.2", "end_part2.3", "end_part2.4", "assy", str("help") ];

if(MODE=="plank0") plank(v=0);
else if(MODE=="plank1") plank(v=1);
else if(MODE=="plank2") plank(v=2);
else if(MODE=="spine") spine(orient=BACK, anchor=BACK) position(FRONT);
else if(MODE=="_planks") planks();
else if(MODE=="_end") end();
else if(MODE=="end_part1.1") ends(1, 1);
else if(MODE=="end_part1.2") ends(1, 2);
else if(MODE=="end_part1.3") ends(1, 3);
else if(MODE=="end_part1.4") ends(1, 4);
else if(MODE=="end_part2.1") ends(2, 1);
else if(MODE=="end_part2.2") ends(2, 2);
else if(MODE=="end_part2.3") ends(2, 3);
else if(MODE=="end_part2.4") ends(2, 4);
else if(MODE=="shelf") shelf();
else if(MODE=="_horse") horse();
else if(MODE=="assy") {
  stand();

  // #render()
  //   up(h)
  //   back_half()
  //   saddle();
}
else echo(MODES=MODES);

module stand(anchor=BOTTOM, spin=0, orient=UP) {
  attachable(anchor=anchor, spin=spin, orient=orient, size=[w,d,h], cp=[0,0,h/2]) {
    union() {
      if($t<0.75)
      xcopies(spacing=w-2*th) end();
      if($t<0.25 || $t>0.5)
      planks();
    }
    children();
  }
}

module planks(clearance=0, anchor=BOTTOM, spin=0, orient=UP) {
  attachable(anchor=anchor, spin=spin, orient=orient, size=[w,d,h], cp=[0,0,h/2]) {
    union() {
      let(hh=h*2/3) for(z=[ww/2,520]) up(z) {
        yflip_copy() fwd(d/2) plank(clearance=clearance, v=1, anchor=TOP, orient=FRONT, color="Sienna");
        up(ww/2+$slop) shelf($tags="hide");
      }
      up(h-d/2-_d_/2) yflip_copy() let(ang=20) for(i=[ang:ang:60]) xrot(-90+i-2) fwd(_d/2-th) plank(clearance=clearance, v=(i/ang) % 2, orient=FRONT, anchor=BOTTOM);
      up(h-th) spine(clearance=clearance);
    }
    children();
  }
}

// v==0: 5 horses
// v==1: 4 horses
// v==2: no horses
module plank(clearance=0, v=0, anchor=BOTTOM, spin=0, orient=UP, color="BurlyWood") {
  n = (v==0 ? 4 : (v==1 ? 5 : 0));

  if(clearance==0) echo(BOM = str("plank", v));

  attachable(anchor=anchor, spin=spin, orient=orient, size=[w,ww,th-horse_h], cp=[0,0,(th-horse_h)/2]) {
    color(color)
    render()
    xrot(-90)
    union() {
      back(clearance/2) cuboid([w+clearance,th-(clearance==0?horse_h:0)+clearance,ww+clearance], anchor=BACK);
      if(n>0 && clearance==0) xcopies(spacing=90, n=n) fwd(th-horse_h) horse();
    }
    children();
  }
}

module shelf(anchor=BOTTOM, spin=0, orient=UP) {
  attachable(anchor=anchor, spin=spin, orient=orient, size=[w,d,th], cp=[0,0,th/2]) {
    color("Sienna")
    render()
    difference() {
      cuboid([w-c_eps,d-c_eps,th], anchor=BOTTOM);

      for(i=[-1,1], j=[-1,1]) translate([i*w/2,j*d/2]) cuboid([4*(th+3*$slop),2*(ww+3*$slop),BIGNUM]);
    }
    children();
  }
}

module end(anchor=BOTTOM, spin=0, orient=UP) {

  for(j=[1:2], i=[1:4]) echo(BOM = str("end_part", j, ".", i));

  attachable(anchor=anchor, spin=spin, orient=orient, size=[2*th,d, h], cp=[0,0,h/2]) {
    color("SaddleBrown")
    // render()
    difference() {
      rot([90,0,90]) linear_extrude(2*th, center=true, convexity=3) difference() {
        end_shape();

        offset(-ww) end_shape();
      }

      hide("hide") planks(clearance=$slop);
    }
    children();
  }
}

module ends(pt_maj, pt_min) {

  echo(BOM = str("end", pt_maj, ".", pt_min));

  hh = h-220;
  www = d-2*ww-0.1;

  intersect = pt_maj == 1
              ? [hh, BIGNUM, 2*th]
              : [BIGNUM, www, 2*th];
  shift = pt_maj == 1
          ? ( pt_min <= 2
              ? [-30, 0]
              : ( pt_min == 3
                ? [-hh - 30, 0]
                : [ hh - 30, 0] ))
          : ( pt_min <= 2
              ? [0, 0]
              : ( pt_min == 3
                ? [0, -www]
                : [0,  www] ));
  align = pt_maj == 1
          ? ( pt_min >= 3
              ? CENTER
              : ( pt_min == 1
                ? FWD
                : BACK ))
          : ( pt_min >= 3
              ? CENTER
              : ( pt_min == 1
                ? RIGHT
                : LEFT ));

  union() {
    intersection() {
      translate(shift) cuboid(intersect, anchor=align);
      end(anchor=RIGHT, orient=RIGHT);
    }
  }
}

module spine(clearance=0, anchor=BOTTOM, spin=0, orient=UP, color="BurlyWood") {

  if(clearance==0) echo(BOM = "spine");

  p = flatten([
        bez_begin([-w/2   , -th/2],  90,  40),
        bez_tang( [-w/2+10,    40],  20,  10, 20),
        bez_tang( [-200   ,    60],  45,  10),
        bez_tang( [-180   ,    70],   0,  10),
        bez_tang( [-160   ,    60], -45,  10),
        bez_tang( [  60   ,    10],   0, 120, 70),
        bez_tang( [ 146   ,    28],   0,  15),
        bez_tang( [ w/2-10,    16],   0,  80, 10),
        bez_joint([ w/2   , -th/2],  90,-180, 20, 10),
        bez_end(  [-w/2   , -th/2],   0,  10)
      ]);
  j=5;
  bp = bezier_path(p, splinesteps=ceil(360/($fn==0 ? $fa : $fn)));
  bpo = offset(list_trim(bp, len(bp)-1), delta=clearance, closed=true);

  base_rect = round_corners(
    rect([w,2*th], center=true),
    method="smooth",
    joint=j*1.3,
    closed=true,
    $fn=$fa
  ) ;
  base = path3d(
    offset(
      base_rect
    , r=clearance
    )
  );

  let(hh=70)
  attachable(anchor=anchor, spin=spin, orient=orient, size=[w,2*th,hh+th/2], offset=[0,0,-th+(hh+th/2)/2]) {
    color(color)
    render()
    if(clearance==0) {
      union() {
        xrot(90) offset_sweep(
          bpo
        , h = 2*(th+clearance)
        , bottom = clearance>0 ? [] : os_smooth(joint=j)
        , top = clearance>0 ? [] : os_smooth(joint=j)
        , cp = [0,th/2,th+clearance]
        , anchor = CENTER
        );
        skin(
          [ // up(5, path3d(offset(base_rect, r=clearance-1)))
            down(th+clearance, base)
          , down(th+clearance-1.5*j, base)
          ]
        , slices=2
        );
      }
    }
    else {
      let(h=70+th/2+2*clearance) up(h/2-th-clearance) cuboid([w+2*clearance,2*(th+clearance),h]);
    }
    children();
  }
}

module end_shape() {
  union() {
    rect([d,h-d/2], anchor=FRONT)
      position(BACK) fwd(_d_/2) intersection() {
        oval(d=_d);
        rect([d,BIGNUM], center=true);
      }
  }
}

module horse() {
  render()
  xrot(90)
  scale(0.11)
    import("horse.stl");
}

module saddle() {
  zrot(90)
    import("saddle.amf");
}
