include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

lw=0.25;
lh=0.1;

$fn=180;

th=up(0.5);
dia=25;
ring_id=2;
ring_th=up(1.2);
rfid_th=up(1.1);
text_th=up(0.3);

echo(str("th=",th), str("dia=",dia), str("ring_id=",ring_id), str("ring_th=",ring_th), str("rfid_th=",rfid_th));

xdistribute(dia + 5) {
  tag(plus=true)  text("MAC",size=dia*0.24,valign="center",halign="center");
  tag(plus=false) {
    s=0.095*dia;
    l=0.15*dia;
    ymove(-dia/20) {
      ymove(l) text("MATT + LINA",size=s*1.1,valign="center",halign="center");
      text("0417 388 375",size=s,valign="center",halign="center");
      ymove(-l) text("0408 138 369",size=s,valign="center",halign="center");
    }
  }
}

module tag(plus=false) {
  difference() {
    difference() {
      // base
      zmove(plus?-rfid_th:0) linear_extrude(th+(plus?rfid_th:0)) offset(r=-1) union() {
        circle(d=dia+2);
        ymove(dia/2+ring_id/2+0.5) circle(d=ring_id+2*ring_th+2);
      }
      // ring hole
      ymove(dia/2+ring_id/2+0.5) cyl(d=ring_id,h=100,center=true);
      // text
      zmove(text_th) linear_extrude(100) children();
    }
    // clear back for RFID tag
    if (plus) zmove(-rfid_th) cyl(d=dia,h=rfid_th,align=V_TOP);
  }
}

function up(x,e=lh)=ceil(x/e)*e;
