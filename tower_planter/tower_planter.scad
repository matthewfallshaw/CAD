include <stdlib.scad>
include <chamfer_calcs.scad>

w=80;  // outside width incl. crenellations
h=100;
tray_h=15;
wall=2.5;
bricks_w=3;  // how many bricks across the width of each wall?
brick_h_ratio=0.6;  // approximate brick height:width ratio
connector_h=min(2,wall-0.6);

drain=false;

cl=0.2;

lw=0.45;  // line width

brick_w=(w-2*wall-2*lw)/(bricks_w+1);
brick_h=(h-wall)/round((h-wall)/(brick_w*brick_h_ratio));
tray_h_in_bricks=round(tray_h/brick_h);

echo(brick_w=brick_w);
echo(brick_h=brick_h);

_tray_h=tray_h_in_bricks*brick_h*(drain?1:0);
_w=w-2*wall-2*lw;

$fn=64;

assy();
// tower();
// tray();

module assy() {
  // render(convexity=12)
  union() {
    up(_tray_h) tower();
    tray();
  }
}

module tower() {
  // render(convexity=12)
  difference() {
    union() {
      base(h=h-_tray_h-2*brick_h-wall,state=(_tray_h/brick_h)%2);
      up(h-_tray_h-2*brick_h-wall) difference() {
        union() {
          // crenellation base
          cuboid([w,w,wall+brick_h],chamfer=wall+lw,except_edges=TOP,anchor=BOTTOM);
          // crenellations
          for(i=[0:3]) up(brick_h+wall-0.01) zrot(i*90) fwd(w/2) xcopies(l=w-7/3*brick_w,n=bricks_w)
            cuboid([brick_w/2,2*wall+lw,brick_h]
                  ,chamfer=brick_w/16,edges=TOP,except_edges=[FRONT,BACK],anchor=FRONT+BOTTOM);
          // corner crenellations
          for(i=[0,1]) up(brick_h+wall-0.01) zrot(45+i*90)
            cuboid([min(internal_chamfer(brick_w/2,wall)/cos(45),brick_w/2),w/cos(45),brick_h]
                  ,chamfer=brick_w/16,edges=TOP,except_edges=[FRONT,BACK],anchor=BOTTOM);
        }

        // crenellation base chamfers
        for(i=[0:3]) zrot(i*90) fwd(w/2) right(w/2-(brick_w+wall)/2-lw) zrot(45) {
          // corner side chamfer
          cuboid([w,brick_w/2,h],anchor=BACK+BOTTOM);
          // corner corner chamfer
          up(wall+lw) xrot(45) cuboid([w,brick_w/2,h],anchor=BACK);
        }
      }
    }

    // location holes
    for(i=[0:3],x=[-1,1]) zrot(i*90) translate([x*brick_w*3/4,_w/2-wall/2])
      down(0.01) cuboid([brick_w/2,wall/2,connector_h],chamfer=-lw,edges=BOTTOM,anchor=BACK+BOTTOM);
    // drain hole
    if(drain)
    cyl(d=5,h=3*h);
    // center void
    up(wall+0.01) cuboid([_w-2*wall,_w-2*wall,h],chamfer=internal_chamfer(brick_w/2,wall),edges="Z",anchor=BOTTOM);
  }
}

module tray() {
  if(drain)
  // render(convexity=12)
  difference() {
    // render(convexity=12)
    union() {
      render(convexity=12)
      base(h=_tray_h);
      // location tabs
      render(convexity=12)
      for(i=[0:3],x=[-1,1]) zrot(i*90) translate([x*brick_w*3/4,_w/2-wall/2-cl,_tray_h]) {
        union() {
          cuboid([brick_w/2-cl,wall/2-cl,connector_h-cl],chamfer=wall/8,except_edges=BOTTOM,anchor=BACK+BOTTOM);
          fwd(wall/2-cl) prismoid(size1=[brick_w/2-cl-wall/4,wall/2-cl+lw],size2=[brick_w/2-cl-wall/4,wall/2-cl],h=lw,shift=[0,-lw/2],anchor=FRONT+BOTTOM);
        }
      }
    }

    // drainage channels
    render(convexity=12)
    up(_tray_h) for(i=[0,1]) zrot(i*90) cuboid([brick_w,w,2*lw]);
  }
}

module base(h,state=0) {
  render(convexity=12)
  difference() {
    union() {
      // base
      cuboid([_w,_w,h],chamfer=brick_w/2,edges="Z",anchor=BOTTOM);
      // bricks
      for(rot_i=[0:3],row_i=[0:(h/brick_h)-1+0.01]) zrot(rot_i*90) up(row_i*brick_h) fwd(_w/2) {
        if((row_i+state)%2==0) {
          for(i=[0:(bricks_w-1)]) right(i*brick_w-(bricks_w/2*brick_w)+brick_w/2) brick(w=brick_w);
        } else {
          left((_w-brick_w)/2-brick_w/4) brick(w=brick_w/2);
          for(i=[0:(bricks_w-2)]) right(i*brick_w-(_w-2*brick_w)/2+brick_w/2) brick(w=brick_w);
          right((_w-brick_w)/2-brick_w/4) brick(brick_w/2);
        }
        right((_w-brick_w)/2) zrot(45) right(brick_w/4/cos(45)) brick(w=brick_w/2/cos(45));
      }
    }

    // center void
    up(wall) cuboid([_w-2*wall,_w-2*wall,h],chamfer=internal_chamfer(brick_w/2,wall),edges="Z",anchor=BOTTOM);
  }
}

module brick(w) {
  render(convexity=12)
  prismoid(size1=[w,brick_h],size2=[w-2*lw,brick_h-2*lw],h=lw,orient=FRONT,anchor=FRONT+BOTTOM);
}
