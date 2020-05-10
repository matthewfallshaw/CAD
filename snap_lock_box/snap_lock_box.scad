include <stdlib.scad>

$fn=64;

lh=0.3;   // line height
lw=0.45;  // line width

w=62;      // box width
d=40;      // box depth
h=36;      // box depth
th=lw*2;   // wall thickness
box_ch=3;  // box chamfer

lid_h=10;      // lid height
tab_l=20;      // snap tab length
tab_offset=4;  // snap tab offset

cl=0.2;  // clearance

spiral_vase_mode=true;  // spiral vase mode

front_half() box_assembly(spiral_vase_mode);
// ydistribute(spacing=d+5) {
  // box(spiral_vase_mode);
  // lid(spiral_vase_mode);
// }

module box_assembly(spiral_vase_mode) {
  union() {
    box(spiral_vase_mode);
    up(h) xrot(180) lid(spiral_vase_mode);
  }
}

module box(spiral_vase_mode) {
  wall=(spiral_vase_mode?lw:th);
  cc=internal_chamfer(box_ch,(wall)+cl);
  bottom_half(s=w*2,z=h-(wall)-cl)
    union() {
      difference() {
        cuboid([w,d,h-wall-cl],chamfer=cc,edges=EDGES_ALL,anchor=BOTTOM);

        if(!spiral_vase_mode)
          up(th)
            cuboid([w-2*th,d-2*th,h],
                   chamfer=internal_chamfer(cc,th),edges=edges(EDGES_ALL,except=TOP),
                   anchor=BOTTOM);
      }
      for(i=zip([w/2,d/2,w/2,d/2],[for(i=[0:90:270]) i]))
        up(h-(lid_h-tab_offset)) rotate(i[1]) translate([i[0],0]) yrot(90)
          prismoid(size1=[2,tab_l-cl], size2=[0,tab_l-cl], h=1.5, anchor=BOTTOM);
  }
}

module lid(spiral_vase_mode) {
  wall=(spiral_vase_mode?lw:th);
  union() {
    difference() {
      cuboid([w+2*(wall)+2*cl,d+2*(wall)+2*cl,lid_h],
             chamfer=box_ch,edges=edges(EDGES_ALL,except=TOP),anchor=BOTTOM);

      if(!spiral_vase_mode) {
        up((wall))
          cuboid([w+2*cl,d+2*cl,h],
                 chamfer=internal_chamfer(box_ch,(wall)),
                 edges=edges(EDGES_ALL,except=TOP),
                 anchor=BOTTOM);
        for(i=zip([w/2,d/2,w/2,d/2],[for(i=[0:90:270]) i])) {
          rotate(i[1]) translate([i[0]+cl,0]) {
            up(lid_h-tab_offset) left(0.01) yrot(90) prismoid(size1=[2,tab_l], size2=[0,tab_l], h=1.5, anchor=BOTTOM);
            ycopies(n=2,l=tab_l*1.5) up(lid_h-tab_offset-3) cuboid([(wall)*3,lw,lid_h],anchor=BOTTOM);
          }
        }
        up(lid_h-(box_ch+(wall))*cos(45))
          cuboid([w+2*(wall)+2*cl,d+2*(wall)+2*cl,lid_h],
                 chamfer=box_ch,edges=edges(EDGES_ALL,except=TOP),anchor=BOTTOM);
      }
    }
    if(spiral_vase_mode)
      for(i=zip([w/2,d/2,w/2,d/2],[for(i=[0:90:270]) i]))
        up(lid_h-tab_offset) rotate(i[1]) translate([i[0]+lw+cl/2,0]) yrot(90)
          prismoid(size1=[2,tab_l-cl], size2=[0,tab_l-cl], h=1.5, anchor=BOTTOM);
  }
}

function internal_chamfer(ext_chamfer,wall_thickness,angle=45) =
  (ext_chamfer*sin(angle)+2*wall_thickness*sin(angle)-2*wall_thickness)/sin(angle);
