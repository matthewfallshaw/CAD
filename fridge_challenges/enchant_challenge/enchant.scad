include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
use <BOSL/masks.scad>
use <BOSL/math.scad>

lh=0.1;

w=150;
d=85;
h=up(0.3);

stencil();

module stencil() {
  union() {
    difference() {
      cuboid([w,d,h],align=V_ALLPOS);
      translate([d/2,d/2]) {
        cell(-1, 1) blank();
        cell( 0, 1) book();
        cell( 1, 1) blank();
        cell(-1, 0) diamond();
        cell( 0, 0) obsidian();
        cell( 1, 0) diamond();
        cell(-1,-1) obsidian();
        cell( 0,-1) obsidian();
        cell( 1,-1) obsidian();
      }
      translate([84,d/2]) arrow();
      translate([109+36/2,d/2]) table();
    }
    for(i=[0,w]) for(j=[0,d]) translate([i,j]) magnet_holder();
  }
}

module cell(i,j) {
  cell=22+2.2;

  translate([cell*i,cell*j]) children();
}

module blank() {
  cuboid([22,22,100]);
}

module book() {
  difference() {
    cuboid([22,22,100]);
    linear_extrude(200) polygon([
      [-14,1], [2.1,10.2], [10.1,2.1], [-2.6,-5], [-8.1,0],
      [-8.1,-3], [-2.6,-8.5], [11.7,0], [11.7,-1.9], [-2.6,-10.4],
    ]);
  }
}

module diamond() {
  difference() {
    cuboid([22,22,100]);
    union() {
      diamond_prof();
      cuboid([25,2,100]);
    }
  }
}

module obsidian() {
  difference() {
    cuboid([22,22,100]);
    union() {
      ymove(-2) linear_extrude(200) zmove(-100) projection() xrot(45) zrot(45) scale(0.5) cube(22);
      cuboid([25,2,100]);
    }
  }
}

module arrow() {
  zmove(-50) linear_extrude(100) polygon(points=[
    [0,0],
    [0,2.1],
    [12,2.1],
    [12,9.4],
    [22.2,0],
    [12,-9.4],
    [12,-2.1],
    [0,-2.1],
  ]);
}

module table() {
  difference() {
    difference() {
      cuboid([36,36,100]);
      xspread(n=2,l=28) cuboid([9,2,100]);
    }
    difference() {
      ymove(-3) linear_extrude(200) zmove(-100) projection() scale([0.7,0.6,0.6]) xrot(45) zrot(45) cube(22);
      ymove(-1.5) scale(0.3) diamond_prof();
      ymove(-3) for(i=[-60,60]) zrot(i) ymove(5) cuboid([2,10,300],align=V_BACK);
    }
  }
}

module diamond_prof() {
  scale([0.55,0.6,1]) zrot(45) cuboid([22,22,100]);
}

module magnet_holder() {
  difference() {
    magh=up(3.5/4);

    cyl(d=12,h=2*h+magh,align=V_TOP);
    zmove(h) cyl(d=10,h=magh,align=V_TOP);
    zmove(h) cyl(d=2,h=100,align=V_TOP);
  }
}

function up(x)=ceil(x/lh)*lh;
