include <stdlib.scad>;
include <BOSL2/rounding.scad>;
include <BOSL2/beziers.scad>;

// $fn=16;
// $fn=32;
$fn=64;
BIGNUM=100;

s=[50,25,3];
text="Dirty";
text_th=0.0;

//     dia, th
magnet=[15+$slop,1.3];

// MODE="base";
MODE="postit";

// bottom_half(z=0.7)
// back_half()
if(MODE=="base") base();
else if(MODE=="postit") postit();

module base() {
  difference() {
    union() {
      offset_sweep(rect([s.x,s.y],chamfer=3,center=true),l=s.z,top=os_chamfer(cut=1));
      up(s.z) linear_extrude(text_th) text(text, size=12, valign="center", halign="center");
    }

    // magnet cavities
    let(l=s.x-magnet[1]-20) {
      fwd(s.y/5)  let(n=2) xcopies(spacing=l/(n%2==1?n-1:n), n=n) magnet_hole();
      back(s.y/5) let(n=3) xcopies(spacing=l/(n%2==1?n-1:n), n=n) magnet_hole();
    }

    // finger holds
    for(x=[-1,1]) translate([x*s.x/2*(s.x+4)/s.x,0,text_th]) cyl(d1=10,d2=10-2*1.2,l=s.z-1.2,anchor=BOTTOM);
    for(y=[-1,1]) translate([0,y*s.y/2*(s.y+4)/s.y,text_th]) cyl(d1=10,d2=10-2*1.2,l=s.z-1.2,anchor=BOTTOM);
  }
}

module magnet_hole() {
  union() {
    up(0.3) cyl(d=magnet[0],l=magnet[1],anchor=BOTTOM);
    up(0.31) cyl(d=0.01,l=BIGNUM,anchor=TOP);
  }
}

module postit() {
  w=76;
  th=0.3+magnet[1]+1.6;

  sc=0.98;
  hsc=(16-w*(1-sc))/16;

  difference() {
    note_block();

    // corner cut
    let(a=30,ch=11*w/100-th*cos(90-a)) translate([w-ch,ch]) rot([a,0,45]) cuboid(BIGNUM,anchor=BACK);

    // magnet holes
    let(os=th+magnet[0]/2) translate([w/2,w-os,0]) xcopies(l=w-2*os,n=4) magnet_hole();
  }

  module note_block(w=w) {
    union() {
      postit_top(w=w);
      straight_text(w=w);
      curved_text(w=w);
    }
  }

  module postit_top(w=100) {
    base=100;
    splinesteps=$fn/2;

    function vlines1(v,j=0) = ( v[j+1].x>v[j].x ? [v[j]] : concat([v[j]], vlines1(v,j=j+1)) );
    function vlines2(v) =
      [ for(i=[1:len(v)-1])
        if(  i==len(v)-1
          || v[i].x<v[i-1].x && v[i].x<v[i+1].x
          )
        v[i]
      ];
    function vlines3(v,j=0) = let(jj=len(v)-1-j) (v[jj-1].x<v[jj].x ? [v[jj]] : concat([v[jj]], vlines3(v,j=j+1)) );
    function vlines4(v) =
      reverse(
        [ for(i=idx(v))
          if(i==0
          || v[i].x>v[i-1].x && v[i].x>v[i+1].x
          )
          v[i]
        ]
      );
    function edge_verts(v)=let(vv=vnf_vertices(v)) concat(vlines1(vv),vlines2(vv),vlines3(vv),vlines4(vv));

    pindown=0.25;
    p1=100*pindown;
    p2=100*(1-pindown);
    patch = [
      // u=0,v=0                                                      u=1,v=0
      [[0,  0,0], [33,  0,  0], [66,  0,  0], [p2,  0,  0], [100-2.6,0+2.6,16]],
      [[0, p1,0], [33, p1,  0], [66, p1,  0], [p2, p1,  0], [100    , p1  , 0]],
      [[0, 33,0], [33, 33,  0], [66, 33,  0], [p2, 33,  0], [100    , 33  , 0]],
      [[0, 67,0], [33, 67,  0], [66, 67,  0], [p2, 67,  0], [100    , 67  , 0]],
      [[0,100,0], [33,100,  0], [66,100,  0], [p2,100,  0], [100    ,100  , 0]],
      // u=0,v=1                                                      u=1,v=1
    ];
    postit_top = bezier_patch(move(p=patch,v=[0,0,th]),splinesteps=splinesteps);
    // !trace_bezier_patches([move(p=patch,v=[0,0,th])],splinesteps=splinesteps);

    stt=edge_verts(postit_top);

    sbb=[for(p=stt) [p.x,p.y,0]];

    walls=vnf_reverse_faces(
      vnf_vertex_array(
        [
          stt,
          sbb,
        ]
      , caps=false
      , col_wrap=true
      )
    );
    vnf=vnf_compact([
      walls
    , vnf_reverse_faces(vnf_add_face([[],[]], sbb))
    , postit_top
    ]);
    render()
    scale(w/base)
    vnf_polyhedron(vnf);
  }

  module straight_text(w=100) {
    color("grey")
    translate([w/2,w/2]) left_half(x=1)
      linear_extrude((th+text_th)) text("Dirty",size=24*w/100,font="Noteworthy:style=Light",valign="center",halign="center");
  }

  module curved_text(w=100) {
    color("grey") let(r=40*w) translate([w/2,w/2])
      difference() {
        right_half(x=-1) up(r+th+text_th-0.1) zrot(-45) yrot(90) zrot(-90)
          yflip() cylindrical_extrude(or=r+text_th+th-0.4,ir=r,orient=LEFT,$fn=($fn>64?$fn:64))
            zrot(45) text("Dirty",size=24*w/100,font="Noteworthy:style=Light",valign="center",halign="center");

        translate([3,0,th+text_th]) cuboid(rb3(), rounding=3, anchor=RIGHT+BOTTOM);
      }
  }
}
