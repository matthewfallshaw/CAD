include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>
use <BOSL/math.scad>

keys=[0.7,0.9,1.3,1.5,2,2.5,3,4,5,6];

stand_height=10;
stand_wall=1.5;
clearance=0.2;
gap=-0.5;

$fn=100;

factor=cos(360/6/2);
w=sum_spacing(keys)+spacing(keys[0],keys[len(keys)-1])+10;
h=max(keys)+16;
nudge=spacing(keys[0],keys[0])/2+10/2;

//thin();
block();

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
    zmove(-(block?stand_height+1:3)) cuboid(size=[w,h,block?stand_height:2],fillet=3,edges=EDGES_Z_ALL,align=V_ALLPOS);
    zmove(-1) rounded_prismoid(size1=[w,h],size2=[w-2,h-2],h=1,r=3,align=V_ALLPOS);
  }
}

module key_stands(block=false) {
  translate([nudge,h/2,block?-stand_height:0]) for (i=[0:len(keys)-1]) {
    s=sum_spacing(slice(keys,0,i+1));
    xmove(s) key_stand(keys[i],block);
  }
}

module key_stand(size,block=false) {
  s=(size+clearance)/factor;
  if (!block) {
    difference() {
      cylinder(
        h=stand_height,  d=s+2*stand_wall,$fn=6);
      zmove(-1) cylinder(
        h=stand_height+2,d=s,             $fn=6);
      zmove(stand_height-1) cylinder(
        h=1.01,          d1=s,
                         d2=s+2,          $fn=6);
    }
  } else {
    union() {
      cylinder(
        h=stand_height+2,d=s,             $fn=6);
      zmove(stand_height-1) cylinder(
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
                 (i%2!=0?
                   keys[i]/2+2.5:
                   -keys[i]/2-(ts+2.5))
                ]) linear_extrude(0.6) offset(r=0.2) text(str(keys[i]),size=ts,halign="center");
    }
  }
}

function sum_spacing(keys)=len(keys)>1?
                             sum([for(i=[1:len(keys)-1]) spacing(keys[i-1],keys[i])]):
                             0;
function spacing(prev_key,key)=(prev_key+key+2*clearance)/factor/2+2*stand_wall+gap;
