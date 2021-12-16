include <stdlib.scad>
include <BOSL2/gears.scad>
include <BOSL2/fnliterals.scad>
include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/ball_bearings.scad>

// $fn=0;
// $fa=12;
// $fs=2;

$fn=64;  // [ 16, 32, 64, 128, 256, 512 ]

// BIGNUM=100;

mod = 176.5/83;
gap = 3.5;

gears = hashmap(items=[
    ["motor", hashmap(items=[
        ["name", "motor"]
      , ["pressure_angle", 20]
      , ["teeth", 10]
      , ["mod", 0.5]
      , ["od", 6.02]
      , ["thickness", 4]
      ])
    ]
  , ["drive", hashmap(items=[
        ["name", "drive"]
      , ["teeth", 8]
      , ["helical", 45]
      ])
    ]
  , ["train1", hashmap(items=[
        ["name", "train1"]
      , ["teeth", 24]
      , ["helical", 45]
      ])
    ]
  , ["train2", hashmap(items=[
        ["name", "train2"]
      , ["teeth", 16]
      , ["helical", 45]
      ])
    ]
  , ["drum", hashmap(items=[
        ["name", "drum"]
      , ["teeth", 94]
      , ["helical", 45]
      , ["shaft_dia", 190]
      ])
    ]
  , ["support_gear_for_bearing", hashmap(items=[
        ["name", "support_gear_for_bearing"]
      , ["od", 21]
      , ["teeth", 16]
      , ["mod", mod]
      , ["helical", 45]
      ])
    ]
  ]);

positions = let(train1_z=33.2, train2_z=33.2, train2_y=-35) hashmap(items=[
    ["drum", [0,8+$slop,158.6]],
    ["motor", [-25.5,train2_y,train1_z]],
    ["support", [0,16+$slop,56]],
    ["train1", [0,8+$slop,train1_z]],
    ["train2", [0,train2_y,train1_z]],
    ["train_front", [0,-3,train1_z]],
    ["trainbb1", [0,-3-bb_width(BB608)/2- 3,train1_z]],
    ["trainbb2", [0,-3-bb_width(BB608)/2-18,train1_z]],
]);

DEBUG=false;
// DEBUG=true;

SHOW_CASING=true;
SHOW_HOUSING=true;

MODE="assy";  // [ support_gear_for_bearing, drum_gear, train_gear1, train_gear2, drive_gear, motor_housing, train_housing, drum_gear_support_ring, assy ]

// tube(od=200,wall=1,l=15);
if(MODE=="support_gear_for_bearing") support_gear_for_bearing_mod();
else if(MODE=="drum_gear") drum_gear();
else if(MODE=="train_gear1") yrot(180) train_gear1();
else if(MODE=="train_gear2") train_gear2();
else if(MODE=="drive_gear") drive_gear();
else if(MODE=="motor_housing") motor_housing();
else if(MODE=="train_housing") train_housing();
else if(MODE=="drum_gear_support_ring") drum_gear_support_ring();
else assy();


module assy() {
  // Casings
  if(SHOW_CASING) {
    color("orange")
      // render() back_half(y=-50)
      up(2) inner_casing();
    casing_a();
    casing_b();
  }

  // Support gears
  xcopies(spacing=2*56) translate(positions("support")) xrot(90) {
    // render() bottom_half(z=8)
    support_gear_for_bearing();
  }

  // Drum gear
  // color("green") render() back_half(y=8+$slop)
  translate(positions("drum")) {
    xrot(90) drum_gear();
  }

  // Front Train gear
  translate(positions("train1")) yrot(7.2) train_gear1(orient=BACK);
  for(j=[1,2]) translate(positions(str("trainbb", j))) xrot(90) ball_bearing(BB608);

  // Rear Train gear
  translate(positions("train2")) yrot(12)
    // render() intersection() {
    //   cuboid([BIGNUM,10+gap,BIGNUM], anchor=BACK);
      train_gear2(anchor="gear", orient=FRONT);
    // }

  translate(positions("train_front")) color("Blue") train_housing();

  // Motor & housing
  translate(positions("motor")) {
    yrot(25) drive_gear(orient=FRONT);
    hide("hide") motor(anchor="gear", orient=BACK)
      position("frontbody")
        color("Blue") motor_housing(anchor="motor", $tags=(SHOW_HOUSING?"":"hide"));
  }
}

module support_gear_for_bearing_mod() {
  // props = gears("support_gear_for_bearing");

  // zrot(2.4)
  // up(8.0)
  // bottom_half()
  // _gear(props);
  echo("support_gear_for_bearing", mod = 2.12651, teeth = 16, pd = 34.0241, od = 38.2771);

  render()
  union() {
    support_gear_for_bearing();
    up(5.5+16/2) tube(or=25,ir=15,l=0.2);
    tube(or=25,wall=4*c_lw*0.90,l=5.5+16/2);
  }
}


module support_gear_for_bearing() {
  translate([0.008,0.285,16/2-1.3])
  yrot(90)
  translate([-10,-45,-20])
    import("./Remixed+reittec+polisher+/files/support_gear_for_bearing.STL");

  if(DEBUG==true) #cyl(d=34, l=16, anchor=BOTTOM);
}

module drum_gear() {
  render()
  _gear(gears("drum"));
}

// module drum_gear_original() {
//   od=179.8;
//   id=170.5;

//   translate([-8.21,-44.75,44])
//     import("./Remixed+reittec+polisher+/files/drum_gear.STL");
//   // difference() {
//   //   cyl(d=od,l=10,orient=RIGHT);
//   //   cyl(d=id,l=BIGNUM,orient=RIGHT);
//   // }
// }

module drum_gear_support_ring() {
  tube(id=gears("drum")("shaft_dia"), wall=1, l=30);
}

module train_gear1(anchor="gear", spin=0, orient=UP) {
  id=194;
  shaft=positions("train1").y-5+6;
  l=10+shaft;

  attachable(anchor=anchor, spin=spin, orient=orient,
             r=outer_radius(teeth=gears("train1")("teeth"), mod=mod),
             l=l, anchors=[named_anchor("gear", [0,0,0])]) {
    color("green")
    render()
    _gear(gears("train1"))
      attach(BOTTOM, BOTTOM) cyl(d=10, l=shaft)
      attach(TOP, BOTTOM) cyl(d=8+0.2, l=15+bb_width(BB608)+3+10, chamfer2=1, $fn=8);
    children();
  }
}

module train_gear2(anchor="gear", spin=0, orient=UP) {
  attachable(anchor=anchor, spin=spin, orient=orient,
             r=outer_radius(teeth=gears("train1")("teeth"), mod=mod), l=22,
             anchors=[ named_anchor("gear", [0,0,0]) ]) {
    difference() {
      _gear(gears("train2"));
      cyl(d=8+0.2, l=BIGNUM, $fn=8);
    }
    children();
  }
}

module drive_gear(anchor="gear", spin=0, orient=UP) {
  motor_gear_clearance=gears("motor")(del="thickness")(additems=[
      ["thickness", BIGNUM]
    , ["interior", true]
  ]);

  attachable(anchor=anchor, spin=spin, orient=orient,
             r=outer_radius(teeth=gears("train1")("teeth"), mod=mod), l=22,
             anchors=[ named_anchor("gear", [0,0,0]) ]) {
    difference() {
      _gear(gears("drive"));

      scale(6/5.65) _gear(motor_gear_clearance, offset=$slop/4);
    }
    children();
  }
}

module _gear(props, anchor=CENTER, spin=0, orient=UP, offset=0) {
  assert(props);
  assert(props("od") ||props("pd") ||  props("id") || props("teeth"));

  mod            = default(props("mod"), mod);
  adendum        = adendum(mod=mod);
  dedendum       = dedendum(mod=mod);
  teeth          = props("teeth")
                   ? props("teeth")
                   : props("pd")
                     ? round(props("pd")/mod)
                     : props("od")
                       ? round((props("od")-2*adendum)/mod)
                       : round((props("id")+2*dedendum)/mod);
  helical        = default(props("helical"), 0);
  thickness      = default(props("thickness"), 10);
  interior       = default(props("interior"), false);
  pressure_angle = default(props("pressure_angle"), 28);
  shaft_dia     = default(props("shaft_dia"), 0);
  od             = 2*outer_radius(teeth=teeth, mod=mod);

  attachable(anchor=anchor, spin=spin, orient=orient, d=od, l=thickness) {

    if(helical>0) zflip_copy() up(thickness/4) __gear();
    else __gear();
    children();
  }

  name = default(props("name"), "gear");
  echo(name,
       mod=mod, teeth=teeth,
       pd=2*pitch_radius(mod=mod,teeth=teeth),
       od=2*outer_radius(mod=mod, teeth=teeth),
       interior=interior
      );
  if(DEBUG==true) #cyl(r=pitch_radius(mod=mod, teeth=teeth), l=16.01);

  module __gear() {
    thickness = thickness/(helical > 0 ? 2 : 1);
    twist   = atan2(thickness*tan(helical),pitch_radius(mod=mod, teeth=teeth));

    linear_extrude(height=thickness, center=true, convexity=teeth/2, twist=twist)
      difference() {
        offset(offset) spur_gear2d(mod=mod, teeth=teeth,
                  pressure_angle=pressure_angle,
                  interior=interior
                 );

        if(shaft_dia>0) circle(d=shaft_dia);
      }
  }
}

module inner_casing() {
  translate([0,0,22.5]) xrot(90)
    import("./Remixed+reittec+polisher+/files/inner_casing.STL");
  // #translate([0,0,29]) cyl(d=14,l=BIGNUM,orient=FRONT);
}

module casing_a() {
  color("blue")
  translate([0,-48.5,0])
    import("./Remixed+reittec+polisher+/files/casing_a.STL");
}

module casing_b() {
  translate([0,-48.5,0])
    import("./Remixed+reittec+polisher+/files/casing_b.STL");
}

module motor(anchor="frontbody", spin=0, orient=FRONT) {
  xrot(90)
  attachable(anchor=anchor, spin=spin, orient=orient,
    size=[24,30.5+11.5,18.3],
    cp=[0,-30.5/2,0],
    anchors=[ named_anchor("frontbody", pos=[0,0,0], orient=BACK, spin=0)
            , named_anchor("gear", pos=[0,11.5-gears("motor")("thickness")/2,0]) ]
  ) {
    union() {
      color("Silver") {
        intersection() {
          cyl(d=24, l=30.5, chamfer=0.5, orient=FRONT, anchor=BOTTOM);
          cuboid([24,30.5,18.3], chamfer=0.5, anchor=BACK);
        }
        for(s=[[6.15,1.6],[2,11]]) cyl(d=s.x, l=2*s.y, orient=FRONT);
      }
      color("Gold") back(11.5) _gear(gears("motor"), orient=BACK, anchor=TOP);
    }
    children();
  }
}

module train_housing() {
  cpt=[0,0,positions("train2").z];
  flr=[0,0,6];
  s=[40,26.5,positions("train_front").z-flr.z+2.20];
  th=3;

  render()
  difference() {
    down(cpt.z-flr.z-$slop) cuboid(s, chamfer=0.5, anchor=BACK+BOTTOM);

    translate([0,-3,-8.7]) for(i=[0:360/6:180]) yrot(i) right(15.5) {
      cyl(d=6, l=BIGNUM, orient=FRONT, anchor=BOTTOM);
      cyl(d=3, l=BIGNUM, orient=FRONT);
    }
    cyl(d=bb_diameter(BB608)-2*bb_rim(BB608), l=BIGNUM, orient=FRONT);
    for(j=[1,2]) translate(-positions("train_front")) translate(positions(str("trainbb", j))) cyl(d=bb_diameter(BB608)+$slop, l=bb_width(BB608)+$slop, orient=FRONT);
  }
}

module motor_housing(anchor=CENTER, spin=0, orient=UP) {
  cpt=[0,0,positions("motor").z];
  flr=[0,0,6];
  s=[30,40,42];
  th=3;

  attachable(anchor=anchor, spin=spin, orient=orient, size=s, cp=[0,-s.y/2,-cpt.z+flr.z+$slop+s.z/2],
             anchors=[ named_anchor("motor", [0,0,0]) ]
            ) {
    render()
    intersection() {
      difference() {
        down(cpt.z-flr.z-$slop) cuboid(s, chamfer=0.5, anchor=BACK+BOTTOM);

        // motor cavity
        for(y=[1,-$slop]) move(y=y) motor(orient=BACK);
        // rear motor cavity
        intersection() {
          cyl(d=20, l=BIGNUM, orient=FRONT);
          cuboid([20,BIGNUM, 14]);
        }
        // casing clearance
        translate([-57.5,0,-33.5]) cyl(d=100+2*2,l=BIGNUM, orient=FRONT);
        // screw holes
        let(d_cl=(s.y-3)/5-3, pad=2+d_cl/2)
          for(i=[-2,s.x/2-pad], j=[-3-d_cl/2,-s.y+3+d_cl/2], k=-(cpt.z-flr.z-$slop-2))
            translate([i,j,k]) {
              cyl(d=d_cl, l=BIGNUM, anchor=BOTTOM);
              cyl(d=3, l=BIGNUM);
            }
      }
      union() {
        // plates
        for(y=[0:(-(s.y-3)/5):-s.y-3]) move(y=y) cuboid([BIGNUM,3,BIGNUM], anchor=BACK);
        down((cpt.z-flr.z-$slop)-s.z/2) for(i=[-1,1], k=1) move(x=i*(s.x/2-2), z=k*(s.z/2-2)) cuboid([4,BIGNUM,4]);
        down((cpt.z-flr.z-$slop)-s.z/2) for(i=[0], k=-1) move(x=i*(s.x/2-2), z=k*(s.z/2-2)) cuboid([s.x,BIGNUM,4]);
      }
    }
    children();
  }
}
