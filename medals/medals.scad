// Parametric printable medals
//
// Usage:
// ``` sh
// > openscad medals.scad -o medals.stl -D 'type=[0-5]' -D 'coin=[0-1]'
// ```
// ... with `type`s:
// ```
// MEDAL_TYPE_STAR=0;
// MEDAL_TYPE_COIN=1;
// MEDAL_TYPE_PETAL=2;
// MEDAL_TYPE_DECAGON=3;
// MEDAL_TYPE_COIN_lg=4;
// MEDAL_TYPE_CROSS=5;
// ```
//
// ... and `coin`s:
// ```
// COIN_CUSTOM=0;
// COIN_LOGO=1;
// COIN_BITCOIN=2;
// ```
//
// To use your own designs in the centre of the medals, create an STL centered on the origin,
// with known diameter and thickness, then:
// ``` sh
// > openscad medals.scad -o medals.stl \
//   -D 'type=[0-5]' -D 'coin=0' \
//   -D 'coin_custom_file="custom_logo.stl"' \
//   -D 'coin_custom_logo_dia=50' \
//   -D 'coin_custom_logo_height=1'
// ```
//
// Dependencies:
// BOSL library installed to your OpenSCAD library directory
//   https://github.com/revarbat/BOSL/blob/master/README.md#installation

include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

/* [Basic Dimensions] */
// Diameter of coin sized medals
outer_d=44;
// Diameter of logo in star, petal, etc. medals
inner_d=outer_d/2+1;
// Diameter of logo in coin sized medals
mid_d=(outer_d+inner_d)/2;
// Height of logo and medal rim
emboss_depth=0.4;
// Medal thickness
thickness=2.4;
// Ribbon length
ribbon_length=33;
// Ribbon width
ribbon_width=22;

/* [Design] */
type=5;  // [0:5]
coin=1;  // [1:2]

/* [Resolution] */
$fn=36;

/* [Custom Logo] */
// Your custom file...
coin_custom_file="custom_logo.stl";
// Diameter of your logo file
coin_custom_logo_dia=50;
// Height of your logo file
coin_custom_logo_height=1;


// Customizer variables stop at first module definition...
module end_customizer_options() {}

// Aperture Science logo from https://www.thingiverse.com/thing:20674
coin_logo_file="aperture_logo.STL";
// by [sicarius](https://www.thingiverse.com/sicarius/about)

// Bitcoin logo from https://www.thingiverse.com/thing:497827
coin_logo_bitcoin="BitCoin_half_thinner.STL";
// by [vinnivanhood](https://www.thingiverse.com/vinnivanhood/about)

shank=inner_d*PI/5;
ring_d=3;
ring_d2=1.2;
ribbon_th=0.4;
ring_y=outer_d/2+ring_d-ring_d2-1.5;


MEDAL_TYPE_STAR=0;
MEDAL_TYPE_COIN=1;
MEDAL_TYPE_PETAL=2;
MEDAL_TYPE_DECAGON=3;
MEDAL_TYPE_COIN_lg=4;
MEDAL_TYPE_CROSS=5;

COIN_CUSTOM=0;
COIN_LOGO=1;
COIN_BITCOIN=2;

// medals=[
//   [MEDAL_TYPE_STAR,    COIN_BITCOIN],  // 0
//   [MEDAL_TYPE_STAR,    COIN_LOGO],
//   [MEDAL_TYPE_COIN,    COIN_LOGO],
//   [MEDAL_TYPE_COIN,    COIN_BITCOIN],  // 3
//   [MEDAL_TYPE_COIN_lg, COIN_BITCOIN],
//   [MEDAL_TYPE_COIN_lg, COIN_LOGO],
//   [MEDAL_TYPE_CROSS,   COIN_BITCOIN],  // 6
//   [MEDAL_TYPE_CROSS,   COIN_LOGO],
//   [MEDAL_TYPE_PETAL,   COIN_LOGO],
//   [MEDAL_TYPE_DECAGON, COIN_LOGO],     // 9
// ];
*for(coin=[1:2]) for(type=[0:5]) translate([type*(outer_d+5),(coin-1)*(ribbon_length+outer_d+10)])
  decoration(type=type, coin=coin);

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
    tube(h=thickness, od=od, id=od-1);
    // inner recess
    tube(h=thickness-emboss_depth,od=od,id=mid_d);
    // coin
    children();
  }
  else if(medal_type==MEDAL_TYPE_COIN_lg) {
    echo("Large coin");
    od=outer_d;
    // outer rim
    tube(h=thickness, od=od, id=od-1);
    // inner recess
    tube(h=thickness-emboss_depth,od=od,id=inner_d);
    // coin
    s=outer_d/(outer_d-3);
    scale([s,s,1]) children();
  }
  else if(medal_type==MEDAL_TYPE_DECAGON) {
    echo("Decagon");
    od=outer_d-1;
    // outer rim and inner recess
    difference() {
      cylinder(h=thickness, d=od, $fn=10);
      zmove(thickness-emboss_depth) cylinder(h=thickness, d=od-3, $fn=10);
    }
    // coin
    s=0.95;
    scale([s,s,1]) children();
  }
  else if(medal_type==MEDAL_TYPE_PETAL) {
    echo("Petal");
    // petals
    for(i=[0:360/5:360]) rotate(i) petal();
    // outer rim
    tube(h=thickness, od=inner_d, id=inner_d-1);
    // inner recess
    tube(h=thickness-emboss_depth,od=inner_d,id=inner_d-4);
    // coin
    s=(inner_d-4)/mid_d;
    scale([s,s,1]) children();
  }
  else if(medal_type==MEDAL_TYPE_CROSS) {
    echo("Cross");
    h=thickness*0.8;
    // cross
    for(i=[0:360/4:360]) rotate(i)
      translate([0,5,h/2]) rotate([-90,0,0]) thinning_wall(h=16,l=[8,16],thick=h,align=V_UP,wall=h*2/3,strut=1.5);
    od=inner_d/2+3.5;
    // outer rim
    tube(h=thickness, od=od, id=od-1);
    // inner recess
    tube(h=thickness-emboss_depth,od=od,id=od-2);
    // swords
    for(i=[-45,45]) rotate(i) sword();
    // coin
    s=(od-2)/mid_d;
    scale([s,s,1]) children();
  }
  else {  // MEDAL_TYPE_STAR
    echo("Star");
    // points
    for(i=[0:360/6:360]) rotate(i) point();
    // outer rim
    tube(h=thickness, od=inner_d, id=inner_d-1);
    // inner recess
    tube(h=thickness-emboss_depth,od=inner_d,id=inner_d-4);
    // coin
    s=(inner_d-4)/mid_d;
    scale([s,s,1]) children();
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
  h=thickness*2/3;
  translate([0,inner_d/2+2,h/2]) cyl(l=h, d=(outer_d/2-inner_d/2+6), fillet=h/2);
}

//coin(COIN_LOGO);
module coin(coin) {
  union() {
    // base
    cylinder(h=2, d=mid_d);
    if (coin==COIN_BITCOIN)
      {
        echo("Logo 2");
        // logo
        d=47.8;
        zmove(1)
          scale([mid_d/d,mid_d/d,thickness/3.5])
            translate([-d/2,-d/2,2.65]) xrot(-90) import(coin_logo_bitcoin);
      }
    else if (coin==COIN_LOGO)
      {
        echo("Logo 1");
        // top
        d=mid_d;
        logo_d=80;
        zmove(2) scale([d/logo_d,d/logo_d,emboss_depth/3.5])
          xmove(-1) import(coin_logo_file);
      }
    else
      {
        echo("Custom Logo");
        s=mid_d/coin_custom_logo_dia;
        zmove(2)
          scale([s,s,emboss_depth/coin_custom_logo_height])
            import(coin_custom_file);
      }
  }
}

module ribbon() {
  difference() {
    union() {
      w=ribbon_width;
      h=ribbon_length;
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
