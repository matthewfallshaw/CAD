include <stdlib.scad>

$fn=64;

unit_w=4;

lw=0.45;
lh=0.2;

th=quantup(2.5,lh);

strip_w=19;
strip_d=71;


hook(w=unit_w*strip_w+4,d=strip_d+4,h=7, ch=2);

module hook(w,d,h,ch) {
  ang=atan(h/(d-ch));
  union() {
    translate([0,d/2,-h/2]) top_half() xrot(ang) translate([0,-d/2,h/2]) difference() {
      base(w=w,d=d,h=h,ch=ch);

      base(w=w-2*th,d=d-2*th,h=h+0.01,ch=ch,inner=true);
    }
    // down(h/2) rounded_prismoid(size1=[w,d],size2=[w-2*ch,d-2*th*tan(45-ang)],h=h/3,r=ch,anchor=BOTTOM);
    down(h/2) let(ang2=atan(th/ch)+ang) rounded_prismoid(size1=[w,d],size2=[w-2*(th*tan(ang2)),d-2*(th*tan(ang2))],h=h/3,r=ch,anchor=BOTTOM);
  }
}

module base(w,d,h,ch,inner=false) {
  union() {
    up(h/2) rounded_prismoid(size2=[w,d],size1=[w-2*ch,d-2*ch],h=h/3+0.01,r=ch,anchor=TOP);
    cuboid([w-2*ch,d-2*ch,h/3+0.01],rounding=ch,edges="Z");
    down(h/2) rounded_prismoid(size1=[w-(inner?2*ch:0),d-(inner?2*ch:0)],size2=[w-2*ch,d-2*ch],h=h/3+0.01,r=ch,anchor=BOTTOM);
  }
}
