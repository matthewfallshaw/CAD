// include <stdlib.scad>
include <BOSL2/std.scad>

$fn=64;
BIGNUM=100;

l=112;
w=18;
th=1.6;
mate_th=1.4;
mate_l=11;
mate_ang=45;


mount();

module mount() {
  difference() {
    union() {
      cuboid([w,l,th],anchor=BOTTOM);
      fwd(l/2) intersection() {
        xrot(mate_ang) let(d=95) fwd(d/2) down(th/2*cos(mate_ang)) tube(id=d-th,l=mate_l*1.2,wall=2*th);
        cuboid([w,l+95/2,w],anchor=BOTTOM);
      }
      back(l/2) cuboid([w,th,8],anchor=BOTTOM);
      translate([0,l/2,8]) prismoid(size1=[w,0],size2=[w,2*th],h=3*th,shift=[0,th],anchor=TOP+FRONT);
    }

    for(i=[-40:4:40]) fwd(i) cuboid([3,1.2,BIGNUM]);
    translate([0,-l/2-0.5,-th/2]) xrot(mate_ang) mate();
  }
}

module mate() {
  up(th) {
    cuboid([mate_th,2*th,mate_l],anchor=BOTTOM);
    translate([-2.5,0,mate_l/2]) zcopies(spacing=mate_l) cuboid([w,2*th,mate_th],anchor=BOTTOM);
  }
}
