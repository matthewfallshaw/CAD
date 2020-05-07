include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
use <BOSL/masks.scad>
use <BOSL/math.scad>
use <polyholes.scad>

can_dia=66.5;
tube_dia=2.2;
wall=1.6;
tube_snap_wall=2;

can_tightness=0.0;
tube_tightness=0.0;
tube_snap=1.95/2.1;

cd=can_dia*(1-can_tightness);
td=tube_dia*(1-tube_tightness);
arc_fix=tube_snap_wall/(PI*td)*360;

$fn=64;

union() {
  polytube(h=10, od=cd+wall, id=cd);                                              // main tube
  zmove(5) polytube(h=5, od1=cd+wall, od2=cd-wall, id1=cd, id2=cd-2*wall, align=V_TOP);  // top
  xmove(cd/2+td/2+tube_snap_wall/2) difference() {                                // holder
    polytube(h=10, od=td+tube_snap_wall, id=td, realign=true);
    zrot(-45/2) pie_slice(ang=45,l=10.01,d=cd+wall+0.01,align=V_CENTER);
  }
}
