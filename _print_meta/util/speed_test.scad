lt=0.2; // layer thickness
lw=0.4; // line width

tr=10;    // test resolution
layers=5; // layers per test block
blocks=6; // # of blocks

size=(tr+2)*lw*2;
height=layers*lt;

fuzz=0.001;

$fn=128;

module test_block() {
  union() {
    cube([size,size,height-lt]);
    translate([0,0,height-lt]) linear_extrude(lt) test_pattern();
  }
}

module test_pattern() {
  sine_wave();
  translate([tr*lw+2*lw,0]) circ();
  translate([0,tr*lw+2*lw]) square_wave();
  translate([tr*lw+2*lw,tr*lw+2*lw]) triangle();
}

module sine_wave() {
  sr=10; // sine curve resolution multiplier
  translate([lw,tr*lw/2+lw,0]) offset(-fuzz/2) offset(lw/2) polygon(concat(
    [for (i=[0:tr*sr])    [i*lw/sr,sin(i*360/tr/sr)*tr*lw/2]],
    [for (i=[tr*sr:-1:0]) [i*lw/sr,sin(i*360/tr/sr)*tr*lw/2-fuzz]]
  ));
}

module circ() {
  translate([tr*lw/2+lw,tr*lw/2+lw]) difference() {
    circle(d=tr*lw);
    offset(-lw) circle(d=tr*lw);
  }
}

module square_wave() {
  x=[0,0,1,1, 1, 2,2];
  y=[0,1,1,0,-1,-1,0];
  b=reverse([[1,0],[1,-1],[-1,-1],[-1,0],[-1,-1],[1,-1],[1,0]]);
  translate([lw,tr*lw/2+lw]) offset(-fuzz/2) offset(lw/2) polygon(concat(
    [for (i=[0:len(x)-1])    [x[i]*tr*lw/2, y[i]*tr*lw/2   ] ],
    [for (i=[len(x)-1:-1:0]) [x[i]*tr*lw/2+b[i][0]*fuzz, y[i]*tr*lw/2+b[i][1]*fuzz] ]
  ));
}

module triangle() {
  translate([tr*lw/2-lw,tr*lw/2+lw]) difference() {
    offset(lw) circle(d=(tr+1)*lw,$fn=3);
    circle(d=(tr+1)*lw,$fn=3);
  }
}

function reverse(v) = [ for (i=[len(v)-1:-1:0]) v[i] ];


union() {
  difference() {
    // Test blocks
    translate([0,0,-lt]) union() {
      for (i=[0:blocks-1]) {
        translate([i*size,0,i*height]) test_block();
      }
    }
    // Cleaning cut
    translate([-lw,-lw,-lt*2]) cube([size*blocks,size+2*lw,2*lt]);
  }
}
