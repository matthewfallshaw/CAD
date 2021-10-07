// A Customisable Cup/Container

include <stdlib.scad>

/* [Print parameters] */
// layer height
lh=0.2;
// line width
lw=0.45;

/* [Dimensions] */
// Base cube dimension
cell_cube=8;  // [1:50]
// How much should the cube be flattened? 1 = no flattening.
cell_width_factor=0.1;  // [0.05:0.05:1]
// Diameter of the cylinder, excluding the protuding features.
ring_dia=60;  // [5:200]
// Approximate height of the cylinder. Complete rows will change the actual height.
height=100;  // [10:300]
// Floor thickness. Best to pick a multiple of your layer thickness.
base_thickness=1.2;  // [0.1:0.1:3.5]
// Wall thickness. Best to pick a multiple of your line width.
thickness=0.7;  // [0.4:0.4:3.6]
// Base fillet. Avoid hard to clean sharp corners.
base_fillet_rad=4;  // [0:10]
// Rim diameter.
rim_dia=3;  // [0:20]


/* [Config] */
// Vase mode print
vase_mode=true;
// Detail level.
$fn=64;  // [3:1:128]

rh=sqrt(1/2);
ring_height=rh*rh*cell_cube+rh*cell_cube+0.2;
cut_buffer=2*ring_height;
adjusted_height=floor(height/ring_height)*ring_height;
base_lift=cell_cube*rh*rh;

rim_bump=rim_dia*(1-sin(45));

basket(vase_mode);

module wall() {
  for (i=[0:floor((height-2*base_lift-base_thickness)/ring_height)-1]) {
    translate([0,0,i*ring_height]) ring(i%2==0);
  }
}

module ring(even=false) {
  cells=floor(PI*ring_dia/sqrt(cell_cube*cell_cube*2));
  for (i=[0:cells]) {
    rotate(i/cells*360+(even?360/cells/2:0),[0,0,1]) translate([0,ring_dia/2]) cell();
  }
}

module cell(cell_cube=cell_cube) {
  scale_factor=1-cell_cube/(ring_dia/2);
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

module basket(vase_mode=false) {
  difference() {
    union() {
      let(bump=base_fillet_rad*(1-cos(45))) top_half(s=max(2*ring_dia,2*height)) down(bump)
        cyl(h=height-rim_dia/2+bump,d=ring_dia,rounding1=base_fillet_rad,anchor=BOTTOM);
      translate([0,0,base_lift]) wall();
      translate([0,0,height-rim_dia/2])
        if(vase_mode) {
          bottom_half(z=rim_dia/2)
          scale([1,1,1.15])
          torus(r_maj=ring_dia/2-rim_bump,d_min=rim_dia);
        } else {
          torus(r=ring_dia/2,d2=rim_dia);
        }
    }

    if(!vase_mode) translate([0,0,base_thickness])
      cyl(h=height,d=ring_dia-2*thickness,rounding1=base_fillet_rad-thickness,anchor=BOTTOM);
  }
}
