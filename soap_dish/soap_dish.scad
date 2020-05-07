width=105;
depth=82;
thickness=3;

mount_base_rad=6;
mount_height=6;
mount_side_offset=10;
mount_front_offset=7;
mount_back_offset=14;
base_rad=3;

hole_dia=5;
holes_x=6;
holes_y=5;

$fn=100;


union() {
  right_half();
  left_half();
};

module right_half() {
  union() {
    difference() {
      hull() {
        translate([width/2-base_rad,base_rad]) cylinder(h=thickness,r=base_rad);
        translate([width/2-base_rad,depth-base_rad]) cylinder(h=thickness,r=base_rad);
        cube([1,1,thickness]);
        translate([0,depth-1]) cube([1,1,thickness]);
      }
      holes();
    }
    translate([width/2-mount_side_offset-mount_base_rad,mount_front_offset]) mount_foot();
    translate([width/2-mount_side_offset-mount_base_rad,depth-mount_back_offset]) rotate(180) mount_foot();
  }
};

module left_half() {
  mirror([1,0,0]) right_half();
}

module mount_foot() {
  translate([0,mount_base_rad,-mount_height]) hull() {
    cylinder(h=1,r1=mount_base_rad,r2=mount_base_rad*0.7);
    translate([0,-mount_base_rad*0.3,mount_height]) mirror([0,0,1]) cylinder(h=1,r1=mount_base_rad*0.7,r2=mount_base_rad*0.7);
  }
};

module holes() {
  grid_x=width/holes_x;
  grid_y=depth/holes_y;
  translate([grid_x/2,grid_y/2]) for (i=[0:holes_x/2-1]) for (j=[0:holes_y-1]) {
    translate([i*grid_x,j*grid_y,-1]) cylinder(thickness*2+1,d=hole_dia);
  };
}
