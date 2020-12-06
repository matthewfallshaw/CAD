include <stdlib.scad>

$fn=64;

depth=20;
strap_w=25.5;
th=5;
holes=[24,12,4.5,7];
cl=0.3;
steel_th=1.2;

MODE="part";  // ["part", "plug", "assy"]

if(MODE=="part") part();
else if(MODE=="plug") plug();
else union() {
  part();
  up(depth-th-2*cl-steel_th) plug();
  strap();
}

module part(mode) {
  difference() {
    xflip_copy()
      if(!mode) back((strap_w+th)/2) xrot(90) union() {
        linear_extrude(strap_w+th) stroke(path=[[0,depth]
                                               ,[depth/2,depth]
                                               ,[depth*1.5,0]
                                               ,[depth*1.5+depth/3,0]
                                               ]
                                         ,width=th);
        up((strap_w+th)/2) zcopies(l=strap_w+th/2) fwd(th/2)
          prismoid(size1=[depth*1.5+th/2,th/2]
                  ,size2=[depth/2,th/2]
                  ,h=depth+th/2,shift=[-(depth+th)/2,0],orient=BACK,anchor=LEFT+BOTTOM);
      }
      else {
        color("green") cuboid([depth/2-(th/2+steel_th)*cos(45),depth+th,th],anchor=RIGHT);
      }

    // hole
    cyl(d=holes[3]+cl,h=100);
  }
}

module plug() {
  part("plug");
}

module strap() {
  color("gray") difference() {
    down(th/2+steel_th/2+cl) xflip_copy() back(strap_w/2) xrot(90)
      linear_extrude(strap_w)
        stroke(path=[[0,depth]
                    ,[depth/2-(steel_th+2*cl)*cos(45),depth]
                    ,[depth*1.5-(steel_th+2*cl)*cos(45),0]
                    ,[depth*2+depth/3,0]
                    ]
              ,width=steel_th);

    cyl(d=holes[3]+cl,h=100);
  }
}
