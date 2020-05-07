include <stdlib.scad>

$fn=64;

font_size=9;
t=[
  [  0, 15,  1,"DELIVERIES: Please"],
  [  0,  0,  1,"ring the doorbell and"],
  [  0,-15,  1,"   leave over there."],
  [-54,-16.75,1.5,"←"],
];
letter_height=0.6;
wall=1.2;
th=1.2;
w=140;
h=50;

union() {
  difference() {
    down(th) cuboid([w+2*wall,h+2*wall,th+letter_height],chamfer=2+wall*cos(45),edges="Z",anchor=BOTTOM);

    cuboid([w,h,th+0.01],chamfer=2,edges="Z",anchor=BOTTOM);
  }
  linear_extrude(letter_height) union() {
    for(l=t) {
      translate([l[0],l[1]]) scale([l[2],1]) text(l[3],size=font_size,font="Montserrat",halign="center",valign="center");
    }
  }
}
