include <stdlib.scad>
include <BOSL2/hull.scad>
include <BOSL2/rounding.scad>
include <BOSL2/metric_screws.scad>

$fn=64;

c_lh   = 0.25;
c_lw   = 0.45;
c_lwp  = 0.5;   // perimeters
c_lwep = 0.45;  // external perimeters

BIGNUM=100;
plunge_d=60;
wall=quant_wall(width=2);
cl=0.5;

// [id,od]
bosch_end=[45,undef];
bosch_root=[40.5,undef];
bosch_exh=[undef,35.5];
bucket=[undef,50.3];
bucket_od=50.3;
pvc=[56-2*2.3,56];
black=[59,59+2*2.2];
dewalt=[undef,49];
flex=[62.3-2*wall,62.3];

// MODE="blackpm_to_bosch_end";
// MODE="desk_bracket_left";
// MODE="desk_bracket_right";
MODE="orbital_to_bosch_end";
// MODE="assy";

// back_half()
if(MODE=="bucket_to_bosch_root") bucket_to_bosch_root();
else if(MODE=="bucket_to_bosch_end") xrot(180) bucket_to_bosch_end();
else if(MODE=="bucket_to_black") bucket_to_black();
else if(MODE=="blackf_to_blackm") blackf_to_blackm();
else if(MODE=="blackm_to_blackm") blackm_to_blackm();
else if(MODE=="black_to_dewalt") black_to_dewalt();
else if(MODE=="blackpm_to_bosch_end") black_to_bosch_end(fit="male");
else if(MODE=="blackm_to_bosch_end") blackm_to_bosch_end();
else if(MODE=="blackf_to_bosch_end") blackf_to_bosch_end();
else if(MODE=="orbital_to_bosch_end") orbital_to_bosch_end();
else if(MODE=="pvc_to_dewalt") pvc_to_dewalt();
else if(MODE=="pvc_to_blackm") pvc_to_blackm();
else if(MODE=="pvc_to_bosch_end") pvc_to_bosch_end();
else if(MODE=="flex_to_dewalt") flex_to_dewalt();
else if(MODE=="bosch_exh_to_bosch_end") xrot(180) bosch_exh_to_bosch_end();
else if(MODE=="bracket") bracket();
else if(MODE=="corner_bracket") corner_bracket();
else if(MODE=="desk_bracket_left") desk_bracket(side="left");
else if(MODE=="desk_bracket_right") desk_bracket(side="right");
else if(MODE=="assy") {
  union() {
    *#translate([-12,-40,-5]) import("../../../../Downloads/dust_collection_connection.stl");

    yrot(180) black_to_bosch_end(fit="male");
    translate([0,0,10]) zrot(-90) {
      desk_bracket(side="left");
      desk_bracket(side="right");
    }
  }
}
else assert(false,"Unrecognised MODE.");

module desk_bracket(side) {
  od=black[1]+2*wall+2*4;

  if(side=="left")       left_half(x=-$slop) shape();
  else if(side=="right") right_half(x=$slop) shape();

  module shape() {
    difference() {
      union() {
        tube(id1=bosch_end[0]+2*wall+cl,id2=black[1],od=od,l=20,anchor=CENTER);
        // M8 mount bolt housing
        fwd(od/2+6) cuboid([25,19.5,20],anchor=LEFT+FRONT);
        // side join brackets
        ycopies(spacing=od) cuboid([10,12,20]);
      }

      join(od1=bosch_end[0]+2*wall+cl,od2=black[1],wall=12,l=20.01,anchor=CENTER);
      down(10) zflip_copy() cyl(d1=bosch_end[0]+2*wall+cl,d2=50+cl,l=1,anchor=TOP);
      // offset bolt bracket hole
      translate([25/2,-38+3,0]) {
        metric_bolt(size=8,l=50,pitch=0,headtype="hex",orient=BACK);
        cyl(d=get_metric_bolt_head_size(8),l=50,circum=true,orient=BACK,anchor=BOTTOM,$fn=6);
      }
      // clamp bolts
      for(i=[1,-1]) translate([-5,i*(od/2+3.2)]) zcopies(spacing=12) metric_bolt(size=3,l=BIGNUM,pitch=0,orient=LEFT);
    }
  }
}

module bracket() {
  difference() {
    union() {
      cuboid([100,40,2],anchor=TOP+BACK);
      down(0.01) cuboid([46,20,40],chamfer=-2,edges=BOTTOM,except_edges=BACK,anchor=BOTTOM+BACK);
      up(56) arced_slot(h=20,d=55+2*c_lw,sd=2*wall,sa=45,ea=315,spin=90,orient=FRONT,anchor=CENTER+BOTTOM);
    }

    move([0,0.01,56]) cyl(d=55-wall,h=20+0.02,orient=FRONT,anchor=CENTER+BOTTOM);
  }
}

module corner_bracket() {
  difference() {
    union() {
      cuboid([100,40,2],anchor=TOP);
      fwd(5) {
        down(0.01) cuboid([46,30,40],chamfer=-2,edges=BOTTOM,except_edges=FRONT,anchor=BOTTOM);
        up(56) arced_slot(h=30,d=55,sd=2*wall,sa=45,ea=315,spin=90,orient=FRONT,anchor=CENTER);
      }
      cuboid([2,40,50],anchor=LEFT+TOP);
    }

    translate([0,-5,56]) cyl(h=30+0.01,d=55-wall,orient=FRONT,anchor=CENTER);
    translate([2,0,-2]) yrot(45) cuboid([50,40.01,50],anchor=LEFT+BOTTOM);
  }
}

module bucket_to_bosch_root() {
  bosch_root()
    attach(TOP,BOTTOM)
      join(id1=bosch_root[0]+cl,od2=bucket[1]+cl)
        attach(TOP,BOTTOM)
          bucket_adapter();
}

module bucket_to_bosch_end() {
  bosch_end()
    attach(TOP,BOTTOM)
      join(id1=bosch_end[0],od2=bucket[1]+cl)
        attach(TOP,BOTTOM)
          bucket_adapter();
}

module bucket_to_black() {
  black_female()
    attach(TOP,BOTTOM)
      join(id1=black[1]+cl,od2=bucket[1]+cl)
        attach(TOP,BOTTOM)
          bucket_adapter();
}

module blackf_to_blackm() {
  black_male()
    attach(BOTTOM,TOP)
      join(id1=black[1]+cl,od2=black[0]-cl)
        attach(BOTTOM,TOP)
          black_female();
}

module blackm_to_blackm() {
  black_male()
    attach(BOTTOM,TOP)
      join(od1=black[0]-cl,od2=black[0]-cl)
        attach(BOTTOM,BOTTOM)
          black_male();
}

module black_to_dewalt() {
  dewalt()
    attach(BOTTOM,TOP)
      join(id1=black[1]+cl,od2=dewalt[1])
        attach(BOTTOM,TOP)
          black_female();
}

module black_to_bosch_end(fit) {
  union() {
    bosch_end(orient=DOWN)
      attach(TOP,BOTTOM)
        join(id2=black[0]+(fit=="male"?-0.3:0),od1=bosch_end[0]+2*wall)
          attach(TOP,BOTTOM)
            black_pipe(fit=fit);
    difference() {
      zflip_copy() cyl(d1=bosch_end[0]+2*wall,d2=bosch_end[0]+2*wall+1,l=1,anchor=TOP);

      up(0.01) cyl(d=bosch_end[0]+wall,l=BIGNUM);
    }
  }
}

module blackm_to_bosch_end() {
  union() {
    bosch_end(orient=DOWN)
      attach(TOP,BOTTOM)
        join(od2=black[0]-cl,od1=bosch_end[0]+2*wall)
          attach(TOP,BOTTOM)
            black_male();
    difference() {
      zflip_copy() cyl(d1=bosch_end[0]+2*wall,d2=bosch_end[0]+2*wall+1,l=1,anchor=TOP);

      up(0.01) cyl(d=bosch_end[0]+wall,l=BIGNUM);
    }
  }
}

module blackf_to_bosch_end() {
  union() {
    bosch_end(orient=DOWN)
      attach(TOP,BOTTOM)
        join(id2=black[1]+cl,od1=bosch_end[0]+2*wall)
          attach(TOP,TOP)
            black_female();
    difference() {
      zflip_copy() cyl(d1=bosch_end[0]+2*wall,d2=bosch_end[0]+2*wall+1,l=1,anchor=TOP);

      up(0.01) cyl(d=bosch_end[0]+wall,l=BIGNUM);
    }
  }
}

module orbital_to_bosch_end() {
  bosch_end(orient=DOWN)
    attach(TOP,BOTTOM)
      join(id1=bosch_end[0],id2=27)
        attach(TOP,TOP)
          orbital();
}

module pvc_to_dewalt() {
  dewalt()
    attach(BOTTOM,TOP)
      join(id1=pvc[1]+cl-$slop,od2=dewalt[1])
        attach(BOTTOM,TOP)
          pvc_female();
}

module pvc_to_blackm() {
  black_male()
    attach(BOTTOM,TOP)
      join(id1=pvc[1]+cl-$slop,od2=black[0]-cl)
        attach(BOTTOM,TOP)
          pvc_female();
}

module pvc_to_bosch_end() {
  bosch_end(orient=DOWN)
    attach(TOP,BOTTOM)
      join(id1=bosch_end[0],id2=pvc[1]+cl)
        attach(TOP,BOTTOM)
          pvc_female();
}

module flex_to_dewalt() {
  dewalt()
    attach(BOTTOM,TOP)
      join(id1=flex[0]+cl,od2=dewalt[1])
        attach(BOTTOM,TOP)
          flex_tube_connector();
}

module bosch_exh_to_bosch_end() {
  bosch_end()
    attach(TOP,BOTTOM)
      join(id1=bosch_end[0],od2=bosch_exh[1])
        attach(TOP,BOTTOM)
          bosch_exh();
}

// ----------

module join(id1,id2,od1,od2,l=20,wall=wall,anchor=BOTTOM,spin=0,orient=UP) {
  assert(id1 || od1);
  assert(id2 || od2);

  _id1=id1?id1:od1-2*wall;
  _id2=id2?id2:od2-2*wall;
  _od2=_id2+2*wall;

  id_mid=(_id1+_id2)/2;
  id_mid1=((l/2-1)*id_mid+_id1)/(l/2);
  id_mid2=((l/2-1)*id_mid+_id2)/(l/2);

  echo(log="join",_id1=_id1,_id2=_id2,_od2=_od2,id_mid=id_mid,id_mid1=id_mid1,id_mid2=id_mid2);

  attachable(anchor,spin,orient,r1=_id1/2+wall,r2=_od2/2,l=l) {
    union() {
      down(0.01) tube(id1=_id1,id2=_id2,wall=wall,l=l+0.02,anchor=CENTER);
      tube(id1=id_mid1,id2=id_mid+1-0.01,wall=wall,l=1,anchor=TOP);
      tube(id1=id_mid+1-0.01,id2=id_mid2,wall=wall,l=1,anchor=BOTTOM);
    }
    children();
  }
}

// ----------

module bucket_adapter(anchor=BOTTOM,spin=0,orient=UP) {
  od1=bucket[1]+cl;
  od2=bucket[1]-cl;
  l=plunge_d;

  attachable(anchor,spin,orient,d=max(od1,od2),l=l) {
    tube(od1=od1,od2=od2,wall=wall,l=l,anchor=CENTER);
    children();
  }
}

module bosch_root(anchor=TOP,spin=0,orient=UP) {
  l=35;
  od=bosch_root[0]+cl+2*wall;

  attachable(anchor,spin,orient,d=od,l=l) {
    union() {
      difference() {
        cyl(d=od,l=l);

        cyl(d=bosch_root[0]+cl,l=l+0.01);
        // lock
        down(l/2) intersection() {
          union() {
            up(8+2+5+cl) cuboid([14+cl,BIGNUM,BIGNUM],anchor=BACK+TOP);
            up(8-cl) pie_slice(d=bosch_root[0]+2*2+2*cl,l=5+2*cl,ang=90,spin=255,anchor=BOTTOM);
            up(8+5+cl) pie_slice(d1=bosch_root[0]+2*2+2*cl,d2=bosch_root[0],l=2+cl,ang=90,spin=255,anchor=BOTTOM);
          }
          down(0.01) cyl(d=bosch_root[0]+2*2+2*cl,l=8+5+cl+2,chamfer1=0,chamfer2=2+cl,anchor=BOTTOM);
        }
      }
    }
    children();
  }
}

module bosch_end(l=30,seal=3,anchor=TOP,spin=0,orient=UP) {
  id=bosch_end[0];
  od=id+2*wall;

  attachable(anchor,spin,orient,d=od,l=l) {
    up(l/2-seal-1) union() {
      down(l-seal-1) difference() {
        tube(id=id,wall=wall,l=l,anchor=BOTTOM);

        up(seal+4-cl) xrot(90) down(BIGNUM/2) linear_extrude(BIGNUM) back(11/2) polygon(round_corners(trapezoid(h=11,w1=24.5,w2=20.5),radius=2));

      }
      // manual supports
      up(2*seal+5-cl-l) intersection() {
        down(0.01) union() for(i=[-1:0.66:1]) zrot(i*18) cuboid([c_lw,BIGNUM,11.02],anchor=BOTTOM);
        tube(id=id-2*c_lw,wall=wall+c_lw,h=11);
      }
      // seal ring
      tube(od=id+0.01,wall=seal,l=1,anchor=BOTTOM);
      up(1) tube(id1=id-2*seal,od1=od,id2=id,od2=od,l=seal,anchor=BOTTOM);
    }
    children();
  }
}

module bosch_exh(anchor=TOP,spin=0,orient=UP) {
  od=bosch_exh[1];
  l=50;

  attachable(anchor,spin,orient,d=od,l=l) {
    tube(od1=od,od2=od-0.5,l=l,wall=wall,anchor=CENTER);
    children();
  }
}

module pvc_male(l=30,anchor=TOP,spin=0,orient=UP) {
  od=pvc[0]-cl;

  attachable(anchor,spin,orient,d=od,l=l) {
    tube(od=od,wall=wall,l=l,anchor=anchor);
    children();
  }
}

module pvc_female(l=30,anchor=TOP,spin=0,orient=UP) {
  id=pvc[1]+cl;
  od=id+2*wall;

  attachable(anchor,spin,orient,d=od,l=l) {
    tube(id1=id,id2=id-$slop,wall=wall,l=l,anchor=CENTER);
    children();
  }
}

module black_male(l=28.5,anchor=TOP,spin=0,orient=UP) {
  od=black[0]-cl;

  attachable(anchor=anchor,spin=spin,orient=orient,d=od,l=l) {
    tube(od1=od,od2=od-0.5,wall=wall,l=l,anchor=CENTER);
    children();
  }
}

module black_female(l=28.5,anchor=TOP,spin=0,orient=UP) {
  id=black[1]+cl;
  od=id+2*wall;

  attachable(anchor=anchor,spin=spin,orient=orient,d=od,l=l) {
    // render()
    up(l/2) difference() {
      tube(id=id,wall=wall,l=l,anchor=anchor);

      // tightening slot
      down(0.01) {
        arced_slot(d=id+wall,h=l,sd=0.2,sa=-15,ea=15);
        zrot(15) pie_slice(d=id+wall+0.2,h=l,ang=10,anchor=TOP);
        zrot(-25) difference() {
          pie_slice(d=id+3*wall,h=l,ang=10,anchor=TOP);

          pie_slice(d=id+wall-0.2,h=l,ang=10,anchor=TOP);
        }
      }
      // pipe closer ring
      down(l-6) tube(id=id+2*wall-2*0.2,wall=wall,l=6,anchor=CENTER);
    }
    children();
  }
}

module black_pipe(fit,l=28.5,anchor=TOP,spin=0,orient=UP) {
  assert(fit=="male"||fit=="female");

  id=fit=="male"?black[0]-0.3:black[1]-2*wall;
  od=id+2*wall;

  attachable(d=od,l=l,anchor=anchor,spin=spin,orient=orient) {
    tube(od=od,wall=wall,l=l,anchor=CENTER);
    children();
  }
}

module dewalt(anchor=BOTTOM,spin=0,orient=UP) {
  od=50;
  l=59;

  attachable(anchor,spin,orient,d=od,l=l) {
    render()
    down(l/2) union() {
      translate([69.31,22.19,-1])
        import("2.5_+swiveling+dust+hose+adapter+for+DWE6423+DeWalt+random+orbital+sander/files/orbital_sander_to_rotation_female_fitting.stl");
      up(34) tube(id1=42,od1=45,id2=30.35,od2=45,l=8,anchor=TOP);
    }
    children();
  }
}

module orbital(anchor=BOTTOM,spin=0,orient=UP) {
  id=27;
  l=40;

  attachable(anchor,spin,orient,d=id+wall+0.6,l=l) {
    tube(id1=id+0.6,id2=id,wall=wall,l=l,anchor=CENTER);
    children();
  }
}

module flex_tube_connector(anchor=TOP,spin=0,orient=UP) {
  l=32;
  pitch=9;
  d=flex[1];
  depth=2.5;

  attachable(anchor,spin,orient,d=d,l=l) {
    down(9-l/2) xrot(180)
    union() {
      thread(pitch=pitch,twist=2*360,d=d,depth=depth,anchor=BOTTOM);
      tube(od=d,wall=wall,l=l,anchor=BOTTOM);
      up(0.01) tube(od1=d,id=d-2*wall,od2=d+2*9,h=9,anchor=TOP);
      tube(od=d+2*9,wall=wall,h=8,anchor=BOTTOM);
    }
    children();
  }
}

module thread(pitch=9,twist=360,d=62.4,depth=2.5,anchor=BOTTOM) {
  d_=d-0.01;
  l=pitch+0.01;

  up(pitch/2)
    thread_helix(base_d=d_,pitch=pitch,thread_depth=depth,thread_angle=45,twist=twist,higbee=45,anchor=anchor);
}

module pvc(l=30,anchor=TOP,spin=0,orient=UP) {
  od=pvc[1];

  attachable(anchor,spin,orient,d=od,l=l) {
    tube(od=od,wall=2.3,l=l,anchor=CENTER);
    children();
  }
}
