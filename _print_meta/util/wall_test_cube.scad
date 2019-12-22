line_thickness=0.39;
layer_thickness=0.2;
cube_size=30;
layers=8;

cube_height=layer_thickness*layers;

difference() {
  cube([cube_size,cube_size,cube_height]);
  translate([line_thickness*2,line_thickness,-1])
      cube([cube_size-line_thickness*6,cube_size-line_thickness*4,cube_height+2]);
}
