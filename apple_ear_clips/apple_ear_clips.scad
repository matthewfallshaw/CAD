include <stdlib.scad>

// $fn=0;
// $fa=12;
// $fs=2;
// $fn=16;
// $fn=32;
$fn=64;

BIGNUM=100;

d=3.7;        // diameter of the spiral
shaft_d=4;  // minor diameter of shaft (modified by `sc` for major dia)
sc=4.9/4;     // scale/ovalness of shaft

o=oval(d=d);
spiral_d=shaft_d+d*3/4;

// MODE="left";
MODE="right";

if(MODE=="left") clip();
else if(MODE=="right") yflip() clip();

module clip() {
  render()
  top_half(z=-d/2*(2/3))
  union() {
    scale([1,sc,1]) difference() {
      union() {
        let(nudge=10)  // nudge to start the spiral early, avoiding a gap
          spiral_sweep( o, h=21*5/6, r=spiral_d/2
                      , twist=360*2.4+nudge, higbee1=0.01, higbee2=4
                      , spin=-nudge
                      );
        // pole start
        translate([spiral_d/2,0.05,0.05]) cyl(d=d, l=2.05, chamfer1=0.1, chamfang=10, orient=FRONT, anchor=BOTTOM);
      }

      cyl(d=shaft_d,l=BIGNUM);
    }
    // pole continuation
    translate([spiral_d/2,-2*sc,10.05]) {
      yrot(90) rotate_extrude(angle=-45) right(10) oval(d=d);
      let(end_d=max(3/4*d,3))
        xrot(-45) down(10) cyl(d1=d, d2=end_d, l=14, orient=FRONT, anchor=BOTTOM)
          attach(TOP,BOTTOM) down(end_d/2) spheroid(d=end_d);
    }
  }
}
