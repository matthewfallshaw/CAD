include <stdlib.scad>
include <BOSL2/rounding.scad>

// $fn=0;
// $fa=12;
// $fs=2;
$fn=128;

BIGNUM=200;
l=126;
rnd=2;
cl=0.3;

cth=3;
cdepth=33.5;
cw=29;
ch=13.5;
cr=cth/2+3.75;

expansion=0.5;
w=38+2*expansion;
h=26.25+2*expansion;
top=10.5+expansion;

driver_d=14;


MODE="handle";
// MODE="end_cap";
// MODE="_casting";
// MODE="assy";

SUPPORTS=true;

// left_half()
if(MODE=="handle") handle();
else if(MODE=="end_cap") end_cap();
else if(MODE=="_casting") casting(clearance=false);
else {
  union() {
    handle();
    end_cap();
    color("gray",0.7) back_half(y=-cdepth-cl/2) casting(clearance=false);
  }
}

module handle() {
  difference() {
    base();

    if(SUPPORTS) difference() {
      casting(clearance=true);

      fwd(cth+cl/2) cuboid([BIGNUM,0.2,BIGNUM],anchor=BACK);
      fwd(cdepth+cl/2) cyl(r=cr,l=0.2,anchor=BOTTOM,orient=FRONT);
    }
    else casting(clearance=true);
    end_cap(lugs=false);
  }
}

module base() {
    fwd(rnd) minkowski() {
      difference() {
        xrot(90) linear_extrude(l)
          base2d();

        fwd(l-4) xrot(-15) cuboid(BIGNUM,anchor=BACK);
        // cutout
        down(10+expansion) xrot(2.75) cyl(d=70,l=BIGNUM,orient=FRONT,anchor=BACK);
      }
      spheroid(r=rnd);
    }
}

module base2d() {
  offset(-rnd) intersection() {
    circle_3points(pt1=[0,top],pt2=[-(w-2*expansion)/2,top-3],pt3=[(w-2*expansion)/2,top-3]);
    circle_3points(pt1=[0,top-h]
                  ,pt2=[-(w-3-2*expansion)/2,-h+top+5.75]
                  ,pt3=[(w-3-2*expansion)/2 ,-h+top+5.75]);
    back(top) rect([w,h],anchor=BACK);
  }
}

module casting(clearance) {
  assert(!is_undef(clearance));

  th=cth+(clearance?cl:0);
  depth=cdepth+(clearance?cl:0);
  w=cw+(clearance?cl:0);
  h=ch+(clearance?cl:0);
  r=cr+(clearance?cl/2:0);

  back(clearance?cl/2:0) union() {
    cyl(r=r,l=depth,circum=true,realign=true,spin=90,anchor=BOTTOM,orient=FWD);
    cuboid([w,depth,th],chamfer=0.5,anchor=BACK);
    xflip_copy() translate([w/2,0,r]) cuboid([th,depth,h],chamfer=0.5,anchor=TOP+RIGHT+BACK);
    up(r) cuboid([w,th,h],chamfer=0.5,except_edges=BACK,anchor=TOP+BACK);

    fwd(cdepth+cl/2) bolt_and_driver();
  }

  module bolt_and_driver() {
    union() {
      back(0.01) cyl(d=6,l=BIGNUM,anchor=BOTTOM,orient=FRONT);
      fwd(5) cyl(d=driver_d,l=BIGNUM,anchor=BOTTOM,orient=FRONT);
    }
  }
}

module end_cap(lugs=true) {
  d=driver_d+1+(lugs?0:cl);
  lug_r=1;
  lug_interference=1.5*cl;

  intersection() {
    base();
    fwd(l-18+(lugs?cl/2:0)) union() {
      cyl(d=d,l=BIGNUM,anchor=BOTTOM,orient=FRONT);
      if(lugs) for(i=[0:90:360-90]) yrot(i) translate([d/2-lug_r+lug_interference,-2])
        cyl(d=2,l=5,rounding=1,anchor=BOTTOM,orient=FRONT);
      // xrot(90) linear_extrude(BIGNUM) offset(1) offset(-4+(lugs?0:0.15)) base2d();
      // if(lugs) translate([0,-2]) for(p=[[0,0,5.5],[28.5/2,0],[-28.5/2,0]]) translate(p)
      //   cyl(d=2,l=5,rounding=1,anchor=BOTTOM,orient=FRONT,$fn=120);
    }
  }
}
