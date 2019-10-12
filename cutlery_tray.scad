m_width=259;   // major width
m_depth=175;   // major depth
p_line_w=0.4; // print line width
p_line_h=0.22; // print line height

wall=4*p_line_w;
wall_height=10;

c_buffer=5;
c_knife=220+c_buffer;
c_fork=200+c_buffer;
c_small=150+c_buffer;
c_width=floor(m_depth/4/p_line_w)*p_line_w;

/*
# Notes
Full space is 259w, 175deep.
Use a hollow octagon fitting into a circle for a press fit.
Knives: 220 long
Forks, spoons: 200 long
Small forks, spoons: 150 long
*/

/* %base(); */
knife_tray();
translate([0,c_width]) fork_tray();
translate([0,c_width*2]) spoon_tray();
translate([0,c_width*3]) smalls_tray();
translate([c_fork,0]) gap_tray();  // TODO

// grid
/* for (i = [0:2], j = [0:1]) { */
/*   if (i%2==j%2) { */
/*     translate([120*i,120*j,20]) square([120,120]); */
/*   } */
/* } */

module box(w,d) {
  difference() {
    cube([w,d,wall_height]);
    translate([wall,wall,wall]) cube([w-2*wall,d-2*wall,wall_height]);
  }
}

module base() {
  cube([m_width,m_depth,1]);
}

module knife_tray() {
  box(c_knife,c_width);
}

module fork_tray() {
  box(c_fork,c_width);
}

module spoon_tray() {
  fork_tray();
}

module smalls_tray() {
  fork_tray();
  // box(c_small,c_width);
}

module gap_tray() {
  shape=[
    [[0,c_width],        [c_knife-c_fork+1,m_depth-c_width,wall_height]],
    [[c_knife-c_fork,0], [m_width-c_knife,m_depth,wall_height]]
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
