include <stdlib.scad>
include <BOSL2/rounding.scad>

// $fn=64;
$fn=16;

BIGNUM=500;

spacing=50;
dia=18;
rack_th=75;   // rack upright square thickness
rack_gage=3;  // rack steel gage
len=120;
th=8;         // backbone thickness
cl=0.3;       // clearance
wall=1.6;

clip_th=3;  // retaining clip thickness
clip_id=dia-2;
clip_od=dia+5;

pin_l=rack_th+2*cl+10;

flat_dia=dia*cos(180/8);
flat_ch=(flat_dia/(1+2*cos(45))+0.5)*cos(45);

// MODE="hook";
// MODE="clip";
MODE="chalk_tray";
// MODE="assy";
// MODE="assy2";

if(MODE=="hook") hook();
else if(MODE=="clip") clip();
else if(MODE=="chalk_tray") chalk_tray();
else if(MODE=="assy2") {
  union() {
    translate([0,-spacing+dia/2,th/2+wall]) xrot(-90) zrot(90) chalk_tray();
    chalk_pins();
  }
}
else {
  union() {
    hook();
    %up(th/2+cl) cuboid([rack_th,1000,rack_th],chamfer=5,anchor=BOTTOM);
    up(th/2+cl+rack_th+2*cl+cl/2+clip_th/2)
      for(y=[0,spacing]) fwd(y) clip();
  }
}


module hook() {
  intersection() {
    union() {
      // pins
      for(y=[0,spacing]) translate([0,-y,th/2]) pin(l=pin_l);
      // backbone
      cuboid([flat_dia+1,2*spacing+flat_dia+1,th],chamfer=flat_ch,edges="Z");
      // hook
      translate([0,spacing,-th/2]) cyl(d=dia,l=th/2+len,chamfer2=-0.5,$fn=8,realign=true,anchor=TOP);
    }
    // cleanup
    cuboid([flat_dia,1000,1000]);
  }
}

module pin(l) {
  assert(l);

  difference() {
    cyl(d=dia,l=l,chamfer1=-0.5,$fn=8,realign=true,anchor=BOTTOM);

    // retaining clip slots
    up(cl+l-10) let(slot_th=clip_th+cl) difference() {
      cyl(d=dia+0.01,l=slot_th,$fn=8,realign=true,anchor=BOTTOM);

      up(0.01) cyl(d=clip_id,l=slot_th+0.02,$fn=8,realign=true,anchor=BOTTOM);
    }
  }
}

module clip() {
  union() {
    difference() {
      cyl(d=clip_od+0.01,l=clip_th,$fn=8,realign=true);

      cyl(d=clip_id+cl/2,l=clip_th+0.02,$fn=8,realign=true);
      cuboid([flat_dia/2,1000,1000],anchor=FRONT);
    }
    // clip handle
    fwd(flat_dia/2) cuboid([3,4,clip_th],anchor=BACK);
    up(clip_th/2) fwd((flat_dia+2)/2) cuboid([1,3,2*clip_th],anchor=BACK+BOTTOM);
  }
}

module chalk_tray() {
  s=80;
  h=spacing-dia-$slop;
  r_bot=12;

  function prof(offset,z,inside_o) =
    path3d(
      round_corners(
        move([0,-offset-inside_o],rect([s+z+inside_o*sin(45)+(inside_o==0?0:offset/2),s+2*offset+2*inside_o]))
      , method="smooth",joint=[(inside_o==0?0:10),0,0,(inside_o==0?0:10)]
      )
    );

  module shape(inside) {
    wl=inside?wall:0;

    up(wl)
    skin(
      concat(
        [
          for(theta=[0:90/($fn):90])
          let(r=r_bot-wl,a=1-cos(theta),z=r*a)
          apply(
            up(z)
          , let(offset=-(1-(a<1?(1-a)*tan(theta):1))*r_bot) prof(offset=offset,z=z,inside_o=-wl)
          )
        ]
      , [ apply(up(h), prof(offset=0,z=h,inside_o=-wl)) ]
      )
    , slices=0
    );
  }

  // render() back_half()
  yrot(45)
  union() {
    render()
      fwd(s/2) difference() {
        shape(inside=false);

        shape(inside=true);
      }
    // pins
    intersection() {
      cuboid([BIGNUM,s,BIGNUM],rounding=r_bot,edges="X",anchor=BOTTOM,$fn=4*$fn);
      difference() {
        translate([th/2,0,spacing+dia/2]) rotate([90,0,-90]) chalk_pins();

        // overhang cutaway
        for(z=[0,spacing]) translate([-pin_l+10-wall-3*$slop-clip_th,0,1.61+z]) yrot(45)
          cuboid([dia,dia,dia],anchor=LEFT+TOP);
      }
    }
  }

  module chalk_pins() {
    w=max(flat_dia+1,80);

    intersection() {
      union() {
        // pins
        for(y=[0,spacing]) translate([0,-y,th/2]) pin(l=pin_l+wall+$slop);
        // backbone
        cuboid([w,2*spacing+flat_dia+1,th],chamfer=flat_ch,edges="Z");

      }
      // cleanup
      back(dia/2-0.5) cuboid([w,spacing+dia-1,1000],chamfer=flat_ch,edges="Z",anchor=BACK);
    }
  }
}

// ztweak = function (z)
