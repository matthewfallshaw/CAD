include <stdlib.scad>
include <BOSL2/joiners.scad>

$fn=64;

d=12;
d2=4;
names=["L","M"];

// name=names[1];
// name="tab";
// name="pin";
// name="icosa";
name="icosa_top";
// name="icosa_bottom";
// name="aligned";


*difference() {
  down(25) top_half(z=25) weight(name);
  zflip() snap_pin_socket("standard",d=10,l=15);
}
*zflip() difference() {
  down(25) bottom_half(z=25) weight(name);
  snap_pin_socket("standard",d=10,l=15);
}

if(!is_undef(name) && name=="tab") {
  tab();
} else if(!is_undef(name) && name=="pin") {
  snap_pin("standard",d=10,l=15,snap=0.7,pointed=false);
} else if(!is_undef(name) && ends_with(name,"_top")) {
} else if(!is_undef(name) && is_string(name)) {
  weight(name);
} else {
  for(name=[0:len(names)-1])
    right(name*90) ydistribute(spacing=40) {
      tab();
      weight(names[name]);
    }
}

module tab() {
  up(1.6) union() {
    cuboid([75,20,1.6],anchor=TOP);
    up(d/2+d2/2) yrot(180/8) torus(d=d/cos(180/8),d2=d2/cos(180/8),$fn=8,orient=FRONT);
    prismoid(h=d2/2,size1=[25,d2*2],size2=[25/2,d2/cos(180/8)],anchor=BOTTOM);
  }
}

module weight(name) {
  cd=40;
  ch=50;
  th=0.6;

  shifted=(name=="icosa" || name=="aligned")?0:5;

  down(shifted) top_half(z=shifted) difference() {
    union() {
      if(name=="icosa" || name=="aligned") spheroid(d=ch,style=name,$fn=10,anchor=BOTTOM);
      else cyl(h=ch,d=cd,chamfer=15,$fn=6,anchor=BOTTOM);
      up(ch+d/2) xrot(180/8) torus(d=d/cos(180/8),d2=d2/cos(180/8),$fn=8,orient=RIGHT);
    }

    if(name!="icosa" && name!="aligned")
      for(i=[0:360/6:360-0.01]) zrot(i) translate([0,th-cd/2*cos(180/6)-0.01,ch/2]) xrot(90)
        chamfered_text(h=0.6,step=0.2,text=name,size=15,valign="center",halign="center");
  }
}

module chamfered_text(h,step,text,size,font,halign,valign,spacing,direction,language,script,z=0) {
  if(z<h) {
    translate([0,00,z]) linear_extrude(min(step,h-z)) offset(-(h-z))
      text(text=text,size=size,font=font,halign=halign,valign=valign
          ,spacing=spacing,direction=direction,language=language,script=script);
    chamfered_text(h=h,step=step,text=text,size=size,font=font,halign=halign,valign=valign
                  ,spacing=spacing,direction=direction,language=language,script=script,z=z+step);
  }
}
