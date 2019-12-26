// A Customisable Cup/Container

include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

lh=0.2;
lw=0.45;

// Base cube dimension
cell_cube=8;  // [1:50]
// How much should the cube be flattened? 1 = no flattening.
cell_width_factor=0.1;  // [0.05:0.05:1]
// Radius of the cylinder, excluding the protuding features.
ring_rad=40;  // [5:200]
// Approximate height of the cylinder. Complete rows will change the actual height.
height=60;  // [10:300]
// Floor thickness. Best to pick a multiple of your layer thickness.
base_thickness=1.2;  // [0.1:0.1:3.5]
// Wall thickness. Best to pick a multiple of your line width.
thickness=0.7;  // [0.4:0.4:3.6]
// Base fillet. Avoid hard to clean sharp corners.
base_fillet_rad=4;  // [0:10]
// Rim radius.
rim_radius=1.5;  // [0:10]

rh=sqrt(1/2);
ring_height=rh*rh*cell_cube+rh*cell_cube+0.2;
cut_buffer=2*ring_height;
adjusted_height=floor(height/ring_height)*ring_height;
base_lift=cell_cube*rh*rh;

// Detail level.
$fn=64;  // [3:1:128]

basket();

module wall() {
  for (i=[0:floor((height-2*base_lift-base_thickness)/ring_height)-1]) {
    translate([0,0,i*ring_height]) ring(i%2==0);
  }
}

module ring(even=false) {
  cells=floor(PI*ring_rad*2/sqrt(cell_cube*cell_cube*2));
  for (i=[0:cells]) {
    rotate(i/cells*360+(even?360/cells/2:0),[0,0,1]) translate([0,ring_rad]) cell();
  }
}

module cell(cell_cube=cell_cube) {
  scale_factor=1-cell_cube/ring_rad;
  translate([0,0,rh*sqrt(2*cell_cube*cell_cube)]) hull() {
    sub_cell(cell_cube);
    translate([0,-cell_cube]) scale([scale_factor,scale_factor,scale_factor]) sub_cell(cell_cube);
  }
}

module sub_cell(cell_cube=cell_cube) {
  scale([1,cell_width_factor,1])
    translate([0,-rh*rh*cell_cube,0])
      rotate([-45,0,0]) rotate([0,0,45])
        cube(cell_cube);
}

module basket() {
  difference() {
    union() {
      cyl(h=height-rim_radius,r=ring_rad,fillet1=base_fillet_rad,align=V_TOP);
      translate([0,0,base_lift]) wall();
      translate([0,0,height-rim_radius]) rotate_extrude() translate([ring_rad,0]) circle(rim_radius);
    }
    translate([0,0,base_thickness])
      cyl(h=height,r=ring_rad-thickness,fillet1=base_fillet_rad-thickness,align=V_TOP);
  }
}
