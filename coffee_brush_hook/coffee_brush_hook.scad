lh=0.175;
lw=0.35;

basew=fw(16);
based=fw(28);
baseh=fh(0.8);
off=fh(4);
dia=fw(8);
rad=7;

$fn=128;

union() {
  translate([-basew/2,-based/2,-baseh]) cube([basew,based,baseh]);
  scale([1,0.75,1]) cylinder(h=off,d=dia);
  translate([0,rad,off]) rotate([90,0,-90]) rotate_extrude(angle=60) translate([rad,0]) scale([0.75,1]) circle(d=dia);
  translate([0,rad,off]) rotate([-60,0,0]) translate([0,-rad]) scale([1,0.75,0.3]) sphere(d=dia);
}

function fh(h)=ceil(h/lh)*lh;
function fw(w)=ceil(w/lw)*lw;
