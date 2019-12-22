include <polyhole.scad>

lh=0.32;
lw=0.4;

id=3;
od=id+3*lw*2;
handle_base=4;
handle_len=40;

$fn=128;

union() {
  cylinder(h=handle_base,d=od);
  difference() {
    cylinder(h=handle_len,d=od);
    polyhole(h=handle_len+1,d=id);
  }
}
