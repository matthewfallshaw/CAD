include <stdlib.scad>

$fn=128;

lh=0.2;
lw=0.45;
lw1=0.42;

clearance=0.3;

tid=93;
tod=tid+ceil((99.35-tid+clearance)/lw1)*lw1;
od=101.05;
th_old=6.3;
filr_old=2.8;  // fillet radius
th=6;
rad=3;
rnd=2.5;

light_guard_th=2*lh;

short=0.4;
ang=atan((od-tod)/2/(th-rnd));
rshort=short*tan(ang);

// back_half(s=2*od)
difference() {
  union() {
    // light guard
    down(light_guard_th) tube(h=light_guard_th,id=tid,od=tod+clearance+(2*lw1));
    // chamfer wall
    *down(light_guard_th) tube(h=th_old-filr_old+lh,id1=tod+clearance,od1=tod+clearance+2*(2*lw1),
                                           id2=od+clearance, od2=od+clearance +2*(2*lw));
    // clip
    *up(th_old-filr_old-lh) top_half() difference() {
      rotate_extrude() right((od+clearance)/2-filr_old) circle(r=filr_old+2*lw);

      rotate_extrude() right((od+clearance)/2-filr_old) circle(r=filr_old);
      cyl(h=100,d=od-1);
    }

    // chamfer wall
    down(light_guard_th)
      tube(h=th-rnd-short+light_guard_th,
           id1=tod       +clearance, od1=tod       +clearance +2*(2*lw1),
           id2= od-rshort+clearance, od2= od-rshort+clearance +2*(2*lw ));

    // clip
    up(th-rnd) top_half(z=-short) rotate_extrude()
      difference() {
        right((od+clearance)/2-rad) circle(r=rad+2*lw);

        right((od+clearance)/2-rad) circle(r=rad);
        fwd(50) square([(od-1)/2,100]);
      }
  }
  translate([od/2,0,1.2]) cuboid([od,8.75,th_old],anchor=BOTTOM);
}
