include <stdlib.scad>
include <BOSL2/joiners.scad>

$fn=64;

d_min=15;
d_maj=55+d_min;
s=[2*d_maj*sin(360/8),5*d_min,3];
names=["L","M"];

echo(s);

// MODE=names[1];
MODE="tab";
// MODE="pin";
// MODE="icosa";
// MODE="icosa_top";
// MODE="icosa_bottom";
// MODE="aligned";


*difference() {
  down(25) top_half(z=25) weight(MODE);
  zflip() snap_pin_socket("standard",d=10,l=15);
}
*zflip() difference() {
  down(25) bottom_half(z=25) weight(MODE);
  snap_pin_socket("standard",d=10,l=15);
}

if(MODE=="tab") {
  tab();
}
else if(MODE=="pin") {
  snap_pin("standard",d=10,l=15,snap=0.8,pointed=false);
}
else if(ends_with(MODE,"_top")) {
}
else if(is_string(MODE)) {
  weight(MODE);
}
else {
  for(MODE=[0:len(names)-1])
    right(MODE*90) ydistribute(spacing=40) {
      tab();
      weight(names[MODE]);
    }
}

module tab() {
  up(s.z) union() {
    cuboid(s,anchor=TOP);
    up(d_maj/2+d_min/2)
      xrot(90) zrot(360/8/2) rotate_extrude($fn=8) left(d_maj/cos(180/8)/2) zrot(360/8/2) oval(d=d_min/cos(180/8), $fn=8);
    prismoid(h=d_min/2,size1=[2*d_maj*sin(360/8),d_min*2],size2=[d_maj*sin(360/8),d_min/cos(180/8)],anchor=BOTTOM);
  }
  left(s.x/2) cuboid([3,s.y,2*d_min], chamfer=-6, edges=RIGHT+BOTTOM, anchor=BOTTOM);
}

module weight(MODE) {
  cd=40;
  ch=50;
  th=0.6;

  shifted=(MODE=="icosa" || MODE=="aligned")?0:5;

  down(shifted) top_half(z=shifted) difference() {
    union() {
      if(MODE=="icosa" || MODE=="aligned") spheroid(d=ch,style=MODE,$fn=10,anchor=BOTTOM);
      else cyl(h=ch,d=cd,chamfer=15,$fn=6,anchor=BOTTOM);
      up(ch+d_maj/2) xrot(180/8) torus(d_maj=d_maj/cos(180/8),d_min=d_min/cos(180/8),$fn=8,orient=RIGHT);
    }

    if(MODE!="icosa" && MODE!="aligned")
      for(i=[0:360/6:360-0.01]) zrot(i) translate([0,th-cd/2*cos(180/6)-0.01,ch/2]) xrot(90)
        chamfered_text(h=0.6,step=0.2,text=MODE,size=15,valign="center",halign="center");
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
