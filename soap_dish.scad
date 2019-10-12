use <MCAD/array.scad>

width=105;
depth=82;
thickness=3;

mount_offset=15;
mount_base_rad=6;
mount_height=6;

hole_dia=5;
holes_x=6;
holes_y=5;

$fn=100;

union() {
  right_half();
  mirror([1,0,0]) right_half();
};

module right_half() {
  union() {
    difference() {
      cube([width/2,depth,thickness]);
      translate([-(width/holes_x)/2,-(depth/holes_y)/2]) Cubic_Array(width/holes_x,depth/holes_y,0,3,5,0,center=false) {
        translate([0,0,-1]) cylinder(thickness*2+1,d=hole_dia);
      };
    }
    translate([0,depth/2]) mirror_copy([0,1,0]) mount();
  }
};

module mount() {
  translate([width/2-mount_offset-mount_base_rad+3,mount_offset+mount_base_rad+5,thickness])
    mirror([0,0,1])
      linear_extrude(height=mount_height+thickness,scale=1/0.7,center=false)
        circle(mount_base_rad*0.7);
};

module mirror_copy(v=[0,0,1]) {
  children();
  mirror(v) children();
};
