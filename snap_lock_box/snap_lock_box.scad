include <stdlib.scad>

$fn=64;

lh=0.3;   // line height
lw=0.45;  // line width

w=62;     // box width
d=40;     // box depth
h=36;     // box depth
th=lw*2;  // wall thickness

lid_h=15; // lid height
tab_w=20; // snap tab width
cl=0.2;   // clearance

spiral_vase_mode=true;  // spiral vase mode

// front_half() box_assembly(spiral_vase_mode);
// ydistribute(spacing=d+5) {
  // box(spiral_vase_mode);
  lid(spiral_vase_mode);
// }

module box_assembly(spiral_vase_mode) {
  box(spiral_vase_mode);
  left_half() up(h) xrot(180) lid(spiral_vase_mode);
}

module box(spiral_vase_mode) {
  wall=(spiral_vase_mode?lw:th);
  cc=internal_chamfer(3,(wall)+cl);
  bottom_half(s=w*2,z=h-(wall)-cl)
    union() {
      difference() {
        // cuboid([w,d,h-cc*cos(45)],chamfer=cc,edges=EDGES_ALL,anchor=BOTTOM);
        cuboid([w,d,h-wall-cl],chamfer=cc,edges=EDGES_ALL,anchor=BOTTOM);

        if(!spiral_vase_mode)
          up(th)
            cuboid([w-2*th,d-2*th,h],
                   chamfer=internal_chamfer(cc,th),edges=edges(EDGES_ALL,except=TOP),
                   anchor=BOTTOM);
      }
      for(i=zip([w/2,d/2,w/2,d/2],[for(i=[0:90:270]) i]))
        up(h-(lid_h-5)) rotate(i[1]) translate([i[0],0]) yrot(90)
          prismoid(size1=[2,tab_w-cl], size2=[0,tab_w-cl], h=1.5, anchor=BOTTOM);
  }
}

module lid(spiral_vase_mode) {
  wall=(spiral_vase_mode?lw:th);
  union() {
    difference() {
      cuboid([w+2*(wall)+2*cl,d+2*(wall)+2*cl,lid_h],
             chamfer=3,edges=edges(EDGES_ALL,except=TOP),anchor=BOTTOM);

      if(!spiral_vase_mode) {
        up((wall))
          cuboid([w+2*cl,d+2*cl,h],
                 chamfer=internal_chamfer(3,(wall)),
                 edges=edges(EDGES_ALL,except=TOP),
                 anchor=BOTTOM);
        for(i=zip([w/2,d/2,w/2,d/2],[for(i=[0:90:270]) i])) {
          up(lid_h-5) rotate(i[1]) translate([i[0]+cl,0]) {
            left(0.01) yrot(90) prismoid(size1=[2,tab_w], size2=[0,tab_w], h=1.5, anchor=BOTTOM);
            ycopies(n=2,l=tab_w*1.5) cuboid([(wall)*3,lw,11]);
          }
        }
        up(lid_h-(3+(wall))*cos(45))
          cuboid([w+2*(wall)+2*cl,d+2*(wall)+2*cl,lid_h],
                 chamfer=3,edges=edges(EDGES_ALL,except=TOP),anchor=BOTTOM);
      }
    }
    if(spiral_vase_mode)
      for(i=zip([w/2,d/2,w/2,d/2],[for(i=[0:90:270]) i]))
        up(lid_h-5) rotate(i[1]) translate([i[0]+lw+cl/2,0]) yrot(90)
          prismoid(size1=[2,tab_w-cl], size2=[0,tab_w-cl], h=1.5, anchor=BOTTOM);
  }
}

function internal_chamfer(ext_chamfer,wall_thickness,angle=45) =
  (ext_chamfer*sin(angle)+2*wall_thickness*sin(angle)-2*wall_thickness)/sin(angle);
