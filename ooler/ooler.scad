include <stdlib.scad>
include <hanging_hole.scad>

// $fn=0;
// $fa=12;
// $fs=2;

// $fn=16;
// $fn=32;
// MODE="hose_controller_adapter";
// MODE="hose_pipes_adapter";
// MODE="pipe_o_ring";
// MODE="hose_o_ring";
/* [MODE] */
// part to render
MODE="assy"; // [ assy, hose_controller_adapter, hose_pipes_adapter, pipe_o_ring, hose_o_ring ]

/* [Parameters] */
// resolution (circle fragment count)
$fn=64; // [ 16, 32, 64, 128, 256 ]

// slop to aid fits & tolerances
$slop=0.3;

/* [Hidden] */
// pipe section lengths, from the top
ls=[6,0.5,9.5,1.5,1.5];
// pipe section diameters, from the bottom
ds=[9,11.5,11,9,11];
// pipe through hole diameter
through_d=5.5;
// distance between pipes
w=20;
l=sum(ls);

// DEBUG
// render()
// back_half()
// DEBUG
if(MODE=="hose_controller_adapter") hose_controller_adapter();
else if(MODE=="hose_pipes_adapter") hose_pipes_adapter();
else if(MODE=="hose_o_ring") hose_o_ring();
else if(MODE=="pipe_o_ring") pipe_o_ring();
else union() {
  hose_controller_adapter();
  color("DimGray",0.5) up(28.2) hose_o_ring();

  right(50) {
    hose_pipes_adapter();
    color("DimGray",0.5) up(28.2) hose_o_ring();
    color("DimGray",0.5) down(l-2.4) right(w/2) xcopies(spacing=w) pipe_o_ring();
  }
}
// DEBUG
// %render() down(l+2) xrot(180) hose_pipes_adapter();
// DEBUG

module hose_pipes_adapter(anchor=CENTER) {
  render()
  union() {
    right((w)/2) ooler_pipes(orient=DOWN, anchor=BOTTOM);
    joiner(id1=through_d, od1=9, id2=through_d, od2=21);
    up(10) hose_connector();
  }
}

module hose_controller_adapter() {
  render()
  union() {
    ooler_drain();
    joiner(id1=through_d, od1=14.82, id2=through_d, od2=21);
    up(10) hose_connector();
  }
}

module joiner(id1, od1, id2, od2) {
  difference() {
    cyl(d1=od1, d2=od2, h=10, chamfer2=0.37, anchor=BOTTOM);

    cyl(d1=id1, d2=id2, h=10, anchor=BOTTOM);
  }
}

module ooler_drain() {
  render()
  top_half(z=-l+1.5)
  difference() {
    union() {
      // chilipad is w=21; ooler is w=20
      left_half(x=w/2) original();
      left(1) right_half(x=w/2) original();
      right(w/2) xcopies(spacing=w)
        difference() {
          cyl(d=16.7, l=l-1.5, chamfer2=1, anchor=TOP);

          down(2) {
            hanging_hole(z=0, ir=through_d/2) circle(d=max(ds)+0.5);
            cyl(d=max(ds)+0.5, l=BIGNUM, anchor=TOP);
          }
        }

      // clip screwdriver ledge - for releasing retaining clip
      down(l+2) right(w/2) xflip_copy() right(w/2+max(ds)/2-1) difference() {
        up(3) cuboid([6,5.5,3-$slop], chamfer=(3-$slop)/2, edges=BOTTOM+LEFT, anchor=BOTTOM+LEFT);
        // clip screwdriver cut
        translate([4,0,6]) cuboid([1.5,BIGNUM,2]);
      }

    }

      down(l+2) right(w/2) xflip_copy() right(w/2+max(ds)/2-1) {
        ycopies(spacing=5.5) cuboid([BIGNUM,0.5,sum(slice(ls,0,3))], anchor=BOTTOM+LEFT);
      }


  }

  module original() {
    render()
    bottom_half() down(1) move(y=-10)
      import("./ChiliPAD+or+OOLER+Drain+Tool+for+CPC+Quick+Disconnect+DPC+Series+couplings/files/Ooler_Drain_Tool_Original.stl");
  }
}

module hose_connector() {
  render()
  difference() {
    union() {
      top_half() down(10.5)
        import("./Garden_hose_Coupler/Hose_quickcon_01.STL");
      cyl(d1=18, d2=9, l=10, anchor=BOTTOM);
      up(20) difference() {
        cyl(d1=max(ds), d2=15.83, l=0.75, anchor=TOP);

        cyl(d=9.5, l=2);
      }
    }

    cyl(d1=through_d, d2=9, l=10, anchor=BOTTOM);
  }
}

module ooler_pipes( anchor=CENTER, spin=0, orient=UP
                  , anchors=[anchorpt("left_pipe", [-w/2,0,0], UP, 0)] ) {
  attachable(anchor=anchor, spin=spin, orient=orient, size=[w+max(ds),max(ds),l]) {
    render()
    union() {
      xcopies(spacing=w) ooler_pipe();
      down(l/2) difference() {
        union() {
          cuboid([w,9,2.5], anchor=BOTTOM);
          ycopies(spacing=9-1) cuboid([w,1,3.5], anchor=BOTTOM);
        }

        xcopies(spacing=w) cyl(d=through_d, l=BIGNUM);
      }
    }
  children();
  }
}

module ooler_pipe(anchor=CENTER, spin=0, orient=UP) {
  attachable(anchor=anchor, spin=spin, orient=orient, d=max(ds), l=l) {
    render()
    down(l/2)
    difference() {
      cyl(d=ds[0], l=ls[0], anchor=BOTTOM)
        attach(TOP, BOTTOM) cyl(d=ds[1], l=ls[1])
          attach(TOP, BOTTOM) cyl(d=ds[2], l=ls[2], chamfer2=1, chamfang=60)
            attach(TOP, BOTTOM) cyl(d=ds[3], l=ls[3])
              attach(TOP, BOTTOM) cyl(d=ds[4], l=ls[4], chamfer2=0.5);

      cyl(d=through_d, l=BIGNUM);
    }
    children();
  }
}

module hose_o_ring() {
  o_ring(d=14,d2=3.4);
}

module pipe_o_ring() {
  o_ring(d=10,d2=2);
}

module o_ring(d, d2) {
  assert(d);
  assert(d2);

  color("DimGray",0.95)
  rotate_extrude() right(d/2) oval(d=d2, $fn=8, realign=true);
}
