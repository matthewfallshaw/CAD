include <stdlib.scad>

$fn=100;

int_dia=75;
wall=1.2;
total_height=3;
feet=5;
feet_dia=5;
holes_per_circle=5;

union() {
  // base plate
  difference() {
    cyl(h=total_height-wall,d=int_dia+wall,anchor=BOTTOM);

    zrot_copies(n=holes_per_circle,r=int_dia/2/3*2)
      cyl(h=2*total_height,d=5);
    zrot_copies(n=holes_per_circle,r=int_dia/2/3,sa=360/holes_per_circle/2)
      cyl(h=2*total_height,d=5);
  }
  // outer wall
  up(total_height/3) tube(h=total_height*2/3,od=int_dia+wall,wall=wall,anchor=BOTTOM);
  // feet
  if(feet>0) bottom_half(z=0.01) zrot_copies(n=feet,r=int_dia/2-feet_dia/2) sphere(d=feet_dia);
}
