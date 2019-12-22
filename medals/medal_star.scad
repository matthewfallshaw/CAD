include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

outer_d=44;
inner_d=outer_d/2+1;
shank=inner_d*3.1416/5;
height=2.4;
ring_d=3;
ring_d2=1.2;
ring_y=outer_d/2+ring_d-ring_d2-1.5;
ribbon_th=0.4;

board_height=33;
ribbon_face=22;

MEDAL_TYPE_STAR=0;
MEDAL_TYPE_COIN=1;
MEDAL_TYPE_PETAL=2;
MEDAL_TYPE_DECAGON=3;
MEDAL_TYPE_COIN_lg=4;
MEDAL_TYPE_CROSS=5;

COIN_BITCOIN=0;
COIN_BELLROY=1;

$fn=360/2;

xspacing=80;
yspacing=45;
medals=[
  [MEDAL_TYPE_STAR,    COIN_BITCOIN],  // 0
  [MEDAL_TYPE_STAR,    COIN_BELLROY],
  [MEDAL_TYPE_COIN,    COIN_BELLROY],
  [MEDAL_TYPE_COIN,    COIN_BITCOIN],  // 3
  [MEDAL_TYPE_COIN_lg, COIN_BITCOIN],
  [MEDAL_TYPE_COIN_lg, COIN_BELLROY],
  [MEDAL_TYPE_CROSS,   COIN_BITCOIN],  // 6
  [MEDAL_TYPE_CROSS,   COIN_BELLROY],
  [MEDAL_TYPE_PETAL,   COIN_BELLROY],
  [MEDAL_TYPE_DECAGON, COIN_BELLROY],  // 9
];

type=medals[8][0];
coin=medals[8][1];
decoration(type=type, coin=coin);

module decoration(type=MEDAL_TYPE_STAR,coin=COIN_BITCOIN) {
  union() {
    // medal
    medal(type) coin(coin);
    // ribbon ring
    difference() {
      translate([0,ring_y,ring_d2/3]) torus(r=ring_d/2,r2=ring_d2/2,orient=ORIENT_Z);
      translate([0,ring_y,0]) downcube([ring_d+2,ring_d+2,ring_d+2]); // cleaning cut
    }
    // ribbon
    translate([0,outer_d/2+1]) ribbon();
    translate([0,outer_d/2+ring_d-ring_d2-1]) cylinder(h=ribbon_th,d=ring_d);
  }
}

module medal(medal_type) {
  if(medal_type==MEDAL_TYPE_COIN) {
    echo("Coin");
    od=outer_d-3;
    // outer rim
    tube(h=height, od=od, id=od-1);
    // inner recess
    tube(h=height-0.4,od=od,id=od-4);
    // inner rim
    tube(h=height, od=od-6, id=od-7);
    // coin
    scale([od/inner_d,od/inner_d,1]) children();
  }
  else if(medal_type==MEDAL_TYPE_COIN_lg) {
    echo("Large coin");
    od=outer_d;
    // outer rim
    tube(h=height, od=od, id=od-1);
    // inner recess
    tube(h=height-0.4,od=od,id=od-4);
    // inner rim
    tube(h=height, od=od-6, id=od-7);
    // coin
    scale([od/inner_d,od/inner_d,1]) children();
  }
  else if(medal_type==MEDAL_TYPE_DECAGON) {
    echo("Decagon");
    od=outer_d-1;
    // outer rim
    difference() {
      cylinder(h=height, d=od, $fn=10);
      down(1) cylinder(h=height+2, d=od-3, $fn=10);
    }
    // coin
    s=0.95;
    scale([od/inner_d*s,od/inner_d*s,1]) children();
  }
  else if(medal_type==MEDAL_TYPE_PETAL) {
    echo("Petal");
    // petals
    for(i=[0:360/5:360]) rotate(i) petal();
    // outer rim
    tube(h=height, od=inner_d, id=inner_d-1);
    // inner recess
    tube(h=height-0.4,od=inner_d,id=inner_d-4);
    // inner rim
    tube(h=height, od=inner_d-4, id=inner_d-5);
    // coin
    s=0.9;
    scale([s,s,1]) children();
  }
  else if(medal_type==MEDAL_TYPE_CROSS) {
    echo("Cross");
    h=height*0.8;
    // cross
    for(i=[0:360/4:360]) rotate(i)
      translate([0,5,h/2]) rotate([-90,0,0]) thinning_wall(h=16,l=[8,16],thick=h,align=V_UP,wall=h*2/3,strut=1.5);
    od=inner_d/2+3.5;
    // outer rim
    tube(h=height, od=od, id=od-1);
    // inner recess
    tube(h=height-0.4,od=od,id=od);
    // inner rim
    tube(h=height, od=od, id=od);
    // swords
    for(i=[-45,45]) rotate(i) sword();
    // coin
    s=0.65;
    scale([s,s,1]) children();
  }
  else {  // MEDAL_TYPE_STAR
    echo("Star");
    // points
    for(i=[0:360/6:360]) rotate(i) point();
    // outer rim
    tube(h=height, od=inner_d, id=inner_d-1);
    // inner recess
    tube(h=height-0.4,od=inner_d,id=inner_d-4);
    // inner rim
    tube(h=height, od=inner_d-4, id=inner_d-5);
    // coin
    children();
  }
}

module sword() {
  base_height=ribbon_th;
  union() {
    translate([0,-17]) rotate([90,0,0]) hull() {
      translate([0,0,-6]) linear_extrude(0.1)
        polygon([
          [-1,0],[-1,base_height],
          [0,base_height*2],
          [1,base_height],[1,0]]);
      translate([0,0,-32]) linear_extrude(0.1)
        polygon([
          [-1,0],[-1,base_height],
          [0,base_height*2],
          [1,base_height],[1,0]]);
      translate([0,0,-34]) linear_extrude(0.1)
        polygon([
          [-0.1,0],[-0.1,base_height],
          [0,base_height],
          [0.1,base_height],[0.1,0]]);
    }
    translate([0,-11]) xdistribute(l=5) {
      scale([1,0.7]) rotate(45) translate([-8/6,-8/6]) cube([8/3,8/3,base_height*2]);
      translate([-8/6,-1]) cube([8/3,2,base_height*2]);
      scale([1,0.7]) rotate(45) translate([-8/6,-8/6]) cube([8/3,8/3,base_height*2]);
    }
    translate([-1,-18]) cube([2,7,base_height*1.5]);
  }
}

module point() {
  base_height=ribbon_th;
  translate([0,inner_d/2-5]) rotate([90,0,0]) hull() {
    linear_extrude(0.1)
      polygon([
        [-shank/2,0],[-shank/2,base_height],
        [0,2],
        [shank/2,base_height],[shank/2,0]]);
    translate([0,0,-(outer_d/2-(inner_d/2-5))]) linear_extrude(0.1)
      polygon([
        [-0.1,0],
        [0.1,0],
        [0,base_height]]);
  }
}

module petal() {
  h=height*2/3;
  translate([0,inner_d/2+2,h/2]) cyl(l=h, d=(outer_d/2-inner_d/2+6), fillet=h/2);
}

//coin(COIN_BELLROY);
module coin(coin) {
  union() {
    // base
    cylinder(h=2, d=inner_d);
    if (coin==COIN_BELLROY)
      {
        echo("Bellroy");
        // logo
        scale([0.9,0.9,height/0.35]) translate([-8.2,10]) import("Bellroy_Logo.stl");

      }
    else
      {
        echo("Bitcoin");
        // top
        scale([(inner_d-3)/48,(inner_d-3)/48,0.6]) translate([-24,-24,4.2]) rotate([-90,0,0])
          import("BitCoin_half_thinner.STL");
      }
  }
}

module ribbon() {
  difference() {
    union() {
      w=ribbon_face;
      h=board_height;
      diag=sqrt(2*(w/2)*(w/2));
      translate([0,-3]) rotate(45) cube([diag,diag,ribbon_th]);
      translate([-w/2,w/2-3]) cube([w,h,ribbon_th]);
    }
    union() {
      translate([-10,-5,-1]) cube([20,5,10]);
    }
    translate([0,18,-1]) cylinder(h=10,d=5);
  }
}
