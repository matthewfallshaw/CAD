include <stdlib.scad>

lw=0.45;
lh=0.2;

$fn=128;

module bucket() {
  zrot(89) translate([-3,-4]) import("bucket.stl");
}

module half(side) {
  difference() {
    children();

    cuboid([500,500,500],anchor=side);
  }
}
module left_half() {
  half(LEFT) children();
}
module right_half() {
  half(RIGHT) children();
}

// left_half()
hooks();

module hooks() {
  d=350+24;
  union() {
    xrot(15) up(5) fwd((d-24)/2) difference() {
      cyl(h=15,d=d,chamfer2=6);

      // inside
      cyl(h=15.01,d=d-35,chamfer2=-6);
      // pie
      down(10) let(ang=30) zrot(90+ang/2) pie_slice(h=20,ang=360-ang,r=d);
      difference() {
        // rim clearance
        up(2) rotate_extrude() {
          right((d-17)/2) hull() {
            circle(d=4);
            fwd(10) square(12,center=true);
          }
        }

        // hook location
        let(sd=30) down(3.5) back(d/2-sd/2-9.5) difference() {
          spheroid(d=sd);

          back(sd/2-5/2) {
            scale([7/5,1,1]) {
              spheroid(d=5);
              cyl(h=10,d=5,anchor=TOP);
            }
            cuboid([3,5,10],anchor=FRONT+TOP);
            back(5/2) cyl(h=5,d=3,orient=BACK);
          }
        }
      }
    }
    let(r=(d-17)/2) fwd(r+5) arc_of(r=r, n=2, sa=90-10, ea=90+10) zrot(-90) {
      basew=quant(16,lw);
      based=quant(28,lw);
      baseh=quant(0.8,0.2);
      off=quant(4,0.2);
      dia=quant(8,lw);
      rad=7;

      xrot(90) union() {
        scale([1,0.75,1]) cyl(h=off,d=dia,anchor=BOTTOM);
        translate([0,rad,off]) rotate([90,0,-90]) rotate_extrude(angle=60) translate([rad,0]) scale([0.75,1]) circle(d=dia);
        translate([0,rad,off]) rotate([-60,0,0]) translate([0,-rad]) scale([1,0.75,0.3]) sphere(d=dia);
      }
    }
  }
}
