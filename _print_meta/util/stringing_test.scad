line_width=0.4;
layer_height=0.2;

group_size=20;   // layers per group
group_count=6;  // layer groups

base_layer_count=5;
column_line_circles=6;  // concentric circles per column

column_height_layers=group_size*group_count;
column_height=column_height_layers*layer_height;
column_dia=column_line_circles*line_width*2;
column_distance=column_dia*4;

base_width=column_dia*3;
base_length=column_distance+3*column_dia;
base_thickness=base_layer_count*layer_height;

report=[
  ["column height"         , column_height],
  ["inter-group height"    , (group_size-1)*layer_height],
  ["column dia"            , column_dia],
  ["column distance" , column_distance],
  ["base width"            , base_width],
  ["base length"           , base_length],
  ["base thickness"        , base_thickness]
];
for (i=[0:len(report)-1])
  echo(str("  ",report[i][0],": ",report[i][1],"mm"));

$fn=128;

union() {
  base();
  translate([0,0,base_thickness]) {
    for (i=[-1,1]) translate([i*column_distance/2,0]) column();
  }
}

module base() {
  linear_extrude(base_thickness) hull() for (i=[-1,1]) for (j=[-1,1])
    translate([i*base_length/2-i*column_dia/2,j*base_width/2-j*column_dia/2]) circle(d=column_dia);
}

module column() {
  group_height=group_size*layer_height;
  union() {
    cylinder(h=column_height, d=column_dia);
    for (z=[group_height:group_height:column_height-layer_height])
      translate([0,0,z]) cylinder(h=layer_height, d=column_dia+line_width);
  }
}
