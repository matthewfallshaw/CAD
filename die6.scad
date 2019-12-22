size=13;

difference() {
  cube(size,center=true);
  for (i=[
    [2,0,[0,1,0]],
    [3,90,[0,1,0]],
    [4,180,[0,1,0]],
    [5,270,[0,1,0]],
    [1,-360/3,[1,1,1]],
    [6,360/3,[1,-1,1]],
  ])
    rotate(a=i[1],v=i[2]) translate([0,0,size/2-1]) linear_extrude(2)
      text(str(i[0]),valign="center",halign="center");  
}