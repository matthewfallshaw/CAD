use <archimedean_spiral.scad>

layer=0.175;
wall=floor(2/layer)*layer;
cant=9;
loop_id=30;
loops=3;
loops_r=1.1;
c_width=19;
c_length=46;  // 46, 69

$fn=100;

union() {
  cube([c_length+cant,c_width,wall]);
  translate([c_length+cant+loop_id,0]) ring();
  translate([c_length+cant-4,c_width-7]) rotate(30) cube([15,8,wall]);
}

module ring() {
  linear_extrude(wall) rotate(180)
    difference() {
      archimedean_spiral(spirals=loops,        thickness=8,rmax=loop_id);
      archimedean_spiral(spirals=loops-loops_r,thickness=8,rmax=loop_id/loops*(loops-loops_r));
    }
}
