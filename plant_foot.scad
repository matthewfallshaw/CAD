zz=445.90;
xz=450;
xx=cos(asin(zz/xz))*xz;
dia=10.2;
bignum=max(zz,xz);

angle=90-asin(zz/xz);

$fn=100;

difference() {
  rotate(angle,[0,1,0]) translate([0,0,78]) difference() {
    translate([0,0,-80]) cylinder(h=120,d=15);
    scale([1.02,1.02,1.02]) rotate(-angle,[0,1,0]) leg();
  }
  translate([0,0,-bignum/2]) cube([bignum,bignum,bignum],center=true);
}

module leg() {
  difference() {
    translate([-xx,0,-zz]) rotate(angle,[0,1,0]) linear_extrude(xz*3) circle(d=dia);
    translate([0,0,-bignum/2]) cube([bignum,bignum,bignum],center=true);
    translate([0,0,bignum/2+zz]) cube([bignum,bignum,bignum],center=true);
  }
}
