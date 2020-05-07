include <stdlib.scad>
include <BOSL2/structs.scad>

/* [Hidden] */
keysets=[
  //  label,base,spacing
  [ "Allen drill keys",
    [ [ 1.5, 6.3, 6.3]
    , [ 2.0, 6.3, 6.3]
    , [ 2.5, 6.3, 6.3]
    , [ 3.0, 6.3, 6.3]
    , [ 4.0, 6.3, 6.3]
    , [ 5.0, 6.3, 6.3]
    , [ 6.0, 6.3, 6.3]
    , [ 8.0, 6.3, 8.0]
    ]
  ],
  [ "Allen Sockets Small",
    [ [ 5.0, 6.3, 5.0+2.3]
    , [ 5.5, 6.3, 5.5+2.3]
    , [ 6.0, 6.3, 6.0+2.3]
    , [ 7.0, 6.3, 7.0+2.3]
    , [ 8.0, 6.3, 8.0+2.3]
    ]
  ],
  [ "Allen Sockets Large",
    [ [ 9.0, 6.3,  9.0+2.3]
    , [10.0, 6.3, 10.0+2.3]
    , [11.0, 6.3, 11.0+2.3]
    , [12.0, 6.3, 12.0+2.3]
    , [13.0, 6.3, 13.0+2.3]
    ]
  ],
  [ "Countersink bits",
    [ [ 6.0, 6.3,  6.0]
    , [ 8.0, 6.3,  8.5]
    , [ 9.0, 6.3,  9.0]
    , [12.0, 6.3, 12.0]
    , [16.0, 6.3, 16.0]
    , [19.0, 6.3, 19.0]
    ]
  ],
  [ "Allen keys",
    [ [ 0.7, 0.7,  0.7]
    , [ 0.9, 0.9,  0.9]
    , [ 1.3, 1.3,  1.3]
    , [ 1.5, 1.5,  1.5]
    , [ 2.0, 2.0,  2.0]
    , [ 2.5, 2.5,  2.5]
    , [ 3.0, 3.0,  3.0]
    , [ 4.0, 4.0,  4.0]
    , [ 5.0, 5.0,  5.0]
    , [ 6.0, 6.0,  6.0]
    ]
  ],
];

/* [Basic] */
block=false;  // true for block with inset holes; false for hex stands
keyset="Allen drill keys";  // ["Allen drill keys", "Allen Sockets Small", "Allen Sockets Large", "Countersink bits", "Allen keys"]

/* [Dimensions] */
stand_height=10;
stand_wall=1.5;
// internal hex clearance
clearance=0.7;
// distance between keys
gap=-0.5;

/* [Details] */
$fn=100;


keys=struct_val(keysets,keyset);
factor=cos(360/6/2);
w=sum_spacing(keys)+spacing(keys[0][1],keys[len(keys)-1][1])+10;
h=max([for(i=keys) i[1]])+18;
nudge=spacing(keys[0][1],keys[0][1])/2+10/2;

echo(keys=keys);
if(!block) thin(); else block();

module block() {
  difference() {
    union() {
      base(block=true);
      labels();
    }
    key_stands(block=true);
  }
}

module thin() {
  union() {
    base();
    key_stands();
    labels();
  }
}

module base(block=false) {
  union() {
    up(-(block?stand_height+1:3)) cuboid(size=[w,h,block?stand_height:2],rounding=3,edges="Z",anchor=ALLNEG);
    up(-1) rounded_prismoid(size1=[w,h],size2=[w-2,h-2],h=1,r=3,anchor=ALLNEG);
  }
}

module key_stands(block=false) {
  translate([nudge,h/2,block?-stand_height:0]) for (i=[0:len(keys)-1]) {
    s=sum_spacing(slice(keys,0,i+1));
    right(s) key_stand(keys[i],block);
  }
}

module key_stand(key,block=false) {
  s=(key[1]+clearance)/factor;
  if (!block) {
    difference() {
      cylinder(
        h=stand_height,  d=s+2*stand_wall,$fn=6);
      up(-1) cylinder(
        h=stand_height+2,d=s,             $fn=6);
      up(stand_height-1) cylinder(
        h=1.01,          d1=s,
                         d2=s+2,          $fn=6);
    }
  } else {
    union() {
      cylinder(
        h=stand_height+2,d=s,             $fn=6);
      up(stand_height-1) cylinder(
        h=1.01,          d1=s,
                         d2=s+2,          $fn=6);
    }
  }
}

module labels() {
  ts=3;
  translate([nudge,h/2]) {
    for (i=[0:len(keys)-1]) {
      s=sum_spacing(slice(keys,0,i+1));
      translate([s,
                 ((keys[i][1]<2.4 && i%2!=0)?
                   keys[i][2]/2+2.5:
                   -keys[i][1]/2-(ts+2.5))
                ]) linear_extrude(0.6) offset(r=0.2) text(str(keys[i][0]),size=ts,halign="center");
    }
  }
}

function sum_spacing(keys)=len(keys)>1?
                             sum([for(i=[1:len(keys)-1]) spacing(keys[i-1][2],keys[i][2])]):
                             0;
function spacing(prev_key,key)=(prev_key+key+2*clearance)/factor/2+2*stand_wall+gap;
