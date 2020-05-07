include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
use <archimedean_spiral.scad>

$fn=100;

clip();
//hemisphere();

module clip() {
  dia=12;
  base=[15,30,1.5];
  rotate([0,90]) union() {
    // back
    zmove(-base[2]) cuboid(size=base,chamfer=2,edges=EDGES_Z_ALL);
    // clip
    translate([base[0]/2,0,(dia-1.4)/2]) rotate([0,-90]) rotate(20) difference() {
      linear_extrude(base[0])     archimedean_spiral(spirals=4.0,thickness=1.2,rmax=dia/2);
      zmove(-1) {
        linear_extrude(base[0]+2) archimedean_spiral(spirals=2.9,thickness=1.4,rmax=0.7*dia/2);
        cylinder(h=base[0]+2,d=5);
      }
    }
  }
}

module hemisphere() {
  dia=28;
  rad=dia/2;
  difference() {
    // sphere
    top_half() staggered_sphere(d=dia);
    // cable hole
    zmove(rad-5.5) teardrop(d=8, l=dia, ang=45);
    // chamfer
    r=sqrt(rad*rad-1)+0.1;
    zmove(-0.001) tube(h=1, or1=rad+10, or2=r, ir1=r-1, ir2=r);
  }
}
