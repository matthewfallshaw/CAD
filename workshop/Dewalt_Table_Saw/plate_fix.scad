include <stdlib.scad>
include <BOSL2/metric_screws.scad>
include <BOSL2/joiners.scad>

// $fn=64;

BIGNUM=400;

d=95;
l=345;
th=11.3;

screw_d=4;
screw_head_d=10;

snap_posns=[32,5,-28];
snap_w=15;

// original();
// down(1)
// plate();

// MODE="right";
// MODE="left";
MODE="_build";

if(MODE=="right") rght();
else if(MODE=="left") lft();
else if(MODE=="_build")
  rght()
  left(60) lft();
else plate();

module rght() {
  attachable(size=[l/2+25,d,th]) {
    difference() {
      union() {
        right_half() plate();
        xflip() move_copies([for(i=[snap_posns[0],snap_posns[2]]) [0,i,-th/2]])
          rabbit_clip(type="pin",length=25,width=snap_w,snap=2,thickness=1.2,depth=8
                     ,compression=0.2,lock=true,orient=RIGHT,spin=90);
      }

      translate([0,snap_posns[1],-th/2])
        rabbit_clip(type="socket",length=25,width=snap_w,snap=2,thickness=1.2,depth=8
                   ,compression=0.2,lock=true,orient=RIGHT,spin=90);
    }

    children();
  }
}

module lft() {
  difference() {
    union() {
      left_half() plate();
      translate([0,snap_posns[1],-th/2])
        rabbit_clip(type="pin",length=25,width=snap_w,snap=2,thickness=1.2,depth=8
                   ,compression=0.2,lock=true,orient=RIGHT,spin=90);
    }

    xflip() move_copies([for(i=[snap_posns[0],snap_posns[2]]) [0,i,-th/2]])
      rabbit_clip(type="socket",length=25,width=snap_w,snap=2,thickness=1.2,depth=8
                 ,compression=0.2,lock=true,orient=RIGHT,spin=90);
  }
}


module plate(anchor=CENTER,orient=UP,spin=0) {
  attachable(size=[l,d,th],anchor=anchor,spin=spin,orient=orient) {
    difference() {
      union() {
        up(0.001)
          xcopies(spacing=l-d) cyl(d=d,l=th,chamfer=0.4,anchor=TOP);
        cuboid([l-d,d,th-0.001],chamfer=0.4,edges="X",anchor=TOP);
        left((l-d)/2) intersection() {
          down(th) cyl(d=d+2*3,l=4,anchor=BOTTOM);
          union() for(y=[11,72]) fwd(d/2-y) cuboid([2*d,6.2,BIGNUM]);
        }
      }

      for(p=[[-154.5,27.0],[122, 39.5]
            ,[-106, -39.5],[122,-39.5]]) translate([p.x,p.y,-8]) cskscrew();
      translate([105,22]) finger_hold();
      // translate([135,-17]) cuboid([BIGNUM,0.1,BIGNUM],anchor=RIGHT);
      translate([0,-d/2,-th]) back_half(y=2*0.45) cuboid([190,24,13],chamfer=13/2);
    }
    children();
  }

  module cskscrew() {
    union() {
      cyl(d=screw_d*1.2,l=BIGNUM,anchor=TOP);
      down(0.01) cyl(d=screw_head_d,l=BIGNUM,anchor=BOTTOM);
    }
  }

  module finger_hold() {
    union() {
      left(15/2) spheroid(d=15);
      difference() {
        cuboid([15,15,15],rounding=15/2,edges=[BOTTOM+FRONT,BOTTOM+BACK]);

        yrot(35) cuboid(BIGNUM,anchor=BOTTOM);
      }
    }
  }
}

module original() {
  #scale([0.98,0.99,1]) yflip() translate([40.5,-53,1+10])
    import("./table_saw_plate.stl");
}

module test_pair(length, width, snap, thickness, compression, lock=false, splinesteps)
{
  depth = 5;
  extra_depth = 10; //0.4;
  cuboid([max(width+5,12),12, depth], chamfer=.5, edges=[FRONT,"Y"], anchor=BOTTOM)
      attach(BACK)
        rabbit_clip(type="pin",length=length, width=width,snap=snap,thickness=thickness,depth=depth,
                    compression=compression,lock=lock);
  translate([width+13,0,-3/2])
  diff("remove")
      cuboid([width+8,max(12,length+2),depth+3], chamfer=.5, edges=[FRONT,"Y"], anchor=BOTTOM)
          attach(BACK)
            rabbit_clip(type="socket",length=length, width=width,snap=snap,thickness=thickness,depth=depth+extra_depth,
                        lock=lock,compression=0,$tags="remove",splinesteps=splinesteps);
}
// test_pair(length=8, width=7, snap=0.75, thickness=0.8, compression=0.2, lock=true, splinesteps=20); // With lock, very firm and irreversible
