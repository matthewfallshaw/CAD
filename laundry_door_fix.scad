lw=0.4;
lh=0.32;

$fn=128;

th=fh(6);
w=fw(2);

difference() {
union() {
  // tongue
  cube([42,fw(10),th]);
  // end
  translate([42,3]) cylinder(h=th,r=3);
  translate([42,3]) cube([3,5+10-3,th]);
  // end internal fillet
  difference() {
    translate([42-2,10]) cube([2,2,th]);
    translate([42-2,10+2,-1]) cylinder(h=100,r=2);
  }
  // base
  translate([-fw(2),-75/2]) cube([fw(2),75,fh(19*2)]);
  // base fillet
  difference() {
    translate([0,-3]) cube([3,10+2*3,th+3]);
    translate([3,-3]) cylinder(h=100,r=3,center=true);
    translate([3,10+3]) cylinder(h=100,r=3,center=true);
    rotate([-90,0,0]) translate([3,-3-th]) cylinder(h=100,r=3,center=true);
  }
}
translate([0,1.2,1]) cube([42,fw(10)-2*1.2,th-2*1]);
}

module section() {
}

function f(x,target)=ceil(x/target)*target;
function fw(x)=f(x,lw);
function fh(x)=f(x,lh);
