include <stdlib.scad>

$fn=32;

// clip_model1();
// clip_model2(through=true);
clip_model3();

module clip_model3() {
  wall=2.5;
  od1=23;
  id2=6.2;
  l_cone=10.5;
  l=23;
  fil=1.75+1.5;

  union() {
    right(10) yrot(45) left(10) {
      top_half() down(1) entry_cone();
      tube(h=0.5+0.1,od1=id2+2*0.5,id1=id2+2*0.5,od2=id2+2*0.5,id2=id2,anchor=TOP);
    }
    xrot(-90) right(10) rotate_extrude(angle=45) left(10) difference() {
      circle(d=id2+2*wall);
      circle(d=id2+0.5);
    }
    tube(h=1.2,od=20,id=id2+0.5,anchor=TOP);
    difference() {
      cyl(h=55,d=id2+2*wall,chamfer1=0.5,anchor=TOP);
      up(0.01) cyl(h=55+0.02,d=id2+0.5,anchor=TOP);
    }
    down(1.2/2) zflip_copy() {
      up(1.2/2) tube(h=0.5+0.1,od1=id2+2*wall+2*0.5,id1=id2+2*wall-2*0.1,od2=id2+2*wall-2*0.1,id2=id2+2*wall-2*0.1,anchor=BOTTOM);
    }
  }

  module entry_cone() {
    up(l-0.5) zflip() union() {
      difference() {
        guide(wall=wall,od1=od1,id2=id2,l=l_cone,fil=fil);
        cyl(d=id2,h=100);
      }
    }
  }
}

module clip_model2(through=false) {
  wall=2.5;
  od1=23;
  id2=6.2;
  l=10.5;
  fil=1.75+1.5;

  union() {
    difference() {
      back_half() translate([0,-15,2]) import("Filament_Guide_Small_Loop.stl");

      xrot(90) yrot(90) {
        guide_shape(int=true,wall=wall,od1=od1,id2=id2,l=l,fil=fil);
        back(l) cuboid([od1+2,23,1.75+0.5],anchor=BACK+LEFT);
      }
    }
    difference() {
      xrot(90) yrot(90) guide(wall=wall,od1=od1,id2=id2,l=l,fil=fil);
      cyl(d=id2,h=100);
    }
  }
}

module guide(wall,od1,id2,l,fil) {
  difference() {
    base_guide(wall=wall,od1=od1,id2=id2,l=l,fil=fil);

    up(l) cuboid([od1,1.75+0.5,23],anchor=TOP+LEFT);
    translate([0,(1.75+0.5)/2,l]) xrot(5) cuboid([od1,1.75+0.5,23],anchor=BACK+LEFT+BOTTOM);
  }
}

module base_guide(wall,od1,id2,l,fil) {
  difference() {
    guide_shape(int=false,wall=wall,od1=od1,id2=id2,l=l,fil=fil);

    down(0.01) guide_shape(int=true,wall=wall,od1=od1,id2=id2,l=l,fil=fil);
  }
}

module guide_shape(int=false,wall,od1,id2,l,fil) {
  union() {
    // cone
    cyl(d1=od1-(int?1:0)*2*wall/cos(30),d2=fil+(int?0:1)*2*wall,h=l-(int?1:0)*wall,rounding1=(int?-1:1)*0.5,anchor=BOTTOM);
    // tube
    up(l-(int?0:4)) cyl(d=id2+(int?0:1)*2*wall,h=23-(l-(int?0:4)),rounding2=(int?-1:1)*0.5,anchor=BOTTOM);
    // filament hole
    if(int) up(l-wall/2) cyl(d=fil,h=wall,rounding2=-0.5);
  }
}

module clip_model1() {
  difference() {
    cs=3.3;
    bth=cs+0.8;

    union() {
      right(11.5) top_half() left_half() right(11) original();
      /* hull() for(x=) */
      cuboid([30,30,bth],chamfer=3,edges="Z",anchor=TOP+FRONT);
    }

    up(0.01) ycopies(spacing=20) xcopies(spacing=20) back(30/2) union() {
      polycyl(d=5,h=3*bth);
      cyl(d1=4.5,d2=8,h=cs,anchor=TOP);
    }
  }

  module original() {
    yrot(90) import("Spool_filament_guide_shorter.stl");
  }
}
