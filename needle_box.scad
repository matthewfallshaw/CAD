animate=false;  // [false,true]

layer_height=0.2;
line_width=0.4;

clearance=layer_height*3;

pin_dia=0.4;
pin_handle_dia=1.5;

tube_id=pin_dia+2*clearance;
tube_top_id=pin_handle_dia+2*clearance;
tube_wall=4*line_width;
tube_length=76;

tube_od=tube_id+2*tube_wall;
tube_top_od=tube_top_id+2*tube_wall;
tube_top_length=5;
tube_top_transition=2/5;

total_length=tube_length+tube_top_length;

$fn=128;
e=2.71828;

main();

module main() {
  difference() {
    translate([-total_length/2,0]) difference() {
      translate([0,0,tube_od/2]) rotate([0,90,0]) union() {
        difference() {
          shape(tube_od,tube_top_od,tube_length);
          shape(tube_id,tube_top_id,tube_length,bump=tube_wall);
        }
        interference_cylinder();
      }
      side_cuts();
    }
    // Animation: section
    if (animate) {
      $fn=28;
      t=(1/(1+pow(e,-(($t-0.6)*6)))-0.026597)/0.89;
      length=total_length+tube_top_od*2+0.1;
      translate([length/2-tube_top_od-t*length,-tube_top_od,-tube_top_od])
        cube([tube_top_od*2,tube_top_od*3,tube_top_od*3]);
    }
  }
}

module shape(od_shaft, od_top, length, bump=0) {
  union() {
    translate([0,0,od_shaft/2+bump]) sphere(d=od_shaft);
    translate([0,0,od_shaft/2+bump]) cylinder(h=length-od_shaft/2,d=od_shaft);
    hull() {
      translate([0,0,length]) cylinder(h=tube_top_length,d=od_shaft);
      translate([0,0,length+tube_top_length*tube_top_transition])
        cylinder(h=tube_top_length*(1-tube_top_transition)+bump,d=od_top);
    }
  }
}

module interference_cylinder() {
  translate([-tube_top_id/2,0,tube_length]) cylinder(h=4,r=line_width/2);
  translate([-tube_top_id/2,0,tube_length+4]) sphere(r=line_width/2);
}

module side_cuts() {
  translate([0,0, -tube_od]) cube([tube_length*3,tube_od*3,tube_od*2], center=true);
  translate([0,0,2*tube_od]) cube([tube_length*3,tube_od*3,tube_od*2], center=true);
}
