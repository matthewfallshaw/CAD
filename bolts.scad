include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/metric_screws.scad>
use <BOSL/shapes.scad>
use <BOSLext/shapes.scad>

$fn=100;

l=30;
s=3;
shank=l-8;

xdistribute(20) {
  dcyl(h=10,d=5,oh_ang=55,circum=true,lay_flat=true);
  dcyl(h=100,d=7.88,oh_ang=55,circum=true,lay_flat=true);
  dcyl(h=100,d=7.88,oh_ang=55,circum=true,lay_flat=true);
}
*cut_screw();

module cut_screw() {
  difference() {
    zmove(s*(1-cos(55))) xrot(-90) metric_bolt(size=s,l=l,shank=shank);
    downcube([get_metric_bolt_head_size(s),l*2,get_metric_bolt_head_size(s)]);
  }
}
