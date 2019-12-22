use <chamfer.scad>

print_zone=118;

m_width=259;   // major width
m_depth=175;   // major depth
p_line_w=0.4;  // print line width
p_line_h=0.22; // print line height

wall=4*p_line_w;
wall_height=10;

c_buffer=5;
c_knife=220+c_buffer;
c_fork=200+c_buffer;
c_small=150+c_buffer;
c_depth=floor(m_depth/4/p_line_w)*p_line_w;

fit_clearance=0.4;

/*
# Notes
Full space is 259w, 175deep.
Use a hollow octagon fitting into a circle for a press fit.
Knives: 220 long
Forks, spoons: 200 long
Small forks, spoons: 150 long
*/

*puzzleize(  size=[print_zone,c_depth,wall_height],supress_x=[0,1],supress_y=[0,0],index=[0,0])
  knife_tray();
*translate([0,c_depth+1])
  puzzleize(size=[print_zone,c_depth,wall_height],supress_x=[0,1],supress_y=[0,0],index=[0,0])
    fork_tray();

*puzzleize(  size=[print_zone,c_depth,wall_height],supress_x=[0,1],supress_y=[0,0],index=[1,0])
  spoon_tray();
  /* knife_tray(); */
*translate([0,c_depth+1])
  puzzleize(size=[print_zone,c_depth,wall_height],supress_x=[0,1],supress_y=[0,0],index=[1,0])
    smalls_tray();
    /* fork_tray(); */

puzzleize(size=[m_width-c_fork,print_zone,wall_height],supress_x=[0,0],index=[0,0]) {
  gap_tray();
}
translate([m_width-c_fork+1,-90]) puzzleize(size=[m_width-c_fork,print_zone,wall_height],supress_x=[0,0],index=[0,1]) {
  gap_tray();
}
/* knife_tray(); */
/* translate([0,c_depth]) fork_tray(); */
/* translate([0,c_depth*2]) spoon_tray(); */
/* translate([0,c_depth*3]) smalls_tray(); */
/* translate([c_fork,0]) gap_tray(); */

// grid
*for (i = [0:2], j = [0:1]) {
  if (i%2==j%2) {
    translate([print_zone*i,print_zone*j,20]) square([print_zone,print_zone]);
  }
}

module box(w,d) {
  difference() {
    cube([w,d,wall_height]);
    translate([wall,wall,wall]) chamferCube(w-2*wall,d-2*wall,wall_height);
  }
}

module knife_tray() {
  box(c_knife,c_depth);
}

module fork_tray() {
  box(c_fork,c_depth);
}

module spoon_tray() {
  fork_tray();
}

module smalls_tray() {
  fork_tray();
  // box(c_small,c_depth);
}

module gap_tray() {
  shape=[
    [[0,c_depth],        [c_knife-c_fork+1,c_depth*4-c_depth,wall_height]],
    [[c_knife-c_fork,0], [m_width-c_knife,c_depth*4,wall_height]]
  ];
  difference() {
    for (i=shape) translate([i[0][0],i[0][1]]) cube([i[1][0],i[1][1],i[1][2]]);
    union() {
      translate([shape[0][0][0]+wall,shape[0][0][1]+wall,wall])
        cube([shape[0][1][0],shape[0][1][1]-2*wall,shape[1][1][2]]);
      translate([shape[1][0][0]+wall,shape[1][0][1]+wall,wall])
        cube([shape[1][1][0]-2*wall,shape[1][1][1]-2*wall,shape[1][1][2]]);
    }
  }
}

module puzzleize(size=[10,10,5],dovetail_depth,index=[0,0],supress_x=[0],supress_y=[0]) {
  intersection() {
    puzzle_piece(size,dovetail_depth,index,supress_x,supress_y);
    children();
  }

}
// size: [x,y,z] array, size from origin to end of male pins
// dovetail_depth: depth (and width) of pins
// index: index array - which piece to return
// supress_x: index array - [0]: x columns to supress female pins in
//                        - [1] (optional): x columns to supress male pins in
// supress_y: index array - [0]: y columns to supress female pins in
//                        - [1] (optional): y columns to supress male pins in
module puzzle_piece(size,dovetail_depth,index,supress_x,supress_y,fit_clearance=0.2) {
  dd=dovetail_depth ? dovetail_depth : min(size[0],size[1])/7;
  i=index[0];
  j=index[1];
  isf=supress_x[0];
  ism=supress_x[1];
  jsf=supress_y[0];
  jsm=supress_y[1];
  x=size[0]-(i!=ism?dd:0);
  y=size[1]-(j!=jsm?dd:0);
  z=size[2];

  ix=i>0?([ for (a=[0:1:i-1]) size[0]-(a!=ism?dd:0) ]*[ for (l=[0:1:i-1]) 1 ]):0;
  jy=j>0?([ for (b=[0:1:j-1]) size[1]-(b!=jsm?dd:0) ]*[ for (m=[0:1:j-1]) 1 ]):0;
  translate([ix,jy]) {
    difference() {
      union() {  // male pins
        cube([x,y,z]);
        if (i!=ism) translate([x,y/2]) male(y);
        if (j!=jsm) translate([x/2,y]) rotate(90) male(x);
      }
      union() {
        if (i!=isf) translate([0,y/2]) female(y);
        if (j!=jsf) translate([x/2,0]) rotate(90) female(x);
      }
    }
  }

  module male(length) {
    union() {
      translate([0,length/5])  pin();
      translate([0,-length/5]) pin();
    }
  }

  module female(length) {
    union() {
      translate([0,length/5])  slot();
      translate([0,-length/5]) slot();
    }
  }

  module pin_2d() {
    polygon([[0,dd/4],[dd,dd/2],[dd,-dd/2],[0,-dd/4], // dovetail
        [-dd/16,-dd/4],[-dd/16,dd/4]]);               // intersect with base
  }

  module pin() {
    linear_extrude(z) pin_2d();
  }

  module slot($fn=50) {
    difference() {
      translate([0,0,-0.5]) linear_extrude(z+1) offset(delta=fit_clearance) pin_2d();
      translate([1/3*dd, (1/4+1/12)*dd+fit_clearance,wall/2]) sphere(r=fit_clearance);
      translate([1/3*dd,-(1/4+1/12)*dd-fit_clearance,wall/2]) sphere(r=fit_clearance);
      translate([2/3*dd, (1/4+1/6)*dd +fit_clearance,wall/2]) sphere(r=fit_clearance);
      translate([2/3*dd,-(1/4+1/6)*dd -fit_clearance,wall/2]) sphere(r=fit_clearance);
    }
  }
}
