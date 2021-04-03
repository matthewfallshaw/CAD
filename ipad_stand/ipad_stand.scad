include <stdlib.scad>
include <BOSL2/rounding.scad>
include <BOSL2/metric_screws.scad>

$fn=0;
$fa=8;
$fs=3;
// $fn=64;

// MODE="right5";
// MODE="left5";
// MODE="support5";
// MODE="right3";
// MODE="left3";
// MODE="support3";
// MODE="_ipad_mini5";
// MODE="_ipad_mini3";
// MODE="_blank5";
// MODE="_blank3";
MODE="assy";


BIGNUM=300;

JOINT_CORNER=3;
JOINT_EDGE=4;
MODEL_2_3=[ 200.1,134.7,7.5
          , 12.75,7.15 ];
ipad_dims=[ undef
          , undef               // 1st generation (`ipad_dims[1]`)
          , MODEL_2_3           // 2nd generation (etc.)
          , MODEL_2_3           // 3rd generation
          , undef               // 4th generation
          , [ 203.2,134.8,6.1    // 5th generation
            , 12.62,6.267 ]
          ];
IHOME=0;
HOME_DIA=0;
HOME_PAD=1;
ICAM=1;
CAM_DIA=0;
CAM_PAD=1;
ipad_details=[[10.6,9.5],[3.93,11.2]];  // close enough to same for all models

insert_l=4.2;     // heat press insert length
insert_d=3.7;     // heat press insert hole dia  (interference fit)
insert_bolt_d=3;   // insert screw dia

// iPad 5th gen edge profile from Accessory Design Guidelines
// 7.04,6.13
// 5.91,6.13
// 4.78,6.10
// 3.66,5.96
// 2.60,5.60
// 1.65,4.99
// 0.90,4.16
// 0.39,3.15
// 0.11,2.06
// 0.00,0.94
// 0.94,0.00

desk=[BIGNUM,BIGNUM,27.5];
arm_width=23;
arm_th=13;
inside_wall=6;  // distance between iPad edge and outside of arms
cham=0.5;

cl=0.3;

if(     MODE=="right5")      render() arm_right(model=5);
else if(MODE=="left5")       render() arm_left(model=5);
else if(MODE=="support5")    render() back_support_bar(model=5);
else if(MODE=="right3")      render() arm_right(model=3);
else if(MODE=="left3")       render() arm_left(model=3);
else if(MODE=="support3")    render() back_support_bar(model=3);
else if(MODE=="_ipad_mini5") ipad(model=5);
else if(MODE=="_ipad_mini3") ipad(model=3);
else if(MODE=="_blank5")     blank(model=5,padding=$slop,clearances=true);
else if(MODE=="_blank3")     blank(model=3,padding=$slop,clearances=true);
else {
  model=3;
  right(ipad_dims[model].x/2) render() arm_right(model=model);
  left( ipad_dims[model].x/2) render() arm_left( model=model);
  arm_positions(model=model)  render() back_support_bar(model=model);

  ipad_position(model=model) ipad(model=model);
  desk();
}

module arm_right(model) {
  arm(model=model,side="right");
}

module arm_left(model) {
  xflip() arm(model=model,side="left");
}

function l(model)=ipad_dims[model].y*cos(45)+13;  // length of arm straight sections

module arm(model,side) {
  l=l(model);
  p=path_join([
    [[65,-desk.z-arm_th/2],[-arm_th/2,-desk.z-arm_th/2]],
    [[0,0],                [0,desk.z+arm_th]],
    [[0,0],                [l,l]]
  ],joint=[9,12]);

  render()
  difference() {
    union() {
      // arms
      let(st=offset_stroke(p
                          ,width=arm_th
                          ,start=
                             os_round(cut=1/6*arm_th,k=0.75)
                          ,end=
                             os_round(cut=[3/12*arm_th,1/12*arm_th],k=0.75)
                          )
         )
        left(arm_width-inside_wall) rotate([90,0,90])
          offset_sweep(st
                      ,h=arm_width
                      ,bottom=os_chamfer(cut=cham)
                      ,top=os_chamfer(cut=cham)
                      );
      // back support mounts
      arm_positions(model=model) right(inside_wall-arm_width/2)
        let(insert_back=0.4,l=insert_l+insert_back,ch=2)
          cyl(d=4+2*ch+4*c_lw,l=l,chamfer=ch,anchor=TOP);
      // cable clips
      for(i=[20:20:110]) clip_at_arm_distance_from_end(i);
    }

    // ipad slot and clearances
    ipad_position(model=model) left(ipad_dims[model].x/2)
      blank(model=model,padding=$slop,clearances=true);
    // desk corner cutouts
    cuboid([BIGNUM,BIGNUM,desk.z],chamfer=0.4,anchor=FRONT+TOP);
    // back screw holes
    arm_positions(model=model) right(inside_wall-arm_width/2)
      let(insert_back=0.4)
        down(insert_back) cyl(d=insert_d,l=2*insert_l,anchor=TOP);
    // underside screw holes
    translate([arm_th/2-arm_width/2,0,-(desk.z+arm_th)]) for(i=[40,55]) back(i) {
      cyl(d=4.5,l=2*arm_th);
      metric_bolt(size=4,l=2*arm_th,pitch=0,headtype="countersunk"
                 ,orient=DOWN,anchor="countersunk");
    }
  }

  module clip_at_arm_distance_from_end(l) {
    pos2d=path_pos_from_start(p,l);
    n=pos2d[0];
    d=pos2d[1];
    p1=p[n];
    p2=p[(n+1)%len(p)];
    pt=lerp(p1,p2,d);

    right(inside_wall-arm_width) zrot(90) xrot(90) translate(pt) zrot(ang(p1,p2)) zflip() clip();

    function ang(p1,p2)=let(opp=p2.y-p1.y,adj=p2.x-p1.x)
      atan2(opp,adj);

    module clip() {
      dc=2.75;
      dr=dc+4;
      th=2.4;

      translate([-th/2,0,dr/4-dr/2+dc])
      linear_sweep(
        difference([
          oval(d=dr)

          ,back(dr/2-dc/2,     oval(d=dc))
          ,back(dr/2-dc/2+5/2, rect([1.5,5],center=true))
          ,fwd(dr/2,           rect([dr,dr],center=true))
        ])
        ,height=th
        ,spin=90
        ,orient=RIGHT
      );
    }
  }
}

module back_support_bar(model) {
  arm_l=ipad_dims[model].x+2*inside_wall;
  screw_head=((get_metric_bolt_head_size(size=insert_bolt_d)-insert_bolt_d)/2);
  insert_back=0.4;
  l=insert_l+insert_back;
  ch=2;
  th=l+1+screw_head;

  xflip_copy() right(arm_l/2)
    difference() {
      intersection() {
        cuboid([arm_l/2+1,arm_th,th],chamfer=cham,anchor=TOP+RIGHT);
        translate([-cham,0,ipad_dims[model].z/2+$slop-arm_th/2]) cuboid([arm_l,arm_th,2*th],chamfer=th,edges=[RIGHT+TOP,RIGHT+BOTTOM],anchor=RIGHT);
      }

      left(arm_width/2) {
        // mount clearance
        cyl(d=4+2*ch+4*c_lw+$slop,l=l,chamfer=ch,anchor=TOP);
        // screw clearance hole
        cyl(d=insert_bolt_d+0.2,l=BIGNUM);
        // countersink
        down(th+0.01) metric_bolt(size=insert_bolt_d,l=BIGNUM
                             ,pitch=0,headtype="countersunk",orient=DOWN,anchor="countersunk");
        // arm clearance
        up(ipad_dims[model].z/2+$slop)
          cuboid([arm_width+$slop,arm_th+$slop,arm_th+$slop],chamfer=cham,edges=LEFT+BOTTOM);
      }
    }
}

module arm_positions(model) {
  ipad_position(model=model)
    for(j=[1]) translate([0,j*ipad_dims[model].y/4,-ipad_dims[model].z/2-$slop])
      children();
}

module ipad_position(model) {
  l=l(model)-ipad_dims[model].y/2*cos(45)-(arm_th-ipad_dims[model].z)*2/3*cos(45);

  translate([0,l-arm_th/2,l+arm_th/2])
  xrot(45)
  children();
}

module ipad(model) {
  union() {
    color("green",alpha=0.3) blank(model=model,padding=0,clearances=false);
    up(ipad_dims[model].z/2) {
      // home
      color("grey",0.7) right(ipad_dims[model].x/2-ipad_details[IHOME][HOME_PAD])
        cyl(d=ipad_details[IHOME][HOME_DIA],h=1,chamfer=0.5);
      // camera
      color("red",0.7) left(ipad_dims[model].x/2-ipad_details[ICAM][CAM_PAD])
        cyl(d=ipad_details[ICAM][CAM_DIA],h=1,chamfer=0.5);
      // screen
      color("grey",0.7)
        cuboid(ipad_dims[model]-[2*21,2*6.5,ipad_dims[model].z-0.2],chamfer=0.1);
    }
  }
}

module blank(model,padding=$slop,clearances=true) {
  echo(ipad_model=model
      ,size=ipad_dims[model]
      ,corner_joint=ipad_dims[model][JOINT_CORNER]
      ,edge_joint=ipad_dims[model][JOINT_EDGE]);

  s=ipad_dims[model]+[2*padding,2*padding,2*padding];
  // p=round_corners(rect([s.x,s.y]),method="circle",radius=8);
  p=round_corners(rect([s.x,s.y]),method="smooth",joint=ipad_dims[model][JOINT_CORNER]);

  render()
  up(s.z/2) union() {
    intersection() {
      let(h=10,sc=1.004) up(max(0,h-s.z)) scale([sc,sc,1])
        offset_sweep(p,h=max(s.z,h),bottom=os_smooth(joint=ipad_dims[model][JOINT_EDGE],k=0.5),anchor=TOP);
      offset_sweep(p,h=s.z,top=os_chamfer(cut=0.4),anchor=TOP);
    }
    if(clearances) {
      // charge cable hole
      down(s.z/2) cuboid([BIGNUM,12,ipad_dims[model].z],rounding=1);
      // power button internal clearance
      ycopies(spacing=ipad_dims[model].y-2*14.2) down(s.z)
        cuboid([s.x+2*0.5,15,4],rounding=0.5,anchor=BOTTOM);
      // camera / home button cutout
      let(th=(arm_th-s.z)/2+0.02) xflip_copy()
        right(ipad_dims[model].x/2-(arm_width-inside_wall)) down(0.01)
          side_cutout(width=14,length=26,height=th);
    }
  }

  module side_cutout(width,length,height) {
    p1=pth(width,length);
    mm=min(width,length);

    union() {
      linear_extrude(cham) polygon(p1);
      up(cham) sectn(0,(height-2*cham)/height,add=0);
      up(cham) sectn((height-2*cham)/height,(height-cham)/height,add=cham/2);
    }

    function pth(w,l)=let(j=min(w,l)/2-0.01)
                      round_corners(union(right(w/2,rect([w,  l],center=true))
                                         ,left( w/2,rect([w,2*l],center=true))
                                         )
                                   ,method="smooth"
                                   ,joint=[0,0,0,0,j,j,j,j]
                                   );
    module sectn(scale_from,scale_to,add=0) {
      h1=height*scale_from;
      h2=height*scale_to;
      extrude_from_to([0,0,h1],[0,0,h2],scale=1+((scale_to-scale_from)*height+2*add)/mm) {
        scale(1+scale_from*height/mm) polygon(p1);
      }
    }
  }
}

module desk() {
  // desk top wireframe
  difference() {
    cuboid(desk,anchor=FRONT+TOP);

    translate([0,-0.01,0.01]) cuboid(desk+[0.02,0.02,0.02],chamfer=0.4,anchor=FRONT+TOP);
  }
  // desk front wireframe
  down(27.5+13.5) difference() {
    cuboid([BIGNUM,30,BIGNUM],anchor=FRONT+TOP);

    translate([0,-0.01,0.01])
      cuboid([BIGNUM,30,BIGNUM]+[0.02,0.02,0.02],chamfer=0.4,anchor=FRONT+TOP);
  }
  color("blue", alpha=0.3) {
    cuboid(desk,chamfer=0.4,anchor=FRONT+TOP);
    down(27.5+13.5) cuboid([BIGNUM,30,BIGNUM],chamfer=0.4,anchor=FRONT+TOP);
  }
}
