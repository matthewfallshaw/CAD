length=20;
width=12;
wall=2;
hole=3.5;

$fn=100;

difference() {
  linear_extrude(width) x_sec();
  for (r=[0,90])
    rotate(r) translate([3*length/4,0,width/2]) rotate([90,0,0]) cylinder(wall*3,d=hole,center=true);
}

module x_sec() {
  difference() {
    union() {
      square([length/2+wall,length/2+wall]);
      translate([length/2,0]) square([length/2,wall]);
      translate([0,length/2]) square([wall,length/2]);
    }
    translate([length/2+wall,length/2+wall]) circle(length/2);
  }
}
