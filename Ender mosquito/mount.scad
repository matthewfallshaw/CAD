include <NopSCADlib/lib.scad>

include <BOSL2/std.scad>

include <polyholes.scad>

// NopSCADlib extensions
M5_dome_screw = ["M5_dome", "M5 dome", hs_dome, 5, 9.3, 2.9, 2.3, 3.0, 22, M5_washer, M5_nut,
                 M5_tap_radius, M5_clearance_radius];
fan40x20 = [40, 20, 37, 16, M3_dome_screw, 25, 7.5, 100, 7, 0, undef];

$fn=64;
assy=true;  // show full assembly (stepper motor, bondtech, mosquito, fans)

clearance=0.2;

// E plate
eplate_size=[
  [64,47.5,2.5],            // 0 main

  [20,-(47.5-12+52-47.5)],  // 1 offset
  [24,24,2.5],              // 2 bottom
];
eplate_holes=[
  [12,   -11.9,  5  ],      // 0 top left roller
  [52,   -11.9,  5  ],      // 1 top right roller
  [13,   -33.25, 3  ],      // 2 bottom left fan shroud
  [30.5, -14.35, 3  ],      // 3 top middle fan shroud
  [41.5, -24.45, 3  , 5.4], // 4 left hotend
  [55.5, -24.45, 3  , 5.4], // 5 right hotend
  [32,   -52,    7.2],      // 6 bottom middle roller
];
estandoff=4.5;

// target positions (from top left front of E plate)
tnozzle=[41.5+14/2,-66.25,10.5];
// bmg_m positions (from stepper drive pin rear)
bnozzle=[3.175+2.15/2,-68,21.8+1.4/2];
bsize=[42,54,33];
bhotend_front=29;
// bltouch positions (from center top)
blsize=[26,11.5,45.7];

// mount params
wall=2.3;

// calculated positions
mount_height=screw_head_height(M5_dome_screw)+clearance;
stepper_pos=[tnozzle.x-bnozzle.z-wall,
             tnozzle.y-bnozzle.y,
             bsize.x/2+mount_height];
// actual positions (from top left front of E plate)
anozzle=[tnozzle.x,tnozzle.y,(stepper_pos.z-(3.175+2.15/2))];
bltouch_pos=[tnozzle.x-blsize.y-5,tnozzle.y+blsize.z-2,anozzle.z];
echo(tnozzle=tnozzle,bnozzle=bnozzle,anozzle=anozzle,bltouch_pos=bltouch_pos);

// hotend fan positions (from center top)
hfpos=[80,-23.75,anozzle.z];

// Target
if(assy) {
  color("red")   translate(tnozzle) sphere(0.5);
  color("green") translate(anozzle) sphere(0.5);
}

// Assembly
if(assy) {
  // Plate
  plate();
  // Stepper motor
  translate(stepper_pos) {
    yrot(90) nema17_stepper(h=25);
    xmove(wall) {
      yrot(90) bmg_m();
    }
  }
  // BLtouch
  translate(bltouch_pos) yrot(90) xrot(-90) bltouch();
  // Hotend fan
  translate(hfpos) yrot(90) color("Black", 0.7) fan(fan40x20);
  // translate(stepper_pos) translate([13.3,-33.5,-4]) yrot(90) color("Black", 0.7) fan(fan25x10);
  // Part fan
  translate([20,-40,10]) zrot(-30) xrot(90) zrot(90) fan5015();
  // hotend fan mount
  translate(hfpos) fan_mount();
}
// Mount (printed)
mount();


// translate([for(i=bnozzle) -i]) bmg_m();

module mount() {
  motor_supports=[stepper_pos.x,
                  NEMA_width(NEMA17)+wall,
                  NEMA_width(NEMA17)+mount_height];
  top_half(s=200) difference() {
    union() {
      // base plate
      cuboid([eplate_size[0].x,eplate_size[0].y,mount_height],rounding=10,edges=edges("Z",except=BACK),
             anchor=LEFT+BACK+BOTTOM);
      // hotend mount locators
      for(h=slice(eplate_holes,4,6)) translate([h.x,h.y]) difference() {
        cyl(h=estandoff,r1=h[3]/2+4,r2=h[3]/2+2,anchor=BOTTOM);
        poly_cylinder(h=10,r=h[3]/2,center=true);
      }
      // motor and extruder mount
      translate(stepper_pos) {
        difference() {
          union() {
            // plate (btwn stepper & bondtech)
            zmove(-stepper_pos.z)
              cuboid([wall,NEMA_width(NEMA17)+2*wall,NEMA_width(NEMA17)+mount_height],
                     anchor=LEFT+BOTTOM);
            // sides
            translate([-motor_supports.x/2,0,-stepper_pos.z])
              yspread(spacing=motor_supports.y,n=2)
                prismoid(size1=[motor_supports.x,wall], size2=[0,wall],
                         shift=[motor_supports.x/2,0], h=motor_supports.z);
            for(i=[[ (NEMA_width(NEMA17))/2,     motor_supports.x],
                   [-(NEMA_width(NEMA17))/2,     motor_supports.x+15],
                   [-(NEMA_width(NEMA17))/2-wall,motor_supports.x+15]])
              translate([-motor_supports.x,i[0],-NEMA_width(NEMA17)/2]) xrot(45)
                cuboid([i[1],2,2],anchor=LEFT);
            // side bottom
            translate([wall-0.01,-motor_supports.y/2,-stepper_pos.z]) difference() {
              let(sqh=25,w=14) union() {
                back(wall/2) {
                  cuboid([w,wall+1,sqh],anchor=BOTTOM+LEFT+BACK);
                  up(sqh) prismoid(size1=[w,wall+1], size2=[0,wall+1],
                           shift=[-w/2,0], h=motor_supports.z-sqh,anchor=LEFT+BOTTOM+BACK);
                  right(w) let(shft=9) prismoid(size1=[shft,wall+1], size2=[0,wall+1],
                           shift=[-shft/2,0], h=shft,anchor=LEFT+BOTTOM+BACK);
                }
              }
              // BLtouch mount holes
              translate([bltouch_pos.x-motor_supports.x-wall,bltouch_pos.y,bltouch_pos.z])
                zspread(spacing=18) xrot(90) poly_cylinder(h=100,r=2.9/2,center=true);
            }
          }
          // holes
          yrot(90) {
            let(r=3/2) NEMA_screw_positions(NEMA17) zrot(180/sides(r)) poly_cylinder(h=3*wall,r=r,center=true);
            poly_cylinder(h=10,r=NEMA_big_hole(NEMA17)+clearance,center=true);
          }
        }
      }
      // base patch
      cuboid([stepper_pos.x+10,motor_supports.y/2+stepper_pos.y+wall/2,mount_height],
             anchor=BACK+LEFT+BOTTOM);
      yflip() interior_fillet(l=mount_height,r=10,orient=UP,anchor=BOTTOM);
    }
    // holes
    //   roller clearance
    for(h=slice(eplate_holes,0,2)) translate([h.x,h.y])
      poly_cylinder(h=10,r=screw_head_radius(M5_dome_screw)+clearance,center=true);
    //   screw mount (ex-fan shroud)
    for(h=slice(eplate_holes,2,4)) translate([h.x,h.y]) {
      poly_cylinder(h=10,r=h[2]/2,center=true);
      zmove(mount_height-screw_head_height(M3_dome_screw)-clearance)
        poly_cylinder(h=10,r=screw_head_radius(M3_dome_screw)+clearance);
    }
    //   extruder mount
    for(h=slice(eplate_holes,4,6)) translate([h.x,h.y])
      poly_cylinder(h=9,r=h[3]/2,center=true);
    //  bottom roller
    translate(eplate_holes[6]) poly_cylinder(h=100,r=25/2,center=true);

    // BMG extruder gate clearance
    translate([stepper_pos.x+10,0,0]) cuboid([100,5,100],anchor=LEFT);
    // hotend clearance
    translate([tnozzle.x,-eplate_size[0].y,0]) cuboid([40,6.5,12]);

    // Hotend fan screw insertion clearance
    let(o=16) translate(hfpos+[-12,0,-o]) {
      fwd(o)  cyl(h=13,d=5,anchor=RIGHT,orient=RIGHT);
      back(o) cyl(h=9, d=5,anchor=RIGHT,orient=RIGHT);
    }
  }
}

module plate() {
  color("silver",0.7) difference() {
    union() {
      cuboid(eplate_size[0],rounding=10,edges=BTM+BACK,
             anchor=LEFT+BACK+TOP);
      translate(eplate_size[1]) cuboid(eplate_size[2],rounding=12,edges=EDGES_Z_FR,
             anchor=LEFT+BACK+TOP);
      translate([eplate_holes[4].x,eplate_holes[4].y])
        cyl(h=estandoff,d=eplate_holes[4][3],anchor=BOTTOM);
      translate([eplate_holes[5].x,eplate_holes[5].y])
        cyl(h=estandoff,d=eplate_holes[4][3],anchor=BOTTOM);
    }
    for(h=eplate_holes) translate([h.x,h.y]) cyl(h=10,d=h[2]);
  }
}

module bmg_m() {
  color("DimGray",0.7) import("bmg+m.stl");
  color("DimGray",0.6) translate([4.25,-21,22.5]) yrot(180) translate([-4.25,21,-22.5]) import("mosquito.stl");
}

module bltouch() {
  wrong_bltouch_height=42.4;
  color("Silver", 0.7)
    scale([1,1,blsize.z/wrong_bltouch_height])
      translate([-blsize.x/2,-blsize.y/2,-wrong_bltouch_height])
        import("3D Touch (BL Touch)/BL-touch.STL");
}

module fan5015() {
  color("DimGrey", 0.7) zmove(15) import("5015_Blower_Fan_50x15/files/5015_Blower_Fan.stl");
}

module fan_mount() {
  difference() {
    // Outer shape
    hull() {
      translate([-10,0,0]) cuboid([5,40,40],anchor=RIGHT);
      translate([-25,-8,0]) cuboid([5,25,25],anchor=LEFT);
    }

    // Inside shape
    hull() {
      translate([-10+0.01,0,0]) cyl(h=3,d=36.8,anchor=RIGHT,orient=RIGHT);
      translate([-25+3,-8,0]) cyl(h=0.01,d=20,anchor=LEFT,orient=RIGHT);
    }

    // Hotend side holes
    translate([-25,-8,0]) {
      cyl(h=100,d=20,orient=RIGHT);
      let(o=10) for(z=[-o,o]) translate([0,o,z]) {
        let(r=3/2) yrot(90) zrot(180/sides(r)) poly_cylinder(h=100,r=r,center=true);
        right(2) cyl(h=100,d=5,anchor=LEFT,orient=RIGHT);
      }
    }
    // Fan side holes
    translate([-10,0,0]) let(o=16) for(y=[-o,o]) for(z=[-o,o]) translate([0,y,z]) {
      let(r=3/2) yrot(90) zrot(180/sides(r)) poly_cylinder(h=100,r=r,center=true);
      left(2) cyl(h=100,d=5,anchor=RIGHT,orient=RIGHT);
      // let(r=3/2) yrot(-90) hanging_hole(z=2,ir=5.5/cos(180/6)/2,h=2.5,h2=10) circle(d=r,$fn=6);
      // left(2) cyl(h=2.5,d=5.5/cos(180/6),orient=RIGHT,anchor=RIGHT,$fn=6);
      // right(0.01) xrot(30) yrot(-90) poly_cylinder(h=2.5,r=3/2);
    }
    // Bondtech clearance
    translate([-26,9.5,0]) difference() {
      cuboid([10,10,100]);
      rot(-55) right(10.78) cuboid([10,10,100]);
    }
    // Base plate clearance
    translate([-18.4,0,-19.1]) cuboid([5,100,5]);
  }
}
