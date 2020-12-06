include <stdlib.scad>

// $fn=32;
$fn=128;

h1=22.5;
h2=18;
w=236;
d=60;

dia=90;
w_shift=15;
ang=atan((h1-h2)/(w-w_shift));

convexity=12;

                   // back(5) xrot(90) linear_extrude(0.01) scoop_failed(r=0.01,offset= 0);
    // color("red")           xrot(90) linear_extrude(0.01) scoop_failed(r=0.5,offset= 6);
    // color("blue")  fwd(5)  xrot(90) linear_extrude(0.01) scoop_failed(r=0.5,offset=10);

render(convexity=convexity)
difference() {
  // base
  render(convexity=convexity)
    left(w_shift) cuboid([w,d,h1],rounding=1,edges=edges([BOTTOM,"Z"],except=[LEFT,BOTTOM])
                         ,anchor=BOTTOM+LEFT);

  up(h1) {
    yrot(ang) {
      // top slice
      render(convexity=convexity) cuboid([2*w,2*d,h1],anchor=BOTTOM);
      // bottle pocket
      render(convexity=convexity)
        let(z=(dia-sqrt(dia^2-(d-10)^2))/2)
          up(dia/2-z) cyl(d=dia,l=2*(w-w_shift-5),rounding=1,orient=LEFT);
      // fillets
      //   front & back
      render(convexity=convexity) yflip_copy() fwd(d/2) rounding_mask_x(l=2*w,r=1);
      render(convexity=convexity) right(w-w_shift+0.045) {
        // right
        xflip() rounding_angled_edge_mask(h=2*d,r=1,ang=90+ang,orient=FRONT);
        // right corners
        yflip_copy() fwd(d/2) rounding_angled_corner_mask(r=1,ang=90+ang,spin=180,orient=FRONT);
      }
    }
    // left slice
    render(convexity=convexity) yrot(-atan(h1/w_shift)) cuboid([2*w,2*d,h1],anchor=BOTTOM);
  }
  // right clearance hole
  render(convexity=convexity)
    right(w-w_shift-5) cuboid([5,d-2*10,2*h1],rounding=1,edges="Z",anchor=RIGHT);
  // center clearance hole
  render(convexity=convexity)
    right(w-w_shift-5-10) cuboid([w-w_shift-5-10-10,d-2*10,2*h1],rounding=1,edges="Z",anchor=RIGHT);
  // front & back side scoops
  render(convexity=convexity)
    yflip_copy() fwd(d/2) hull() {
              xrot(90) linear_extrude(0.01) scoop(r=0.5,offset= 5);
      back(5) xrot(90) linear_extrude(0.01) scoop(r=0.5,offset=10);
    }
  right(w-w_shift-5) {
    cuboid([5,d   ,10],                        anchor=RIGHT+BOTTOM);
    cuboid([5,d-20,10+1.5],chamfer=1,edges=TOP,anchor=RIGHT+BOTTOM);
  }
}

module scoop_tweaked(r,offset) {
  points=[[-15,0],[w-15,0],[w-15,h2],[0,h1]];
  render(convexity=convexity) difference() {
    minkowski() {
      offset(r) offset(-(offset+r))
        polygon(points=
                 [ line_intersection( [points[0],points[3]]
                                    , [[0,-15],[1,-15]])
                 , line_intersection( [points[1]+[2*offset,0],points[2]+[2*offset,0]]
                                    , [[0,-15],[1,-15]])
                 , line_intersection( [points[1]+[2*offset,0],points[2]+[2*offset,0]]
                                    , [points[3],points[2]])
                 , points[3] ]
               );
        circle(r);
    }

    rect([2*w,2*h1],anchor=BACK);
  }
}

module scoop(r,offset) {
  points=[[-15,0],[w-15,0],[w-15,h2],[0,h1]];
  top_normal=line_normal(points[2],points[3]);
  os_top_line=[points[3]+top_normal*offset,points[2]+top_normal*offset];
  front_normal=line_normal(points[3],points[0]);
  os_front_line=[points[0]+front_normal*offset,points[3]+front_normal*offset];
  hull() {
    translate(line_intersection(os_front_line,[[0,0],[1,0]]))         square([0.01,0.01]);
    translate(points[1])                                              square([0.01,0.01]);
    translate(line_intersection(os_top_line,  [points[1],points[2]])-[0.01,0.01]) square([0.01,0.01]);
    translate(line_intersection(os_top_line,  os_front_line))         circle(r);
  }
}

module scoop_old(r,offset) {
  points=[[-15,0],[w-15,0],[w-15,h2],[0,h1]];
  render(convexity=convexity) difference() {
    minkowski() {
      offset(r) offset(-(offset+r))
        polygon(points=
                 [ line_intersection( [points[0],points[3]]
                                    , [[0,-15],[1,-15]])
                 , line_intersection( [points[1],points[2]]
                                    , [[0,-15],[1,-15]])
                 , [w-15,h2]
                 , [0,h1] ]
               );
        circle(r);
    }

    rect([2*w,2*h1],anchor=BACK);
  }
}
