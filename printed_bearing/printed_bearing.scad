include <BOSL2/std.scad>
include <BOSL2/involute_gears.scad>

         // Part code without shield type suffix
                // Internal diameter
                    // External diameter
                        // Width
                              // Include a cage?
                                     // Gap between rollers and race
pBB608  = [ "608",  8, 22,  7  , false, 0.1]; // 608 bearings for wades

function pb_name(type)           = type[0]; //! Part code without shield type suffix
function pb_bore(type)           = type[1]; //! Internal diameter
function pb_diameter(type)       = type[2]; //! External diameter
function pb_width(type)          = type[3]; //! Width
function pb_cage(type)           = type[4]; //! Gap between rollers and race
function pb_clearance(type)      = type[5]; //! Gap between rollers and race
function pb_roller_count(type)   = 11;      //! Count of rollers
function pb_roller_dia(type)     = (pb_diameter(type)+pb_bore(type))*sin(180/pb_roller_count(type))/2
                                   -pb_clearance(type); //! Diameter of roller rolling surface
function pb_race_thickness(type) = (pb_diameter(type)*(1-sin(180/pb_roller_count(type)))
                                    -pb_bore(type)*(1+sin(180/pb_roller_count(type))))/4
                                   -pb_clearance(type)/2; //! Inner and outer race thickness

module printed_bearing(type) { //! Draw a printable roller bearing
  // stl(str("printed_bearing(pBB", pb_name(type), "): Roller bearing ", pb_name(type),
  //         pb_bore(type), "mm x ", pb_diameter(type), "mm x ", pb_width(type), "mm",
  //         pb_cage(type) ? " with cage" : ""));

  h   = pb_width(type);
  od  = pb_diameter(type);
  id  = pb_bore(type);
  th  = pb_race_thickness(type);
  cl  = pb_clearance(type);
  n   = pb_roller_count(type);

  pitch=2.5;
  bore_teeth=15;

  roller_teeth=6;
  rollers=bore_teeth/3*2;
  rollers_pitch=pitch_radius(pitch=pitch,teeth=roller_teeth);
  echo(pitch_radius=pitch_radius(pitch=pitch,teeth=bore_teeth),outer_radius=outer_radius(pitch=pitch,teeth=bore_teeth));

  zflip_copy() {
    gear(pitch=pitch,teeth=bore_teeth,thickness=h/2,shaft_diam=id,helical=-30,slices=12,anchor=TOP,$fa=1,$fs=1);
    for(i=[0:2:rollers-1]) zrot(360/rollers*i) fwd((pitch_radius(pitch=pitch,teeth=bore_teeth)+rollers_pitch))
      gear(pitch=pitch,teeth=roller_teeth,thickness=h/2,shaft_diam=0,helical=-30,slices=12,anchor=TOP,$fa=1,$fs=1);
  }
  tube(h=h,od=od,id=od-3,anchor=CENTER);

  // color(pp1_colour) {
  //   difference() {
  //     cylinder(h=h, d=od, center=true);

  //     cylinder(h=h+1, d=id, center=true);
  //     rotate_extrude() translate([id/4+od/4,0,0]) _pb_profile(od, id, h, th, cl, rim, n);
  //     // chamfers
  //     difference() {
  //       for(i=[1,-1]) translate([0,0,i*(h/2-extrusion_width)+0.01])
  //         cylinder(h=2*extrusion_width,
  //                  d1=od-2*th-i*2*extrusion_width,
  //                  d2=od-2*th+i*2*extrusion_width,
  //                  center=true);

  //       for(i=[1,-1]) translate([0,0,i*(h/2-extrusion_width)])
  //         cylinder(h=2*extrusion_width+0.01,
  //                  d1=id+2*th+i*2*extrusion_width,
  //                  d2=id+2*th-i*2*extrusion_width,
  //                  center=true);
  //     }
  //   }
  // }
  // for (r=[0:n-1]) color(pp3_colour) rotate([0,0,360/n*r])
  //   translate([id/2+(od/2-id/2)/2,0,0]) printed_bearing_roller(type);

  if($children)
    translate_z(h/2)
      children();
}

printed_bearing(pBB608);
