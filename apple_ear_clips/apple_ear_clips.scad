include <stdlib.scad>

// $fn=0;
// $fa=12;
// $fs=2;
// $fn=16;
// $fn=32;
$fn=64;

BIGNUM=100;

d=3.5;
o=oval(d=d);
sc=4.9/4;

// MODE="left";
MODE="right";

if(MODE=="left") clip();
else if(MODE=="right") yflip() clip();

module clip() {
  render()
  top_half(z=-0.75)
  union() {
    scale([1,sc,1]) difference() {
      union() {
        spiral_sweep(o,h=21,r=4.5/2,twist=360*3,higbee1=0.01,higbee2=4);
        translate([4.5/2,0.05,0.05]) cyl(d=d,l=2.05,orient=FRONT,anchor=BOTTOM);
      }

      cyl(d=4,l=BIGNUM);
    }
    translate([4.5/2,-2*sc,0.05]) {
      up(10) yrot(90) rotate_extrude(angle=-45) right(10) oval(d=d);
      up(10) xrot(-45) down(10) cyl(d=d,l=14,orient=FRONT,anchor=BOTTOM)
        attach(TOP,BOTTOM) down(d/2) spheroid(d=d);
    }
  }
}
