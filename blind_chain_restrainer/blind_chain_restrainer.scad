include <stdlib.scad>
// include <BOSL2/rounding.scad>

h=8;
w=12;
d=8;
tab=10;
rad=d/4;
th=min(h,w,d,tab)/5;
cl=0.3;
slide_rad=0.75*h;
hole_dia=3.7;

$fn=128;

intersection() {
  union() {
    difference() {
      linear_extrude(h) stroke(
        // round_corners(
          [
            [-tab    , 0      ],
            [w       , 0      ],
            [w       , d      ],
            [th      , d      ],
            [0       , d-th   ],
            [0       , 2*th+cl],
            [-th     , th+cl  ],
            [-tab+th , th+cl  ],
            [-tab    , 2*th+cl],
          ]
        , width=th
        , closed=false
        , hull=false
          // curve="circle",measure="radius",size=rad)
      );


      translate([-(tab-th/2)/2,0,h/2]) yrot(360/7/4) polycyl(l=d,d=hole_dia,orient=FWD);
      translate([slide_rad+w-2.5,d/2,h/2]) cyl(h=d+th,r=slide_rad,orient=FWD);
    }
    translate([slide_rad+w-3,d/2,h/2]) {
      difference() {
        union() {
          cyl(h=d+th,r=slide_rad,orient=FWD);
          cyl(h=d-th,r=slide_rad,rounding=-th,orient=FWD);
        }
        cyl(h=d+th+0.01,r=slide_rad-th,orient=FWD);
      }
    }
  }
  translate([w,-th/2]) cuboid([2*(w+tab),d+th,h],rounding=2*th,edges=edges([RIGHT+FRONT,RIGHT+BACK]),anchor=BOTTOM+FRONT+RIGHT);
}
