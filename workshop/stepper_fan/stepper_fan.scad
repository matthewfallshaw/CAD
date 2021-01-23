include <stdlib.scad>
include <BOSL2/metric_screws.scad>
include <BOSL2/involute_gears.scad>
include <BOSL2/nema_steppers.scad>
include <vitamins.scad>

// $fn=0;
// $fa=12;
// $fs=2;

// $fn=16;
// $fn=32;
// $fn=64;
$fn=128;

BIGNUM=1000;

wall=3;

pitch=1.85;
// [teeth,pr]
gears=[ let(t=100) [t,pitch_radius(pitch=pitch,teeth=t),outer_radius(pitch=pitch,teeth=t)]
      , let(t=20)  [t,pitch_radius(pitch=pitch,teeth=t),outer_radius(pitch=pitch,teeth=t)]
];
th=7;
shaft_dia=5;

motor_pos=[pitch_radius(pitch=pitch,teeth=get_teeth(gears[1]))+
             pitch_radius(pitch=pitch,teeth=get_teeth(gears[0]))
          ,0
          ,0];

bearing_h=7;
bearing_id=8;
bearing_pos=[0,0,th+1.3+$slop+bearing_h/2];
bearing_id2=18.5;

cl=4*$slop;

// MODE="drive_gear";
// MODE="housing_top";
// MODE="housing_bottom";
MODE="assy";

  // TODO
  DEBUG=true;
  // DEBUG=false;

if(MODE=="drive_gear") drive_gear();
else if(MODE=="m5m8_adapter") m5m8_adapter();
else if(MODE=="5Dm8_adapter") 5Dm8_adapter();
else if(MODE=="5m8_adapter") 5m8_adapter();
else if(MODE=="housing_top") yrot(180) housing_top();
else if(MODE=="housing_bottom") housing_bottom();
else {
  show("assy") assy();
}

// Both the assembly to show how everything fits together, and the positioning for cutouts in the
// housing body.
module assy(hide="nil") {
  // ## fan shaft
  // GT2 pulley
  GT2_pulley($tags="assy",GT2_pulley_20T,anchor="gearcenter") {
    position(CENTER) {
      cyl($tags="neg",d=GT2_diameter(GT2_pulley_20T)+2*cl,h=GT2_height(GT2_pulley_20T)+2*cl);
      down(GT2_height(GT2_pulley_20T)/2-3.5) cyl($tags="neg",d=5,l=BIGNUM,orient=LEFT,anchor=BOTTOM);
    }
    // M5 bolt
    position(BOTTOM) up(40-bb_width(BB608))
      metric_bolt($tags="assy",size=5,headtype="hex",pitch=0,l=40);
    // m5m8_adapter
    position(BOTTOM) {
      m5m8_adapter($tags="assy",anchor=TOP) {
        // bearing
        attach(CENTER,CENTER) {
          cyl($tags="neg",d=bb_diameter(BB608),h=bb_width(BB608)+$slop);
          n_ball_bearing($tags="assy",BB608);
        }
      }
    }
    // m5m8_adapter
    attach(TOP,BOTTOM)
      m5m8_adapter($tags="assy") {
        // bearing
        attach(CENTER,CENTER) {
          cyl($tags="neg",d=bb_diameter(BB608),h=bb_width(BB608)+$slop);
          n_ball_bearing($tags="assy",BB608)
            position(BOTTOM)
              cyl($tags="neg",d=bearing_id2,h=BIGNUM,anchor=TOP);
        }
        attach(TOP,BOTTOM) {
          metric_nut($tags="assy",size=5);
        }
      }
  }

  // ## drive shaft
  // drive gear
  right(motor_pos.x) {
    cyl($tags="neg",d=2*get_or(gears[0])+8*$slop,l=th+4*$slop);
    drive_gear($tags="assy",anchor="gearcenter") {
      position(BOTTOM) down(12-7-2) {
        // stepper motor
        union() {
          up(0.1) cyl($tags="neg",d=nema_motor_plinth_diam(size=17)+2*cl,l=nema_motor_plinth_height(size=17)+2*cl,anchor=TOP);
          down(nema_motor_plinth_height(size=17)+0.1) let(w=nema_motor_width(size=17)+$slop) cuboid($tags="neg",[w,w,BIGNUM],anchor=TOP);
        }
        down(0.2) nema17_stepper($tags="assy",anchor="shaft-bottom")
          // motor mounting CSK bolts
          for(a=[1:4]) position(str("screw",a)) up(3.8) metric_bolt($tags="neg",size=3,l=5,headtype="countersunk",pitch=0);
      }
      // bearing
      position(TOP) {
        cyl($tags="neg",d=bb_diameter(BB608)+$slop,h=bb_width(BB608)+$slop,anchor=BOTTOM);
        cyl($tags="neg",d=bearing_id2,h=bb_width(BB608));
        n_ball_bearing($tags="assy",BB608,anchor=BOTTOM)
          position(TOP)
            cyl($tags="neg",d=bearing_id2,h=BIGNUM,anchor=BOTTOM);
        5Dm8_adapter(anchor=BOTTOM);
      }
    }
    cyl($tags="neg",d=6,l=BIGNUM);
  }
  if(hide!="assy") housing($tags="assy");
}

module housing_top() {
  top_half() housing();
}

module housing_bottom() {
  bottom_half() housing();
}

module housing() {
  int_h=(GT2_pulley_20T[2][1]+GT2_pulley_20T[3][1])+bearing_h+$slop;
  s=[wall+bb_diameter(BB608)/2+get_pr(gears[1])+get_pr(gears[0])+get_or(gears[0])+wall+2,56,int_h+12];
  ctr=[-bb_diameter(BB608)/2-8,0,0];

  diff(neg="neg",pos="pos",keep="keep") {
    move(ctr) cuboid($tags="pos",s-(DEBUG?[0,s.y/2,0]:[0,0,0]),anchor=LEFT+(DEBUG?FRONT:[0,0,0]));

    assy(hide="assy");
    // closure bolts
    move(ctr+[s.x/2,0,0]) for(x=[-1,1],y=[-1,1]) move([x*(s.x/2-5),y*(s.y/2-5),0]) {
      // bolts
      cyl($tags="neg",d=3.2,l=BIGNUM);
      // heads
      up(s.z/2+0.01) cyl($tags="neg",d=6,l=3,anchor=TOP);
      down(s.z/2+0.01) cyl($tags="neg",d=5.5+$slop,l=3,$fn=6,anchor=BOTTOM);
    }
  }
}

module drive_gear(anchor=CENTER,spin=0,orient=UP) {
  d=gears[0][2];
  boss=GT2_heights(GT2_pulley_20T)[2];
  l=th+boss;

  attachable(d=d,l=l,anchor=anchor,spin=spin,orient=orient
            ,anchors=[anchorpt("gearcenter",[0,0,-th/2])],cp=[0,0,-th/2+boss/2]) {
    render()
    difference() {
      union() {
        gear(pitch=pitch,teeth=get_teeth(gears[0]),thickness=th-$slop,shaft_diam=0,anchor=TOP);
        down($slop+0.01) cyl(d=15,l=boss+$slop+0.01,anchor=BOTTOM);
      }

      difference() {
        cyl(d=5+2*$slop,l=BIGNUM);

        right(2-$slop/2) cuboid([BIGNUM,BIGNUM,BIGNUM],anchor=LEFT);
      }
    }
    children();
  }
}

module m5m8_adapter(anchor=CENTER,spin=0,orient=UP) {
  attachable(d=8,l=bearing_h,anchor=anchor,spin=spin,orient=orient) {
    render()
    difference() {
      cyl(d=8,l=bearing_h,anchor=CENTER);

      up(bearing_h/2) metric_bolt(size=5,l=bearing_h+1.01,headtype="hex");
      up(bearing_h/2-4.5) cyl(d=5,l=BIGNUM,anchor=TOP);
    }
    children();
  }
}

module 5Dm8_adapter(anchor=CENTER,spin=0,orient=UP) {
  attachable(d=8,l=bearing_h,anchor=anchor,spin=spin,orient=orient) {
    difference() {
      cyl(d=8,l=bearing_h,anchor=CENTER);

      difference() {
        cyl(d=5+1.5*$slop,l=BIGNUM);

        right(2-$slop/2) cuboid([BIGNUM,BIGNUM,BIGNUM],anchor=LEFT);
      }
    }
    children();
  }
}

module 5m8_adapter(anchor=CENTER,spin=0,orient=UP) {
  attachable(d=8,l=bearing_h,anchor=anchor,spin=spin,orient=orient) {
    difference() {
      cyl(d=8,l=bearing_h,anchor=CENTER);

      cyl(d=5+1.5*$slop,l=BIGNUM);
    }
    children();
  }
}

function get_teeth(g)=g[0];
function get_pr(g)=g[1];
function get_or(g)=g[2];