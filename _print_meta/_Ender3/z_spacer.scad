lh=0.2;
lw=0.4;

v_space=3.6;
h_space=4;
h_gap=3.3;
column_w=20.2;
wall=1.5;

rotate([90,0,0]) union() {
  linear_extrude(v_space)
    polygon([
        [0,0],
        [0,h_space],
        [-wall,h_space],
        [-wall,-wall],
        [column_w+h_space,-wall],
        [column_w+h_space,10],
        [column_w,10],
        [column_w,0],
    ]);
  translate([column_w,-wall,v_space]) cube([h_space,2,ceil(h_gap/lh)*lh]);
  translate([column_w,-wall,v_space+ceil(h_gap/lh)*lh]) cube([h_space,wall+8,wall]);
}
