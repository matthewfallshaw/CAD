include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
use <BOSL/math.scad>

/* include <NopSCADlib/global_defs.scad> */
/* include <NopSCADlib/lib.scad> */

$fn=180;

$layer_height    = 0.1;
$extrusion_width = 0.45;
$nozzle          = 0.4;

lh  = $layer_height;
lw  = $extrusion_width;

w=60;
d=60;
th=1.2;
strut=w-10;
h=20;

difference() {
union() {
  downcube([w,d,th]);
  ymove(-d/2) xspread(n=2, spacing=strut) {
    thinning_triangle(h=strut, l=d, thick=th, ang=45, strut=th+lw*2, wall=lw*2, center=false);
  }
  translate([0,-d/2,h/2]) xrot(-90) magnet_plate();
}
cyl(d=5,h=10);
}

module magnet_plate() {
  union() {
    /* translate([-strut/2,-h/2]) box(wall=[lw*2,lw*2,lh], size=[strut,h,th], align=V_ALLPOS); */
    difference() {
      upcube(size=[strut,h,th]);
      zmove(lh*2) cuboid(size=[strut-2*th,h-2*th,100],chamfer=th, edges=EDGES_BOTTOM, align=V_TOP);
    }
    xspread(n=2, spacing=strut/2) tube(id=10, or1=10/2+lw*3+th, or2=10/2+lw*3, h=th, center=false);
  }
}

/* module box( */
/*     wall=0.1, */
/*     size=[1,1,1], */
/*     p1=undef, p2=undef, */
/*     chamfer=undef, */
/*     fillet=undef, */
/*     edges=EDGES_ALL, */
/*     trimcorners=true, */
/*     align=[0,0,0], */
/*     center=undef */
/*     ){ */
/*   w = scalar_vec3(wall); */
/*   difference() { */
/*     cuboid(size=size, */
/*            chamfer=chamfer, fillet=fillet, edges=edges, trimcorners=trimcorners, */
/*            p1=p1, p2=p2, align=align, center=center); */
/*     offset_size=[size.x-2*w.x,size.y-2*w.y,size.z+1]; */
/*     assert(min(offset_size)>0,str("Negative wall size. size=",size,"; wall=", w)); */
/*     zmove(w.z) translate(center ? [0,0] : [w.x,w.y]) cuboid(size=offset_size, */
/*                        chamfer=chamfer, fillet=fillet, edges=edges, trimcorners=trimcorners, */
/*                        p1=p1, p2=p2, align=align, center=center); */
/*   } */
/* } */

//magnet_plate();

/* h=20; */
/* wall=[lw*2,lw*2,lh]; */
/* size=[strut,h,th]; */
/* //align=V_FRONT+V_UP; */
/* align=V_ALLPOS; */
/* echo(wall, size, align); */
/* echo(vmul([1,0,1],[2,2,2])); */
/* front_half() ymove(-5) box(wall=wall, size=size, align=align, center=false); */
