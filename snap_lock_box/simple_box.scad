include <stdlib.scad>

$fn=64;

lw=0.45;
base=0.8;
cl=0.2;
lid_h=5;
rounding=0;
// rounding=205/2-5;

// s=[57+2*lw,40.5+2*lw,22.5+base];  // bldgs
// s=[26+2*lw,26+2*lw,10.5+base];  // quarry
// s=[2*26+2*lw,26+2*lw,32.5+base];  // plantations
s=[54.5+2*lw,50+2*lw,50.5+base];  // lens wipes
// s=[40.5,40.5,50.5+base];  // solder box
// s=[205,205,14];  // network cable roll

MODE="assy";

if(MODE=="box") shape(box=true);
else if(MODE=="lid") shape(box=false);
else union() {
  color("green") shape(box=true);
  up(s.z+base) yrot(180) shape(box=false);
}

module shape(box) {
  union() {
    ss=s+(box?[0,0,0]:[2*lw+cl,2*lw+cl,lid_h-s.z]);

    if(rounding>0) cuboid(ss,rounding=rounding+(box?0:cl),edges="Z",anchor=BOTTOM);
    else cuboid(ss,edges="Z",anchor=BOTTOM);
    up(box?(s.z-lid_h/2):lid_h/2+base) for(i=[0,180],j=[[0,ss.x/2],[90,ss.y/2]]) zrot(j[0]+i) right(j[1]) yrot(45) cuboid([1,5+(box?0:lw),1],chamfer=0.5,edges=[FRONT,BACK]);
  }
}
