lh=0.13125;
lw=0.35;

$fn=128;

//clone_mirror([0,1,0])
union() {
  difference() {
    polyhedron(
      points=[
        [0,0,0],     // 0
        [-85,0,0],   // 1
        [-75,5,0],
        [0,3,0],
        [0,0,2],     // 4
        [-73,0,2]],
      faces=[
        [0,1,2,3],
        [0,1,5,4],
        [1,2,5],
        [2,3,4,5],
        [0,3,4]]);
    hull() {
      translate([0,0,3]) sphere(2);
      translate([0,0,5]) sphere(2);
      translate([-75,0,3]) sphere(2);
      translate([-75,0,5]) sphere(2);
    }
  }
  linear_extrude(1.8) hull() {
    translate([1,0]) circle(2);
    translate([1,13]) circle(2);
    translate([1.5,15]) circle(2);
    translate([4,0]) circle(2);
  }
  linear_extrude(1.8) hull() {
    translate([1,13]) circle(2);
    translate([-3,16]) circle(1);
    translate([0,20]) circle(1);
    translate([1.5,15]) circle(2);
  }
}

module clone_mirror(v) {
  union() {
    children();
    mirror(v) children();
  }
}
