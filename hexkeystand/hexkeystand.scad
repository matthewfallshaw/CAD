include <stdlib.scad>
include <BOSL2/structs.scad>
include <BOSL2/debug.scad>

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
  [ "Allen drill ball keys",
    [ [ 2.0, 6.3, 6.3]
    , [ 2.5, 6.3, 6.3]
    , [ 3.0, 6.3, 6.3]
    , [ 4.0, 6.3, 6.3]
    , [ 5.0, 6.3, 6.3]
    , [ 6.0, 6.3, 6.3]
    , [ 8.0, 6.3, 8.0]
    ]
  ],
  [ "Allen drill ball long keys",
    [ [ 2.0, 6.3, 6.3]
    , [ 2.5, 6.3, 6.3]
    , [ 3.0, 6.3, 6.3]
    , [ 4.0, 6.3, 6.3]
    , [ 5.0, 6.3, 6.3]
    , [ 6.0, 6.3, 6.3]
    , [ 8.0, 6.3, 8.0]
    , [10.0, 6.3,10.0]
    ]
  ],
  [ "Phillips drill bits",
    [ [ "PH0 2.5", 6.3, 6.3]
    , [ "PH1 2.5", 6.3, 6.3]
    , [ "PH1 4.0", 6.3, 6.3]
    , [ "PH1 4.5", 6.3, 6.3]
    , [ "PH2 4.0", 6.3, 6.3]
    , [ "PH2 4.5", 6.3, 6.3]
    , [ "PH2 5.0", 6.3, 6.3]
    , [ "PH2 6.0", 6.3, 6.3]
    , [ "PH2 6.0", 6.3, 6.3]
    ]
  ],
  [ "Allen Sockets Small",
    [ [ 5.0, 6.3, 5.0+0.5]
    , [ 5.5, 6.3, 5.5+0.5]
    , [ 6.0, 6.3, 6.0+0.5]
    , [ 7.0, 6.3, 7.0+0.5]
    , [ 8.0, 6.3, 8.0+0.5]
    ]
  ],
  [ "Allen Sockets Large",
    [ [ 9.0, 6.3,  9.0+0.5]
    , [10.0, 6.3, 10.0+0.5]
    , [11.0, 6.3, 11.0+0.5]
    , [12.0, 6.3, 12.0+0.5]
    , [13.0, 6.3, 13.0+0.5]
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
  [ "Drill bits 1",
    [ [  1.0,  1.0,  1.0]
    , [  1.5,  1.5,  1.5]
    , [  2.0,  2.0,  2.0]
    , [  2.5,  2.5,  2.5]
    , [  3.0,  3.0,  3.0]
    , [  3.5,  3.5,  3.5]
    , [  4.0,  4.0,  4.0]
    , [  4.5,  4.5,  4.5]
    , [  5.0,  5.0,  5.0]
    , [  5.5,  5.5,  5.5]
    , [  6.0,  6.0,  6.0]
    , [  6.5,  6.5,  6.5]
    , [  7.0,  7.0,  7.0]
    ]
  ],
  [ "Drill bits 2",
    [ [  7.5,  7.5,  7.5]
    , [  8.0,  8.0,  8.0]
    , [  8.5,  8.5,  8.5]
    , [  9.0,  9.0,  9.0]
    , [  9.5,  9.5,  9.5]
    , [ 10.0, 10.0, 10.0]
    , [ 10.5, 10.5, 10.5]
    ]
  ],
  [ "Drill bits 3",
    [ [ 11.0, 11.0, 11.0]
    , [ 11.5, 11.5, 11.5]
    , [ 12.0, 12.0, 12.0]
    , [ 12.5, 12.5, 12.5]
    , [ 13.0, 13.0, 13.0]
    ]
  ],
  [ "Drill bits 4",
    [ [  1.5,  1.5,  1.5]
    , [  2.0,  2.0,  2.0]
    , [  2.5,  2.5,  2.5]
    , [  3.0,  3.0,  3.0]
    , [  3.3,  3.3,  3.3]
    , [  3.5,  3.5,  3.5]
    , [  4.0,  4.0,  4.0]
    , [  4.2,  4.2,  4.2]
    , [  4.5,  4.5,  4.5]
    , [  5.0,  5.0,  5.0]
    , [  5.5,  5.5,  5.5]
    , [  6.0,  6.0,  6.0]
    , [  6.5,  6.5,  6.5]
    ]
  ],
  [ "Allen drill ball keys",
    [ [ 2.0, 6.3, 6.3]
    , [ 2.5, 6.3, 6.3]
    , [ 3.0, 6.3, 6.3]
    , [ 4.0, 6.3, 6.3]
    , [ 5.0, 6.3, 6.3]
    , [ 6.0, 6.3, 6.3]
    , [ 8.0, 6.3, 8.0]
    ]
  ],
  [ "Quarter socket adapters",
    [ [ "1/4",  6.3,  6.3  ]
    , [ "3/8",  6.3,  9.825]
    , [ "1/2",  6.3, 13.0  ]
    ]
  ],
  [ "Phillips odds",
    [ [ "PH1", 6.3, 6.3]
    , [ "PH2", 6.3, 6.3]
    , [ "PH3", 6.3, 6.3]
    , [ "PH3", 6.3, 6.3]
    , [ "6.0", 6.3, 6.3]
    ]
  ],
];

/* [Dimensions] */
stand_height=10;
stand_wall=1.5;
// internal hex clearance
clearance=0.1;
// distance between keys
gap=0;
// same side min distance before flipping label to other side
min_flip=3;
// font size
ts=3;

/* [Details] */
$fn=100;

/* [Basic] */
block=false;  // true for block with inset holes; false for hex stands
MODE="Phillips odds";  // ["Allen drill keys", "Allen Sockets Small", "Allen Sockets Large", "Countersink bits", "Allen keys"]

     if(MODE=="Allen drill ball keys") ;
else if(MODE=="Phillips odds") ;

keyset=MODE;
keys=struct_val(keysets,keyset);
w=sum_spacing(keys)+spacing(keys[0][1],keys[len(keys)-1][1])+10;
h=max([for(i=keys) i[1]])+18;
nudge=spacing(keys[0][1],keys[0][1])/2+10/2;

echo(MODE=MODE,keys=keys);
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
    down(block?stand_height+1:3) cuboid(size=[w,h,block?stand_height:2],rounding=3,edges="Z",anchor=ALLNEG);
    down(1) hull() {
      cuboid([w,h,0.01],rounding=3,edges="Z",anchor=ALLNEG);
      translate([1,1,1]) cuboid([w-2,h-2,0.01],rounding=2,edges="Z",anchor=LEFT+FRONT+TOP);
    }
  }
}

module key_stands(block=false) {
  translate([nudge,h/2,block?-stand_height:0]) for (i=[0:len(keys)-1]) {
    s=sum_spacing(slice(keys,0,i+1));
    right(s) key_stand(keys[i],block);
  }
}

module key_stand(key,block=false) {
  s=key[1]+clearance;
  if (!block) {
    difference() {
      cyl(
        h=stand_height,  d=s+2*stand_wall,circum=true,anchor=BOTTOM,$fn=6);

      up(-1) cyl(
        h=stand_height+2,d=s,             circum=true,anchor=BOTTOM,$fn=6);
      up(stand_height-1) cyl(
        h=1.01,          d1=s,
                         d2=s+2,          circum=true,anchor=BOTTOM,$fn=6);
    }
  } else {
    union() {
      cyl(
        h=stand_height+2,d=s,             anchor=BOTTOM,$fn=6);
      up(stand_height-1) cyl(
        h=1.01,          d1=s,
                         d2=s+2,          anchor=BOTTOM,$fn=6);
    }
  }
}

module labels() {
  translate([nudge,h/2]) {
    for (i=[0:len(keys)-1]) {
      s=sum_spacing(slice(keys,0,i+1));
      translate([s,
                 ((keys[i][1]<min_flip && i%2!=0)?
                   keys[i][2]/2+2.5:
                   -keys[i][1]/2-(ts+2.5))
                ]) color("MediumBlue") linear_extrude(0.6) offset(r=0.2) text(str(keys[i][0]),size=ts,halign="center",font="osifont");
    }
  }
}

function sum_spacing(keys)=len(keys)>1?
                             sum([for(i=[1:len(keys)-1]) spacing(keys[i-1][2],keys[i][2])]):
                             0;
function spacing(prev_key,key)=(prev_key+key+2*clearance)/cos(360/6/2)/2+2*stand_wall+gap;
