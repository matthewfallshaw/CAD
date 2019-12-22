// Base cube dimension
cell_cube=8;  // [1:50]
// How much should the cube be flattened? 1 = no flattening.
cell_width_factor=0.1;  // [0.05:0.05:1]
// Radius of the cylinder, excluding the protuding features.
ring_rad=40;  // [5:200]
// Approximate height of the cylinder. Complete rows will change the actual height.
height=60;  // [10:300]
// Floor thickness. Best to pick a multiple of your layer thickness.
base_thickness=1.225;  // [0.175:0.175:3.5]
// Wall thickness. Best to pick a multiple of your line width.
thickness=0.7;  // [0.35:0.35:3.5]
// Base fillet. Avoid hard to clean sharp corners.
base_fillet_rad=4;  // [0:10]
// Rim radius.
rim_radius=1.5;  // [0:10]

rh=sqrt(1/2);
ring_height=rh*rh*cell_cube+rh*cell_cube;
cut_buffer=2*ring_height;
adjusted_height=floor(height/ring_height)*ring_height;
base_lift=cell_cube*rh*rh;

// Detail level.
$fn=128;  // [3:1:128]

*translate([0,0,adjusted_height]) cube([1000,1000,0.01],center=true);

*sub_cell();
*cell();
*ring();
*wall();
*base_radius();
*base_radius(clear_outside=true);
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

module base_radius(fillet_rad=base_fillet_rad,wall_rad=ring_rad,clear_outside=false) {
  rotate_extrude() translate([-wall_rad,0]) difference() {
    square(fillet_rad*(clear_outside?2:1),center=clear_outside);
    translate([fillet_rad,fillet_rad]) circle(fillet_rad);
  }
}

module basket() {
  difference() {
    union() {
      difference() {
        union() {
          cylinder(h=height-base_thickness,r=ring_rad);
          translate([0,0,base_lift]) wall();
          translate([0,0,height-rim_radius]) rotate_extrude() translate([ring_rad,0]) circle(rim_radius);
        }
        translate([0,0,base_thickness]) cylinder(h=height+cut_buffer,r=ring_rad-thickness);
      }
      translate([0,0,base_thickness]) base_radius(wall_rad=ring_rad-thickness);
    }
    base_radius(fillet_rad=base_fillet_rad+base_thickness,wall_rad=ring_rad,clear_outside=true);
  }
}
