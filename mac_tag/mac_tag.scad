include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

lw=0.25;
lh=0.1;

$fn=64;

// Basic config
// (tag text below)
dia=25;
th=up(0.6);
text_th=down(th/2);
ring_id=3;
ring_th=up(1.75);
rfid_th=up(1);

echo(dia=dia,th=th,text_th=text_th,ring_id=ring_id,ring_th=ring_th,rfid_th=rfid_th);

render() {
  *xdistribute(dia + 5) {
    mactag(true);
    mltag(s=0.115*dia,l=0.12*dia,textoffset=0.055);  // TODO plus=false
  }
  *xdistribute(dia + 5) {
    mactag(true);
    tag(plus=false) {
      s=0.10*dia;
      l=0.09*dia;
      ymove(0) {
        ymove( l*1.5) text("LINA", size=s*1.1,valign="center",halign="center");
        ymove(-l*0.8) text("0408 138 369",size=s,valign="center",halign="center");
      }
    }
  }
  toptag(th,zoffset=0);
}

module mactag(plus) {
  assert(!is_undef(plus),"I need a value for `plus` (true or false).");
  tag(plus=plus) text("MAC",size=dia*0.24,valign="center",halign="center");
}

module mltag(plus,s,l,textoffset) {
  for(pp=[[plus,"plus"],[s,"s"],[l,"l"],[textoffset,"textoffset"]]) assert(!is_undef(p[0]), str("Missing ",p[1]));
  assert(!is_undef(plus),"I need a value for `plus` (true or false).");
  tag(plus=plus) {
    offset(r=textoffset) ymove(0) {
      ymove( 2.5*l) text("MATT", size=s*1.1,valign="center",halign="center");
      ymove(     l) text("0417388375",size=s,valign="center",halign="center");
      ymove(    -l) text("0408138369",size=s,valign="center",halign="center");
      ymove(-2.5*l) text("LINA", size=s*1.1,valign="center",halign="center");
    }
  }
}

module tag(plus=false,th=th) {
  ring_shift=-0.1;
  difference() {
    // base
    zmove(plus?-rfid_th:0) linear_extrude(th+(plus?rfid_th:0)) offset(r=-1) union() {
      circle(d=dia+2);
      ymove(dia/2+ring_id/2+ring_shift) circle(d=ring_id+2*ring_th+2);
    }

    // ring hole
    ymove(dia/2+ring_id/2+ring_shift) cyl(d=ring_id,h=100,center=true);
    // text
    zmove(th-text_th) linear_extrude(100) children();
    // clear back for RFID tag
    if (plus) zmove(-rfid_th-1) cyl(d=dia,h=rfid_th+1,align=V_TOP);
  }
}

module toptag(th,zoffset) {
  assert(!is_undef(th),err());
  assert(!is_undef(zoffset),err());
  spread=100;
  union() {
    difference() {
      union() {
        // placement jig
        difference() {
          cyl(h=lh*3,d1=dia+6*lw,d2=dia+2*lw,align=V_TOP);
          zmove(-0.5) linear_extrude(1) offset(r=lw*2) projection(cut=true) tag(plus=true);
        }
        zmove(rfid_th) tag(plus=true);
      }
      // cut for RFID tag
      cyl(h=100,d=dia);
    }
    // tag to print on top of RFID tag
    zmove(rfid_th) tag(plus=false) {
      s=0.115*dia;
      l=0.12*dia;
      offset(r=0.055) ymove(0) {
        ymove( 2.5*l) text("MATT", size=s*1.1,valign="center",halign="center");
        ymove(     l) text("0417388375",size=s,valign="center",halign="center");
        ymove(    -l) text("0408138369",size=s,valign="center",halign="center");
        ymove(-2.5*l) text("LINA", size=s*1.1,valign="center",halign="center");
      }
    }
  }
  function err()=str("I need a value for `th` and `zoffset`. You gave me th=",th," zoffset=",zoffset,".");
}

function up(x,e=lh)=ceil(x/e)*e;
function down(x,e=lh)=floor(x/e)*e;
