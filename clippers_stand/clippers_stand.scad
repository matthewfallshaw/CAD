blade_width=46;
blade_depth=38.3;
blade_rad=6;
blade_thickness=3.45;
blade_slice=11;
blade_back_top_cham=1.25;
blade_back_bot_cham=blade_thickness-blade_back_top_cham;
blade_base_lift=7;
blade_rotation=45;
blade_tower_scale=0.6;

clippers_length=149;
clippers_height=6;
clippers_bottom_width=27;
clippers_bottom_rad=4.5;

base_width=212;
base_depth=212;
base_thickness=1.5;
base_rad=3;

cell_width=base_width/4;

$fn=128;

module blade_stand() {
  //y_nudge=blade_depth*(1-blade_tower_scale)/2*cos(blade_rotation);
  y_nudge=1;
  union() {
    color("silver") translate([0,0,blade_base_lift]) rotate([blade_rotation,0,0]) blade_shape();
    translate([0,y_nudge]) hull() {
      scale([blade_tower_scale,blade_tower_scale*cos(blade_rotation),1]) blade_block();
      translate([0,0,blade_base_lift+y_nudge*sin(blade_rotation)+2])
        rotate([blade_rotation,0,0])
          scale([blade_tower_scale,blade_tower_scale,0.1])
            blade_block();
    }
  }
}

module blade_shape() {
  intersection() {
    blade_block();
    blade_cut();
  }
}

module blade_profile() {
  round_tip_dia=0.38;
  round_tip_setback=(round_tip_dia/2/tan(atan(blade_thickness/blade_slice)/2));
  union() {
    polygon(
      [ [0, blade_back_bot_cham]
      , [blade_back_bot_cham, 0]
      , [blade_thickness, blade_back_top_cham]
      , [blade_thickness, blade_depth-blade_slice]
      , [0.38,blade_depth-round_tip_setback]
      , [0,blade_depth-round_tip_setback]
      ]
    );
    translate([0.38/2,blade_depth-round_tip_setback]) circle(d=0.38);
  }
}
module blade_block() {
  linear_extrude(blade_thickness) hull() {
    translate([-blade_width/2+blade_rad,blade_rad    ]) circle(blade_rad);
    translate([ blade_width/2-blade_rad,blade_rad    ]) circle(blade_rad);
    translate([-blade_width/2          ,blade_depth-1]) square(1);
    translate([ blade_width/2-1        ,blade_depth-1]) square(1);
  }
}
module blade_cut() {
  translate([blade_width,0]) rotate([0,-90,0]) linear_extrude(2*blade_width) blade_profile();
}


module base() {
  translate([0,0,-base_thickness]) hull() {
    translate([-base_width/2+base_rad,base_rad])            cylinder(h=base_thickness,r=base_rad);
    translate([ base_width/2-base_rad,base_rad])            cylinder(h=base_thickness,r=base_rad);
    translate([-base_width/2+base_rad,base_depth-base_rad]) cylinder(h=base_thickness,r=base_rad);
    translate([ base_width/2-base_rad,base_depth-base_rad]) cylinder(h=base_thickness,r=base_rad);
  }
}

module clippers_top() {
  translate([0,clippers_length])
    difference() {
      translate([-cell_width/2,-3]) cube_r([cell_width,15,clippers_height],base_rad);
      hull() for (i=[0,-15])
        translate([0,i,blade_thickness*sin(45)]) rotate([-45,180,0]) scale(1.05) blade_shape();
    }
}

module clippers_bottom() {
  difference() {
    translate([-cell_width/2,0]) cube_r([cell_width,15,clippers_height],base_rad);
    hull() {
      translate([-clippers_bottom_width/2,3+clippers_bottom_rad,clippers_bottom_rad])
        sphere(clippers_bottom_rad);
      translate([ clippers_bottom_width/2,3+clippers_bottom_rad,clippers_bottom_rad])
        sphere(clippers_bottom_rad);
      translate([-clippers_bottom_width/2,18                   ,clippers_bottom_rad])
        sphere(clippers_bottom_rad);
      translate([ clippers_bottom_width/2,18                   ,clippers_bottom_rad])
        sphere(clippers_bottom_rad);
    }
  }
}

module clippers_mount() {
  union() {
    translate([-cell_width/2,0]) cube_r([cell_width,clippers_length+12,0.175],base_rad);
    clippers_bottom();
    clippers_top();
  }
}


module cube_r(v=[1,1,1],r=0.25) {
  hull() {
    translate([r,r]) cylinder(h=v[2],r=r);
    translate([r,v[1]-r]) cylinder(h=v[2],r=r);
    translate([v[0]-r,r]) cylinder(h=v[2],r=r);
    translate([v[0]-r,v[1]-r]) cylinder(h=v[2],r=r);
  }
}


union() {
  base();
  for (i=[-1:1:1]) for(j=[0:2]) {
    translate([i*cell_width+cell_width/2,j*base_depth/3+base_depth/3/4]) blade_stand();
  }
  translate([-base_width/2+cell_width/2,2*base_depth/3+base_depth/3/4*2]) blade_stand();
  translate([-base_width/2+cell_width/2,0]) clippers_mount();
}

// Test pieces
*blade_profile();
*union() {
  //translate([60,0])
  blade_stand();
  clippers_mount();
}
