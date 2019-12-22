include <BOSL/constants.scad>
use <BOSL/math.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>
include <NopSCADlib/core.scad>
use <NopSCADlib/utils/core/polyholes.scad>

base=[100,50,10];
clearance=0.2;
spacing=3;
hole_depth=8;
die_dia=25.4;

taps=[
  // base square, thread
  [5.4, "M10"],
  [6.25,"M8"],
  [5.6, "M8"],
  [4.75,"M6"],
  [4.3, "M5"],
  [3.5, "M5"],
  [3.3, "M4"],
  [2.45,"M3"],
  [2.45,"M3"],
];
tap_dies=["M9","M8","M6"];

union() {
  difference() {
    // base
    union() {
      translate([base[0]/2,base[1]/2,-base[2]])
        rounded_prismoid(size1=[base[0],base[1]],size2=[base[0],base[1]],h=base[2],r=3);
      translate([5+die_dia/2,die_dia+6]) for (i=[0:len(tap_dies)-1]) {
        xmove(i*(die_dia+clearance+spacing)) {
          translate([0,-(die_dia/2+3.5)]) linear_extrude(0.6) offset(r=0.2) text(tap_dies[i],size=2.5,halign="center");
        }
      }
      translate([5,10]) for (i=[0:len(taps)-1]) {
        tn=sum(slice([for (t=taps) max(t[0],4)],0,i+1))+i*spacing;
        tt=taps[i];
        tap=tt[1];
        translate([tn,-6.5]) linear_extrude(0.6) offset(r=0.2) text(tap,size=2.5,halign="center");
      }
    }

    // tap squares
    translate([5,10]) for (i=[0:len(taps)-1]) {
      tt=taps[i];
      tn=sum(slice([for (t=taps) max(t[0],4)],0,i+1))+i*spacing;
      sq=tt[0];
      tap=tt[1];
      translate([tn,0,0.1]) downcube([sq+clearance,sq+clearance,hole_depth+0.1]);
    }

    // handle
    translate([90,10,-9]) poly_cylinder(h=10,r=(9+clearance)/2);

    // die circles
    translate([5+die_dia/2,die_dia+6]) for (i=[0:len(tap_dies)-1]) {
      xmove(i*(die_dia+clearance+spacing)) {
        zmove(-3) poly_cylinder(h=4,r=(die_dia+clearance)/2);
      }
    }
  }
}
