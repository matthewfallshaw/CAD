include <stdlib.scad>
include <BOSL2/metric_screws.scad>

$fn=64;

d=10;
cl=0.2;

render()
// back_half()
cover();

module cover() {
  difference() {
    base();

    // cyl(d=2.6,l=0.42,anchor=BOTTOM);
    // up(0.4) cyl(d1=2.6,d2=4.1,l=3.75,anchor=BOTTOM);
    // up(0.4+3.75-0.01) cyl(d1=4.1,d2=6,l=1.27,anchor=BOTTOM);
    difference() {
      threaded_rod(d=d+cl,l=10,pitch=1,anchor=BOTTOM);

      zrot(360/28) cyl(d=5.6,h=3,chamfer2=0.25,anchor=BOTTOM,$fn=7);
    }
    up(0.4) cyl(d1=2.6,d2=4.1,l=2.8,anchor=BOTTOM);
  }
}

module base() {
  translate([-20.05,-10,1.41])
  import("../_hardware/bear_extruder_x_axis_mk3s/filament_sensor_cover.stl");
}
