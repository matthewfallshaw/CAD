include <stdlib.scad>

rnd=5;
h=46;
s1=[60,85,0];
s2=[80,85,h];
mid_th=22.5;
wall=2*0.45+2*0.5;
pin_d=6;

lw=0.45;
lh=0.2;

BIGNUM=100;

points=[
  [s1.x/2,s1.y/2,s1.z],
  [s2.x/2,s2.y/2,s2.z],
];
points2=[
  find_circle_2tangents([          0,points[0].y,points[0].z],
                        [points[0].x,points[0].y,points[0].z],
                        [points[1].x,points[1].y,points[1].z],r=wall)[0],
  find_circle_2tangents([points[0].x,points[0].y,points[0].z],
                        [points[1].x,points[1].y,points[1].z],
                        [          0,points[1].y,points[1].z],r=wall)[0],
];
points3=[
  find_circle_2tangents([          0,points[0].y-wall,points[0].z],
                        [points[0].x,points[0].y-wall,points[0].z],
                        [points[1].x,points[1].y-wall,points[1].z],r=2*wall)[0],
  find_circle_2tangents([points[0].x,points[0].y-wall,points[0].z],
                        [points[1].x,points[1].y-wall,points[1].z],
                        [          0,points[1].y-wall,points[1].z],r=2*wall)[0],
];
points3_ext=[
  points3[0],
  2*(points3[1]-points3[0])+points3[0],
];
points4=[
  find_circle_2tangents([          0,points[0].y-wall,points[0].z],
                        [points[0].x,points[0].y-wall,points[0].z],
                        [points[1].x,points[1].y-wall,points[1].z],r=20)[0],
  find_circle_2tangents([points[0].x,points[0].y-wall,points[0].z],
                        [points[1].x,points[1].y-wall,points[1].z],
                        [          0,points[1].y-wall,points[1].z],r=20)[0],
];
points4_ext=[
  points4[0],
  5*(points4[1]-points4[0])+points4[0],
];

// MODE="base";
// MODE="pin";
// MODE="flex";
MODE="assy";
// MODE="nil";

echo(MODE=MODE);

// back_half()
if(MODE=="base") base();
else if(MODE=="pin") pin();
else if(MODE=="flex") flex();
else if(MODE=="assy") union() {
  base();
  translate([0,-(mid_th-$slop)/2+wall,39]) xrot(-90) flex();
  xflip_copy() translate([54/2,mid_th/2,39]) xrot(90) pin();
}
else {
  color("green") stroke([[points4[0].x,points4[0].z],[points4[1].x,points4[1].z]]);
  color("blue") stroke([[-s2.x,39],[s2.x,39]]);
  translate(line_intersection([[points4[0].x,points4[0].z],[points4[1].x,points4[1].z]],[[-s2.x,39],[s2.x,39]])) sphere(2);
}

$fn=64;

module base() {
  top_half() union() {
    render()
    difference() {
      // base
      hull() yflip_copy() xflip_copy() for(p=points3) translate(p) spheroid(r=2*wall);

      // base pocket
      hull() yflip_copy() xflip_copy() for(p=points3_ext) translate(p) spheroid(r=wall);
      // front & rear scoop
      yflip_copy() translate([0,mid_th/2,2*wall]) cuboid([2*s2.x,s2.y,2*h],rounding=12,edges=BOTTOM,anchor=FRONT+BOTTOM);
    }
    render()
    difference() {
      // arms
      prismoid(size1=[s1.x,mid_th],size2=[s2.x,mid_th],h=h);

      // arm cutout
      up(wall) prismoid(size1=[2*points2[0].x,mid_th-2*wall],size2=[2*points2[1].x,mid_th-2*wall],h=h);
      // center cutout
      hull() yflip_copy() xflip_copy() for(p=points4_ext) translate(p) spheroid(r=wall);
      // axel holes
      xcopies(spacing=54) up(39) teardrop(d=pin_d+2*$slop,cap_h=(pin_d+2*$slop)/2+2*$slop,l=s1.y);

      // fix bottom fillets
      xflip_copy() right(points[0].x) xflip() rounding_angled_edge_mask(h=mid_th+0.01,r=2*wall,ang=90+adj_opp_to_ang(points[1].z,points[1].x-points[0].x),orient=BACK);
      // fix inside corners
      let(ang=90+adj_opp_to_ang(points[1].z,points[1].x-points[0].x),p=line_intersection([[points4[0].x,points4[0].z],[points4[1].x,points4[1].z]],[[-s2.x,h],[s2.x,h]]),pp=[p.x+wall/cos(ang-90),0,p.y])
        xflip_copy() translate(pp) rounding_angled_edge_mask(h=s1.y,r=3.5*wall,ang=ang,orient=FRONT);
    }
  }
}

module pin() {
  render()
  difference() {
    union() {
      cyl(d=2*pin_d,h=1.2,anchor=TOP);
      cyl(d=pin_d,h=mid_th+3.5,chamfer1=-0.5,chamfer2=0.5,anchor=BOTTOM);
      up(mid_th+3*$slop) cyl(d1=pin_d+4*$slop,d2=pin_d,l=3.5-3*$slop-0.5,chamfer1=2*$slop,anchor=BOTTOM);
    }

    up(mid_th+3*$slop) cuboid([2*pin_d,5*$slop,6],chamfer=5/3*$slop,edges=BOTTOM);
  }
}

module flex() {
  w1=65;
  w2=42;
  d=20;
  os=5*lw;

  render()
  union() {
    linear_extrude(mid_th-2*wall-2*$slop) difference() {
      xflip_copy() right(w2/2) difference() {
        union() {
          shape();
          // let(th=1.6) translate([-w2/4,-d-th/2]) square([w2/2,th],center=true);
          let(th=3*lw) translate([-w2/2,-d-2]) square([w2/2,th]);
        }

        offset(-os) difference() {
          shape();

          circle(d=12-2*os);
        }
        circle(d=pin_d+4*$slop);
      }
    }

    // adhesion raft
    linear_extrude(0.2) xflip_copy() right(w2/2) difference() {
      offset(3) shape();
      circle(d=pin_d+4*$slop);
    }
  }

  module shape() {
    hull() {
      circle(d=12);
      translate([(w1-w2)/2,-d]) circle(r=2);
      fwd(d-4) square(size=[12,12],center=true);
    }
  }
}
