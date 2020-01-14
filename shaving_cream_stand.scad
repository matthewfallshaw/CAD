include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

int_dia=78;
wall=2;
total_height=3;
feet=0;
feet_dia=5;
holes=5;

$fn=100;

union() {
  // base plate
  difference() {
    cyl(h=total_height/3, d=int_dia+wall);
    zrot_copies(n=holes, r=int_dia/2/3*2)               cyl(h=wall+2,d=5);
    zrot_copies(n=holes, r=int_dia/2/3, sa=360/holes/2) cyl(h=wall+2,d=5);
  }
  // outer wall
  zmove(-total_height/3/2) tube(h=total_height*2/3, od=int_dia+wall, wall=wall, align=V_TOP);
  // feet
  if(feet>0) bottom_half() zmove(feet_dia/2-total_height*2/3) zrot_copies(n=feet, r=int_dia/2-feet_dia/2) sphere(d=feet_dia);
}
