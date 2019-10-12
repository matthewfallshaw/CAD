/* Libraries */
use <mirror_copy.scad>

/* Parameters */
command_sticker_length=72;
command_sticker_width=19;
piece_ID=34.5;
wall=2;
angle=15;
hook_length=30;
hook_base=5;
weld=5;
scribe_depth=0.35;
scribe_width=0.35;
support_grid=5;

/* Config */
$fn=100;
sn=0.5; // small num to ensure intersection
testing=false;

/* Model */
difference() {
  union() {
    base(max(command_sticker_width*2,piece_ID+2*weld),command_sticker_length);
    // hollow hook
    difference() {
      hook(piece_ID,hook_length,hook_base);
      hook(piece_ID*0.913,hook_length,hook_base);
    }
    internal_hook_support(piece_ID,hook_length,hook_base);
    weld(piece_ID,weld);
  }
  if (testing) {
    translate([0,-command_sticker_length/2+$t*(command_sticker_length/2+hook_length*1.75)]) cube([100,20,100],center=true);
  }
}

/* Modules */
module base(width,length) {
  difference() {
    translate([0,0,-wall/2]) cube([width,length,wall],center=true);
    sticker_scribe();
  }
}

module sticker_scribe() {
  mirror_copy([1,0,0])
    translate([0,-command_sticker_length/2,-(wall+scribe_depth)])
      difference() {
        translate([-scribe_width/2,-scribe_width])
          cube([command_sticker_width+scribe_width*2,command_sticker_length+scribe_width*2,scribe_depth*2]);
        translate([scribe_width/2,0,-scribe_depth])
          cube([command_sticker_width-scribe_width/2,command_sticker_length,scribe_depth*4]);
      }
}

module hook(dia=piece_ID,length=hook_length,base=hook_base) {
  let (rad=dia/2,true_rad=piece_ID/2) {
    union() {
      linear_extrude(hook_base) mount_xsection(dia);
      translate([0,true_rad,hook_base]) {
        rotate([90,0,-90])
          rotate_extrude(angle=90-angle)
            translate([true_rad,0,0])
              mount_xsection(dia);
        rotate([-(90-angle),0,0])
          translate([0,-true_rad,-sn]) {
            cylinder(length+sn,d=dia);
            translate([0,0,length]) sphere(d=dia);
          }
      }
    }
  }
}

module weld(dia=piece_ID,width=weld) {
  difference() {
    rotate_extrude(angle=[0,0,360]) translate([dia/2,0])
      polygon(points=[[-sn,-sn],[width,-sn],[width,0],[0,width],[-sn,width]]);
    rotate_extrude(angle=[0,0,360]) translate([dia/2+width,width]) circle(d=10);
  }
}

module internal_hook_support(dia,length,base) {
  let (rad=dia/2,true_rad=piece_ID/2) {
    intersection() {
      hook(dia,length,base);
      // grid
      for(i=[-ceil(dia/2/support_grid+1)*support_grid:support_grid:ceil(dia/2/support_grid+1)*support_grid]) {
          rotate([-(90-angle),0,0])
            translate([0,-true_rad,-sn]) {
              translate([0,i]) internal_hook_support_grid_plane(dia,length,base);
              rotate([0,0,90]) translate([0,i]) internal_hook_support_grid_plane(dia,length,base);
            }
      }
    }
  }
}

module internal_hook_support_grid_plane(dia,length,base) {
  translate([-dia,0,-dia]) cube([dia*2,0.7,length+dia*2]);
}

module mount_xsection(dia=piece_ID) {
  circle(d=dia);
}
