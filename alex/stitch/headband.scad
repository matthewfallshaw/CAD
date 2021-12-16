include <stdlib.scad>
include <BOSL2/beziers.scad>
include <BOSL2/metric_screws.scad>
include <BOSL2/rounding.scad>

// $fn=0;
// $fa=12;
// $fs=2;

// $fn=16;
// $fn=32;
$fn=64;
// $fn=128;

// BIGNUM=100;


MODE = "assy"; // [ band, left_ear, right_ear, joining_pin, assy, _band_spine, help ]
MODES = [ "band", "left_ear", "right_ear", "joining_pin", "assy", str("help") ];

wall=2;
w=2*83;
band_w=20;
head_ellipse_factors=[1,1,1.1];
band_rot=22;
screw_d=4;
raw_ear_scale_factor=5;
rear_band_scale=0.95;

/* [Hidden] */
LL = "left";
RR = "right";

left_ear_tweak = [
  [ 0.707107, -0.000000, -0.707107]
, [ 0.000000,  1.000000, -0.000000]
, [ 0.707107,  0.000000,  0.707107]
];
right_ear_tweak = [
  [ 0.707107, 0.000000, 0.707107]
, [ 0.000000, 1.000000, 0.000000]
, [-0.707107, 0.000000, 0.707107]
];
left_ear_pins = [12,5.2];
right_ear_pins = [-12,5.9];

if(MODE=="assy") assy();
else if(MODE=="band")        xrot(90) band(supports=true);
else if(MODE=="_band_spine") band_spine();
else if(MODE=="left_ear")    left_ear_build();
else if(MODE=="right_ear")   right_ear_build();
else if(MODE=="joining_pin") yrot(90) joining_pin();
else echo(MODES=MODES);


module assy() {
  xrot(band_rot) {
    band();
    right(w/2) left_ear();
    left(w/2) right_ear();
  }
}


function band_path(r_offset) =
  assert(!is_undef(r_offset))

  back_half(
    offset(
      scale([head_ellipse_factors.x,head_ellipse_factors.z,head_ellipse_factors.y],
        ellipse(d=w, $fn=2*$fn)
      )
    , delta=r_offset-wall/2
    )
  , y=-65
  );


module band_mask(w_offset=0, r_offset=0) {
  render()
  union() {
    linear_sweep(band_path(r_offset=r_offset+c_eps), height=BIGNUM, center=true, orient=FRONT);
    band_base(w_offset=w_offset, r_offset=r_offset);
  }
}

module band_base(r_offset=0, w_offset=0) {
  render()
  band_spine(r_offset, w_offset);
}

module band_spine(r_offset=0, w_offset=0) {
  xrot(90) skin(
    [ outline_path(band_path(r_offset=r_offset+0     ), width=  wall)
    , outline_path(band_path(r_offset=r_offset+0     ), width=  wall)
    , outline_path(band_path(r_offset=r_offset+wall/2), width=2*wall)
    , outline_path(band_path(r_offset=r_offset+wall/2), width=2*wall)
    , outline_path(band_path(r_offset=r_offset+0     ), width=  wall)
    , outline_path(band_path(r_offset=r_offset+0     ), width=  wall)
    ]
  , z =
    [ -(w_offset        +band_w/2       )
    , -(w_offset*cos(45)+band_w/4 + wall)
    , -(w_offset*cos(45)+band_w/4       )
    ,  (w_offset*cos(45)+band_w/4       )
    ,  (w_offset*cos(45)+band_w/4 + wall)
    ,  (w_offset        +band_w/2       )
    ]
  , slices = 1
  );
}

module band(supports=false) {
  render()
  union() {
    intersection() {
      difference() {
        union() {
          band_base();
          xrot(-2*band_rot) intersection() {
            scale([1,1,rear_band_scale]) band_base();
            xrot(2*band_rot) fwd(w/2) zrot(45) cuboid(rb3, anchor=FRONT+LEFT);
          }
        }

        xflip_copy() screws_mask(pitch=0);
        down(0.1*65) let(a1=90, a2=2*atan(band_w/w)) for(i=[-1,1]) yrot(i*(a1+a2)/2) scale([0.7,1.2,1]) cyl(d=5, l=BIGNUM, anchor=TOP);

      }
      down(0.1*65) let(a1=90, a2=2*atan(band_w/w)) {
        pie_slice(d=2*w+65, l=BIGNUM, ang=360-a1-a2, spin=-a1/2+a2/2, orient=FRONT, anchor=CENTER, $fn=8);
        for(i=[-1,1]) yrot(i*(a1+a2)/2) cyl(d=band_w, l=BIGNUM, anchor=TOP);
      }
    }

    if(supports) {
      e = scale([1,rear_band_scale], band_path(r_offset=0));
      ec = intersection(e, back(0.70*w, rect(0.98*w)))[0];
      er =
        let(first=ec[0], second=ec[1], length=path_length([first,second]))
        echo(first=first, second=second, length=length)
        (length>0.5*w ? list_rotate(ec, n=1) : ec);
      eo = outline_path(er, width=wall);
      ed3 = up(band_w/2, path3d(eo));
      e3top = fwd(c_lw/2, xrot(90-2*band_rot, ed3));
      ep3 = map(function(x) x-(x*[0,1,0])*[0,1,0]-[0,band_w/2,0], e3top);

      es3 = intersection(path2d(xrot(-90, ep3)), band_path(r_offset=-1.5*wall))[0];
      e3base = fwd(band_w/2, xrot(90, path3d(es3)));
      color("green") difference() {
        skin([e3base, e3top], slices=0, method="fast_distance");
      }
    }
  }
}

module ear(side) {
  assert((side == LL) || (side == RR));

  diff("mask", "pos") {
    // ear
    down(35) scale(raw_ear_scale_factor) tags("pos") {
      if(side == LL) left_ear_raw();
      else           right_ear_raw();
    }

    right((side == LL ? -1 : 1)*w/2) {
      // band seat base
      if(raw_ear_scale_factor < 5)
        tags("pos") intersection() {
          band_base(r_offset=wall+$slop);
          pie_slice(l=BIGNUM, d=2*w, spin=(side == LL ? -35 : 190), ang=25, orient=FRONT, anchor=CENTER, $fn=8);
        }

      tags("mask") {
        band_mask(w_offset=$slop, r_offset=$slop);

        // screws
        if(side == LL) screws_mask();
        else           xflip() screws_mask();
      }
    }
  }
}

module left_ear() {
  render()
  ear(LL);
}

module right_ear() {
  render()
  ear(RR);
}

module left_ear_raw() {
  xrot(-band_rot) zrot(2) translate([0,-0.5,-1.4]) zrot(-10) xrot(205) yrot(90) import("./left.stl");
}

module right_ear_raw() {
  xrot(-band_rot) zrot(3) translate([0,0.5,0]) yrot(-90) zrot(15) import("./right.stl");
}

module screws_mask(pitch) {
  tags("mask")
  for(i=[16,25]) let(yrot=i, len=15+$slop)
    translate(apply(scale(head_ellipse_factors) * xrot(90), point3d(polar_to_xy(r=w/2-wall/2+$slop, theta=-yrot))))
      let(d=get_metric_bolt_head_size(screw_d)+1+$slop) yrot(yrot) render() metric_bolt(size=screw_d, l=len, pitch=pitch, headtype="countersunk", anchor="countersunk", orient=LEFT) {
        attach(TOP, BOTTOM) cyl(d=d, l=5);
        position(TOP) cyl(d1=d-2*2.5, d2=d, l=2.5, anchor=TOP);
      }
}

function outline_path(p, width) =
  // close_path(
    flatten(
      map(
        function(x) force_path(x)
      , [ reverse(offset(p, delta=-width/2)), offset(p, r=width/2) ]
      )
    // )
  );


module ear_build(side) {
  assert(side == LL || side == RR);

  shift = 80;
  sf = raw_ear_scale_factor*300;

  yrot(180)                 bottom_half(sf) down(shift) build();
  fwd(raw_ear_scale_factor*20) top_half(sf) down(shift) build();

  module build() {
    diff("mask", "pos") {
      tags("pos") {
        if(side == LL) render() multmatrix( left_ear_tweak)  left_ear();
        else           render() multmatrix(right_ear_tweak) right_ear();
      }

      tags("mask")
        let(f=raw_ear_scale_factor)
          up(shift) translate((side==LL?left_ear_pins:right_ear_pins)*f) zrot(side==LL?-5:0) xcopies(spacing=4*f, n=3) back($idx==1?f:0) joining_pin(mask=true);
    }
  }
}

module right_ear_build() {
  ear_build(RR);
}

module left_ear_build() {
  ear_build(LL);
}

module joining_pin(mask=false) {
  d=5;

  xrot(-10) {
    if(mask) polycyl(d=d, l=6*6+2+d, chamfer=d/2, realign=true);
    else     left_half(x=d/2-$slop/cos(180/8))
               for(i=[0:5]) zflip_copy() up(i*3+1.5) zflip_copy() cyl(d1=d, d2=d-(mask?0:$slop), l=3/2, anchor=BOTTOM, $fn=8, realign=true);
  }
}
