height=68;
out_width=120;
int_width=90;
x_width=15;
x_height=13.7;
mount_pin_dia=6;
mount_pin_fillet_dia=1;

column_z=height-10-x_width;
bend_x=10+x_width;
beam_x=(out_width-2*x_width-2*10)/2;

$fn=128;

half();
translate([(bend_x+beam_x)*2,0]) mirror([1,0,0]) half();

module half() {
  union() {
    column();
    bend();
    beam();
  }
}

module x_section(rad=2,width=x_width,height=x_height) {
  hull() {
    translate([rad,rad])              circle(rad);
    translate([rad,height-rad])       circle(rad);
    translate([width-rad,rad])        circle(rad);
    translate([width-rad,height-rad]) circle(rad);
  }
}

heights=[ for (z=[0:$fs:beam_x]) circ_y(z) ];

module loft(length,sections,$fs=$fs) {
  for (i = [0:len(sections)-2]) {
    hull(){
      translate([0,0,i*length/len(sections)])     linear_extrude($fs) x_section(width=x_height,height=x_width+sections[i]);
      translate([0,0,(i+1)*length/len(sections)]) linear_extrude($fs) x_section(width=x_height,height=x_width+sections[i+1]);
    }
  }
}

module column() {
  difference() {
    union() {
      difference() {
        linear_extrude(column_z) x_section();
        hole();
      }
      translate([0,x_height/2,mount_pin_dia])
        rotate([0,90,0])
          rotate_extrude()
            hull() {
              translate([mount_pin_dia/2+mount_pin_fillet_dia/2,mount_pin_fillet_dia/2]) circle(d=mount_pin_fillet_dia);
              translate([mount_pin_dia/2+mount_pin_fillet_dia/2,x_width-mount_pin_fillet_dia/2]) circle(d=mount_pin_fillet_dia);
            }
    }
    bottom_rad();
  }
}

module bend() {
  translate([bend_x,0,column_z]) rotate([90,0,180])
    rotate_extrude(angle=90) translate([10,0]) x_section();
}

module beam() {
  translate([bend_x,0,column_z+bend_x]) mirror([0,0,1]) rotate([90,0,90])
    loft(length=beam_x,sections=heights);
}

module hole() {
  hole_dia=mount_pin_dia+mount_pin_fillet_dia;
  translate([-0.1,x_height/2,mount_pin_dia]) rotate([0,90,0]) {
    linear_extrude(out_width+1) circle(d=hole_dia);
  }
}

module bottom_rad() {
  difference() {
    translate([-1,-1,-1]) cube([x_width+2,x_height+2,x_height/2+1]);
    translate([-1,x_height/2,x_height/2])
      rotate(90,[0,1,0])
        cylinder(h=x_width+2,d=x_height);
  }
}

function circ_y(x) = sqrt(1540081/64-(x-35)*(x-35))-1209/8;
