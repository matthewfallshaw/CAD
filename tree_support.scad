include <NopSCADlib/lib.scad>
include <puzzlecut.scad>

lw=0.45;
lh=0.2;

dia=10;
pin_dia=dia/2;
n=7;

module forked_beam()
{
  difference() {
    union() {
      translate([0,-25,-z_adj(dia,n)]) cube([3,50,50]);
      beam(400,dia,n);
      translate([400,0]) for(r=[-45,45]) {
        rotate(r) beam(50,dia,n);
      }
      translate([+(50-8)*sin(45),0]) rotate([0,-135]) beam(50,dia,n);
    }
    translate([-100,-50,-dia]) cube(100);
  }
}

function z_adj(d,n)=(d/2)*cos(360/n/2);


cut=210;
translate([cut,0]) puzzle_cut(pin_dia=pin_dia,pin_length=8,sex=PC_MALE,  axis=PC_X)
  translate([-cut,0]) forked_beam();
translate([0,50])  puzzle_cut(pin_dia=pin_dia,pin_length=8,sex=PC_FEMALE,axis=PC_X)
  translate([-cut,0]) forked_beam();
