include <stdlib.scad>
include <BOSL2/skin.scad>

// $fn=0;
// $fa=12;
// $fs=2;
$fn=32;

BIGNUM=100;

plastic_o=[ 189  , 88  , 8.5,  2     ];
bamboo_o =[ 190  , 88.4, 8.5, 16.5/2 ];
clear_i  =[ 197.5, 95  ,  0 , 11.5/2 ];
wall=1.6;
interference=0.5;

// MODE="bamboo";
// MODE="plastic";
MODE="plastic3";

if(MODE=="bamboo")       seal(bamboo_o);
else if(MODE=="plastic") seal(plastic_o);
else if(MODE=="plastic3") seal(plastic_o,rings=4);

module seal(o,rings=2) {
  difference() {
    union() {
      cuboid([o.x, o.y, o.z] + [2*wall, 2*wall, 0], rounding=o[3]+wall, edges="Z", anchor=BOTTOM);
      let(step=o.z/(rings+1)) for(z=[0:step:o.z-o.z/6-wall/2]) up(z+step/2-wall/2) skirt(o);
    }

    down(0.01) cuboid([o.x, o.y, BIGNUM], rounding=o[3], edges="Z", anchor=BOTTOM);
  }
}

module skirt(o) {
  r=clear_i[3];

  skirt_in =path3d(rect([for(i=slice(o,0,2)) i],                rounding=o.z,     center=true, $fn=32));
  skirt_out=path3d(rect([for(i=slice(clear_i,0,2))  i+2*interference], rounding=r+interference, center=true, $fn=32));

  skin(
    [
      skirt_in,
      apply(up(o.z/6+wall/2),skirt_out),
    ],
    slices=10
  );
}
