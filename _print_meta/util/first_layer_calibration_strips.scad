include <stdlib.scad>

lw=0.42;
lh=0.2;

strip_width=15;
strip_length=quant(150,lw);
count=5;

sl=quant(strip_length/2,lw)*2+lw;  // ensure odd # of lines

union() {
  spacing=strip_width+2;
  xspread(spacing=spacing,n=count) cuboid([strip_width,sl,lh]);

}
