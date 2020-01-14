include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
use <BOSL/masks.scad>
use <BOSL/math.scad>
include <NopSCADlib/lib.scad>
include <NopSCADlib/vitamins/stepper_motors.scad>

// NopSCADlib extensions
M5_dome_screw = ["M5_dome", "M5 dome", hs_dome, 5, 9.3, 2.9, 2.3, 3.0, 22, M5_washer, M5_nut,
                 M5_tap_radius, M5_clearance_radius];

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
// bmg_m positions (from drive pin rear)
bnozzle=[3.175+2.15/2,-68,21.8+1.4/2];
bsize=[42,54,33];
bhotend_front=29;
// bltouch positions (from center top)
blsize=[26,11.5,45.7];
// actual positions (from top left front of E plate)
anozzle=[];
echo(tnozzle=tnozzle,bnozzle=bnozzle);

// mount params
wall=2.3;

// calculated positions
mount_height=screw_head_height(M5_dome_screw)+clearance;
stepper_pos=[tnozzle.x-bnozzle.z-wall,
             tnozzle.y-bnozzle.y,
             bsize.x/2+mount_height];

// Assembly

color("red") translate(tnozzle) sphere(0.5);

plate();
translate(stepper_pos) {
  yrot(90) NEMA(NEMA17M);
  xmove(wall) {
    yrot(90) bmg_m();
  }
}
translate([tnozzle.x,tnozzle.y+blsize.z,mount_height+30.05+blsize.y/2+10]) xrot(-90) bltouch();
mount();


// translate([for(i=bnozzle) -i]) bmg_m();

module mount() {
  motor_supports=[stepper_pos.x,
                  NEMA_width(NEMA17)+wall,
                  NEMA_width(NEMA17)+mount_height];
  difference() {
    union() {
      // base plate
      cuboid([eplate_size[0].x,eplate_size[0].y,mount_height],fillet=10,edges=EDGES_Z_BK,
             align=V_RIGHT+V_FRONT+V_TOP);
      // hotend mount locators
      for(h=slice(eplate_holes,4,6)) translate([h.x,h.y]) difference() {
        cyl(h=estandoff,r1=h[3]/2+4,r2=h[3]/2+2,align=V_TOP);
        poly_cylinder(h=10,r=h[3]/2,center=true);
      }
      // motor and extruder mount
      translate(stepper_pos) {
        difference() {
          union() {
            // plate
            zmove(-stepper_pos.z)
              cuboid([wall,NEMA_width(NEMA17)+2*wall,NEMA_width(NEMA17)+mount_height],
                     align=V_RIGHT+V_TOP);
            // sides
            translate([-motor_supports.x/2,0,-stepper_pos.z])
              yspread(spacing=motor_supports.y,n=2)
                prismoid(size1=[motor_supports.x,wall], size2=[0,wall],
                         shift=[motor_supports.x/2,0], h=motor_supports.z);
            for(i=[[ (NEMA_width(NEMA17))/2,     motor_supports.x],
                   [-(NEMA_width(NEMA17))/2,     motor_supports.x+15],
                   [-(NEMA_width(NEMA17))/2-wall,motor_supports.x+15]])
              translate([-motor_supports.x,i[0],-NEMA_width(NEMA17)/2]) xrot(45)
                cuboid([i[1],2,2],align=V_RIGHT);
            // side bottom
            translate([wall,-motor_supports.y/2,-stepper_pos.z])
              prismoid(size1=[15,wall], size2=[0,wall],
                       shift=[-15/2,0], h=motor_supports.z,align=V_RIGHT+V_TOP);
          }
          // holes
          yrot(90) {
            NEMA_screw_positions(NEMA17) poly_cylinder(h=3*wall,r=3/2,center=true);
            poly_cylinder(h=10,r=NEMA_big_hole(NEMA17)+clearance,center=true);
          }
        }
      }
      // base patch
      cuboid([stepper_pos.x+10,motor_supports.y/2+stepper_pos.y+wall/2,mount_height],
             align=V_ALLPOS);
      yflip() interior_fillet(l=mount_height,r=10,orient=ORIENT_Z,align=V_TOP);
    }
    // holes
    for(h=slice(eplate_holes,0,2)) translate([h.x,h.y])
      poly_cylinder(h=10,r=screw_head_radius(M5_dome_screw)+clearance,center=true);
    for(h=slice(eplate_holes,2,4)) translate([h.x,h.y]) {
      poly_cylinder(h=10,r=h[2]/2,center=true);
      zmove(mount_height-screw_head_height(M3_dome_screw)-clearance)
        poly_cylinder(h=10,r=screw_head_radius(M3_dome_screw)+clearance);
    }
    for(h=slice(eplate_holes,4,6)) translate([h.x,h.y])
      poly_cylinder(h=10,r=h[3]/2,center=true);
    translate(eplate_holes[6]) poly_cylinder(h=100,r=25/2,center=true);
    // extruder gate clearance
    translate([stepper_pos.x+10,0,0]) cuboid([100,5,100],align=V_RIGHT); // TODO
  }
}

module plate() {
  color("silver",0.7) difference() {
    union() {
      cuboid(eplate_size[0],fillet=10,edges=EDGES_Z_BK,
             align=V_RIGHT+V_FRONT+V_BOTTOM);
      translate(eplate_size[1]) cuboid(eplate_size[2],fillet=12,edges=EDGES_Z_FR,
             align=V_RIGHT+V_FRONT+V_BOTTOM);
      translate([eplate_holes[4].x,eplate_holes[4].y])
        cyl(h=estandoff,d=eplate_holes[4][3],align=V_TOP);
      translate([eplate_holes[5].x,eplate_holes[5].y])
        cyl(h=estandoff,d=eplate_holes[4][3],align=V_TOP);
    }
    for(h=eplate_holes) translate([h.x,h.y]) cyl(h=10,d=h[2]);
  }
}

module bmg_m() {
  color("DimGray",0.7) import("bmg+m.stl");
}

module bltouch() {
  wrong_bltouch_height=42.4;
  color("Silver", 0.7)
    scale([1,1,blsize.z/wrong_bltouch_height])
      translate([-blsize.x/2,-blsize.y/2,-wrong_bltouch_height])
        import("3D Touch (BL Touch)/BL-touch.STL");
}
