include <stdlib.scad>

$fn=64;

c_lw=0.35;
echo(c_lh=c_lh,c_lw=c_lw);

d=10;
brush_l=25;
handle_l=70;
spacing=0;

_z=quantup(d*cos(180/8),2*c_lh)+c_lh;
_d=_z/cos(180/8);
// #cuboid([BIGNUM,_z,_z]);
// #cyl(d=_d,l=BIGNUM,orient=RIGHT);

size=[_d-c_lw,_d-c_lh];
fspacing=3;
inside=regular_ngon(n=8,d=_d-c_lw,realign=true);

brush_plates(spacing=spacing);

// let(d=3*c_lh*2.5) intersection() {
  // right_half()
  // brush();
  // down(0.5*c_lh+0.001) cuboid([1000,1000,_d-0.002],anchor=BOTTOM);
// }

module brush_plates(spacing=0) {
  intersection() {
    if(spacing==0) cyl(d=_d,l=2*(handle_l+brush_l),chamfer=min(3,_d/3),realign=true,$fn=8,orient=RIGHT);
    else hull() union() {
      ycopies(spacing=spacing) cyl(d=_d,l=2*(handle_l+brush_l),chamfer=min(3,_d/3),realign=true,$fn=8,orient=RIGHT);
    }
    union() {
      xflip_copy() hull() right(brush_l) ycopies(spacing=spacing) cyl(d=_d,l=handle_l,chamfer2=min(3,_d/3),realign=true,$fn=8,orient=RIGHT,anchor=BOTTOM);
      down(_z/2) for(z=[c_lh:2*c_lh:_z]) up(z) cuboid([2*(brush_l+0.01),spacing+_d,c_lh], anchor=BOTTOM);
    }
  }
}

// module brush() {
//   xflip_copy() union() {
//     // xrot(90) yrot(90)
//     //   grid2d(spacing=1.3*c_lw,size=[_d,_d],stagger=true,inside=regular_ngon(n=8,d=_d-c_lw,realign=true))
//     //     cuboid(size=[c_lw,c_lh,brush_l],anchor=BOTTOM);
//     yflip_copy() zflip_copy()
//     for(z=[0:2.5*c_lh:size.x/2],y=[0:fspacing*c_lw:size.y/2]) {
//       if(point_in_region([y,z],[inside])>0)
//         translate([0,y,z]) cuboid([brush_l,c_lw,c_lh],anchor=LEFT);
//       if(point_in_region([z,y+fspacing*c_lw/2],[inside])>0)
//         translate([0,y+fspacing*c_lw/2,z+c_lh]) cuboid([brush_l,c_lw,c_lh],anchor=LEFT);
//     }
//     right(brush_l) cyl(d=_d,l=handle_l,chamfer2=min(3,_d/3),realign=true,$fn=8,orient=RIGHT,anchor=BOTTOM);
//   }
// }
