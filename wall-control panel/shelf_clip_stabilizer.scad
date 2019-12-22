ang=30;
width=3.5;
thickness=1.5;

flat_length=8;
bent_length=8;

difference() {
  peg();
  scale([1,2,1]) translate([-thickness*sin(ang/2),-1,thickness]) {
    peg();
    translate([0,0,-0.3]) cube([2.2,width,5]);
  }

}

module peg() {
  union() {
    translate([-1,0,0]) cube([flat_length,width,thickness]);
    rotate(-ang,[0,1,0]) translate([-bent_length,0,0]) cube([bent_length+2,width,thickness]);
  }
}
