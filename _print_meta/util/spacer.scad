layer_height=0.2;
line_width=0.4;

length=10;
od=8;
id=4;

$fn=200;

difference() {
  cylinder(h=length, d=od);
  translate([0,0,length/2]) cylinder(h=length+2,d=id);
}
