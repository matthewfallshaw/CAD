use <chamfer.scad>

line_width = 0.35;
wall_thickness = 3*line_width;
width = 100;
length = 30;
height = 15;

cut_buffer = 3;
chamfer = 1;

difference(){
  difference(){
    base();
    offset_cut();
  };
  open_end_cut();
};

module base() {
  cube([length, width, height]);
}

module offset_cut() {
  translate([wall_thickness, wall_thickness, wall_thickness])
    chamferCube(length - 2 * wall_thickness,
                width - 2 * wall_thickness,
                height - wall_thickness + chamfer,
                chamfer);
}

module open_end_cut() {
  translate([wall_thickness + cut_buffer,
             -(wall_thickness + chamfer)/2,
             wall_thickness + cut_buffer])
    chamferCube(length - 2 * wall_thickness - 2 * cut_buffer,
                width - 2 * wall_thickness - 2 * cut_buffer,
                height - wall_thickness - cut_buffer + chamfer,
                chamfer);
}
