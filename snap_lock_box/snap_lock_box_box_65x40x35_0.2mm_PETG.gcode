; GCODE POST-PROCESSING PARAMETERS:

; Slic3r Script Variables:
; *allow_empty_layers*  =  0
; *avoid_crossing_not_first_layer*  =  1
; *avoid_crossing_perimeters*  =  0
; *bed_custom_model *  =  /Users/matt/Documents/CAD/_print_meta/_Prusa/Prusa_i3_MK3_PrusaSlicer.stl
; *bed_custom_texture *  =  /Users/matt/Documents/CAD/_print_meta/_Prusa/mk3.svg
; *bed_shape*  =  0
; *bed_temperature*  =  90
; *before_layer_gcode *  =  ;BEFORE_LAYER_CHANGE\nG92 E0.0\n; starting change to layer [layer_num], at [layer_z]mm\n;[layer_z]\n{if layer_z<0.6}\n{elsif layer_z<6}\nM106 S56\n{else}\nM106 S20\n{endif}
; *between_objects_gcode *  =  
; *bottom_fill_pattern *  =  concentricgapfill
; *bottom_solid_layers*  =  4
; *bottom_solid_min_thickness*  =  0.5
; *bridge_acceleration*  =  1000
; *bridge_angle*  =  0
; *bridge_fan_speed*  =  70
; *bridge_flow_ratio*  =  88
; *bridge_overlap*  =  100
; *bridge_speed*  =  28
; *bridged_infill_margin*  =  200
; *brim_ears*  =  1
; *brim_ears_max_angle*  =  125
; *brim_inside_holes*  =  0
; *brim_offset*  =  0
; *brim_width*  =  0
; *brim_width_interior*  =  0
; *chamber_temperature*  =  0
; *clip_multipart_objects*  =  1
; *compatible_printers_condition_cummulative *  =  "printer_notes=~/.*PRINTER_VENDOR_PRUSA3D.*/ and printer_notes=~/.*PRINTER_MODEL_MK3.*/ and nozzle_diameter[0]==0.4";"nozzle_diameter[0]!=0.6 and printer_model!=\"MK2SMM\" and printer_model!=\"MINI\" and ! (printer_notes=~/.*PRINTER_VENDOR_PRUSA3D.*/ and printer_notes=~/.*PRINTER_MODEL_MK(2.5|3).*/ and single_extruder_multi_material)"
; *complete_objects*  =  1
; *complete_objects_one_skirt*  =  1
; *complete_objects_sort *  =  object
; *cooling*  =  1
; *cooling_tube_length*  =  5
; *cooling_tube_retraction*  =  91.5
; *curve_smoothing_angle_concave*  =  0
; *curve_smoothing_angle_convex*  =  0
; *curve_smoothing_cutoff_dist*  =  2
; *curve_smoothing_precision*  =  0
; *default_acceleration*  =  1000
; *default_filament_profile *  =  "Prusa PETG - MF"
; *default_print_profile*  =  0.2
; *deretract_speed*  =  0
; *disable_fan_first_layers*  =  3
; *dont_support_bridges*  =  1
; *draft_shield*  =  0
; *duplicate_distance*  =  4
; *end_filament_gcode *  =  "; Filament-specific end gcode"
; *end_gcode *  =  ; end of print\n; Cribbed from http://projects.ttlexceeded.com/3dprinting_prusaslicer_gcode.html\n; Last updated 20200215\nG4 ; wait\nM117 Printing complete\nG4 ; wait\n; Raise nozzle and present bed\nG92 E0 ; prepare to retract\nG1 E-0.8 F3000; retract to avoid stringing\n; Anti-stringing end wiggle\nG91 ; use relative coordinates\nG0 X-0.5 Y-0.5 F1200\nG0 X1 Y1 F1200\nG90 ; use absolute coordinates\n{if layer_z < max_print_height}G0 Z{z_offset+min(layer_z+60, max_print_height)}{endif} ; Move print head up\nG0 X0 Y210 F10200; present bed\n; Reset print setting overrides\nM200 D0 ; disable volumetric e\nM220 S100 ; reset speed factor to 100%\nM221 S100 ; reset extruder factor to 100%\nM900 K0 ; reset linear acceleration\n; Shut down printer\nM104 S0 ; turn off temperature\nM140 S0 ; turn off heatbed\nM107 ; turn off fan\nM84 ; disable motors\nM300 S40 P10 ; chirp
; *enforce_full_fill_volume*  =  1
; *ensure_vertical_shell_thickness*  =  0
; *exact_last_layer_height*  =  0
; *external perimeters extrusion width *  =  0.45mm
; *external_infill_margin*  =  150
; *external_perimeter_cut_corners*  =  100
; *external_perimeter_extrusion_width*  =  0.45
; *external_perimeter_fan_speed*  =  8
; *external_perimeter_overlap*  =  100
; *external_perimeter_speed*  =  28
; *external_perimeters_first*  =  0
; *external_perimeters_hole*  =  1
; *external_perimeters_nothole*  =  1
; *external_perimeters_vase*  =  0
; *extra_loading_move *  =  -2
; *extra_perimeters*  =  0
; *extra_perimeters_odd_layers*  =  0
; *extra_perimeters_overhangs*  =  0
; *extruder_clearance_height*  =  60
; *extruder_clearance_radius*  =  20
; *extruder_colour *  =  ""
; *extruder_offset*  =  0
; *extrusion_axis *  =  E
; *extrusion_multiplier*  =  1
; *extrusion_width*  =  0.5
; *fan_always_on*  =  1
; *fan_below_layer_time*  =  0
; *fan_speedup_time *  =  -1
; *feature_gcode *  =  
; *filament cost *  =  0.1
; *filament_colour *  =  #FF8000
; *filament_cooling_final_speed*  =  3.4
; *filament_cooling_initial_speed*  =  2.2
; *filament_cooling_moves*  =  4
; *filament_cooling_zone_pause*  =  0
; *filament_cost*  =  32
; *filament_density*  =  1.27
; *filament_diameter*  =  1.75
; *filament_dip_extraction_speed*  =  70
; *filament_dip_insertion_speed*  =  33
; *filament_enable_toolchange_part_fan*  =  0
; *filament_enable_toolchange_temp*  =  0
; *filament_load_time*  =  0
; *filament_loading_speed*  =  28
; *filament_loading_speed_start*  =  3
; *filament_max_volumetric_speed*  =  12
; *filament_max_wipe_tower_speed*  =  0
; *filament_melt_zone_pause*  =  0
; *filament_minimal_purge_on_wipe_tower*  =  15
; *filament_notes *  =  ""
; *filament_ramming_parameters *  =  "120 100 6.6 6.8 7.2 7.6 7.9 8.2 8.7 9.4 9.9 10.0| 0.05 6.6 0.45 6.8 0.95 7.8 1.45 8.3 1.95 9.7 2.45 10 2.95 7.6 3.45 7.6 3.95 7.6 4.45 7.6 4.95 7.6"
; *filament_retract_length*  =  0.4
; *filament_retract_lift*  =  0.2
; *filament_settings_id *  =  "Prusa PETG VASE - MF"
; *filament_skinnydip_distance*  =  31
; *filament_soluble*  =  0
; *filament_toolchange_delay*  =  0
; *filament_toolchange_part_fan_speed*  =  50
; *filament_toolchange_temp*  =  200
; *filament_type *  =  PETG
; *filament_unload_time*  =  0
; *filament_unloading_speed*  =  90
; *filament_unloading_speed_start*  =  100
; *filament_use_fast_skinnydip*  =  0
; *filament_use_skinnydip*  =  0
; *filament_vendor *  =  Made for Prusa
; *filament_wipe_advanced_pigment*  =  0.5
; *fill_angle*  =  45
; *fill_density*  =  0
; *fill_pattern *  =  gyroid
; *fill_smooth_distribution*  =  10
; *fill_smooth_width*  =  50
; *fill_top_flow_ratio*  =  100
; *first layer extrusion width *  =  0.50mm
; *first_layer_acceleration*  =  1000
; *first_layer_bed_temperature*  =  105
; *first_layer_extrusion_width*  =  0.5
; *first_layer_flow_ratio*  =  100
; *first_layer_height*  =  0.2
; *first_layer_infill_speed*  =  25
; *first_layer_size_compensation *  =  -0.2
; *first_layer_speed*  =  20
; *first_layer_temperature*  =  240
; *gap_fill*  =  1
; *gap_fill_min_area*  =  100
; *gap_fill_speed*  =  28
; *gcode_comments*  =  1
; *gcode_flavor *  =  marlin
; *gcode_label_objects*  =  1
; *high_current_on_filament_swap*  =  0
; *hole_size_compensation*  =  0
; *hole_to_polyhole*  =  0
; *host_type *  =  octoprint
; *infill extrusion width *  =  0.45mm
; *infill_acceleration*  =  1250
; *infill_dense*  =  0
; *infill_dense_algo *  =  automatic
; *infill_every_layers*  =  1
; *infill_extruder*  =  1
; *infill_extrusion_width*  =  0.45
; *infill_first*  =  0
; *infill_not_connected*  =  0
; *infill_only_where_needed*  =  0
; *infill_overlap*  =  30
; *infill_speed*  =  28
; *inherits_cummulative *  =  "0.20mm SPEED @MK3";"Prusa PETG";"Original Prusa i3 MK3S"
; *interface_shells*  =  0
; *layer_gcode *  =  ;AFTER_LAYER_CHANGE\n; starting layer [layer_num], at [layer_z]mm\n;[layer_z]\n\nsnap
; *layer_height*  =  0.2
; *machine_max_acceleration_e*  =  5000
; *machine_max_acceleration_extruding*  =  1250
; *machine_max_acceleration_retracting*  =  1250
; *machine_max_acceleration_x*  =  1000
; *machine_max_acceleration_y*  =  1000
; *machine_max_acceleration_z*  =  1000
; *machine_max_feedrate_e*  =  140
; *machine_max_feedrate_x*  =  200
; *machine_max_feedrate_y*  =  200
; *machine_max_feedrate_z*  =  12
; *machine_max_jerk_e*  =  4.5
; *machine_max_jerk_x*  =  8
; *machine_max_jerk_y*  =  8
; *machine_max_jerk_z*  =  0.4
; *machine_min_extruding_rate*  =  0
; *machine_min_travel_rate*  =  0
; *max_fan_speed*  =  22
; *max_layer_height*  =  0.25
; *max_print_height*  =  205
; *max_print_speed*  =  200
; *max_speed_reduction*  =  90
; *max_volumetric_speed*  =  0
; *milling_after_z*  =  200
; *milling_extra_size*  =  150
; *milling_post_process*  =  0
; *milling_speed*  =  30
; *milling_toolchange_end_gcode *  =  
; *milling_toolchange_start_gcode *  =  
; *min_fan_speed*  =  8
; *min_layer_height*  =  0.07
; *min_print_speed*  =  15
; *min_skirt_length*  =  4
; *min_width_top_surface*  =  100
; *model_precision*  =  0.0001
; *no_perimeter_unsupported_algo *  =  bridgesoverhangs
; *notes *  =  
; *nozzle_diameter*  =  0.4
; *only_one_perimeter_top*  =  1
; *only_retract_when_crossing_perimeters*  =  1
; *ooze_prevention*  =  0
; *output_filename_format *  =  {input_filename_base}_{layer_height}mm_{filament_type[0]}.gcode
; *over_bridge_flow_ratio*  =  120
; *overhangs*  =  1
; *overhangs_reverse*  =  1
; *overhangs_reverse_threshold*  =  250
; *overhangs_width*  =  50
; *parking_pos_retraction*  =  92
; *perimeterSpeedBetweenHeightHigh*  =  3.2
; *perimeterSpeedBetweenHeightLow*  =  0.8
; *perimeterSpeedBetweenSpeed*  =  600
; *perimeter_acceleration*  =  800
; *perimeter_bonding*  =  0
; *perimeter_extruder*  =  1
; *perimeter_extrusion_width*  =  0.5
; *perimeter_loop*  =  0
; *perimeter_loop_seam *  =  hidden
; *perimeter_overlap*  =  100
; *perimeter_speed*  =  28
; *perimeters*  =  1
; *perimeters extrusion width *  =  0.50mm
; *post_process *  =  /Users/matt/Documents/CAD/_print_meta/scripts/_otherpeople/Slic3r-Post-Processor-Template/post-processor_perimeter_speed_below_3mm.pl
; *print_extrusion_multiplier*  =  100
; *print_machine_envelope*  =  1
; *print_settings_id*  =  0.2
; *printer_model *  =  MK3S
; *printer_notes *  =  Don't remove the following keywords! These keywords are used in the "compatible printer" condition of the print and filament profiles to link the particular print and filament profiles to this printer profile.\nPRINTER_VENDOR_PRUSA3D\nPRINTER_MODEL_MK3\n
; *printer_settings_id *  =  Original Prusa i3 MK3S VASE - MF
; *printer_technology *  =  FFF
; *printer_variant*  =  0.4
; *printer_vendor *  =  
; *raft_layers*  =  0
; *remaining_times*  =  1
; *resolution*  =  0.02
; *retract_before_travel*  =  1
; *retract_before_wipe*  =  0
; *retract_layer_change*  =  0
; *retract_length*  =  0.8
; *retract_length_toolchange*  =  4
; *retract_lift*  =  0.6
; *retract_lift_above*  =  0
; *retract_lift_below*  =  204
; *retract_lift_not_last_layer*  =  0
; *retract_restart_extra*  =  0
; *retract_restart_extra_toolchange*  =  0
; *retract_speed*  =  35
; *seam_position *  =  near
; *seam_travel*  =  1
; *serial_port *  =  
; *serial_speed*  =  250000
; *silent_mode*  =  1
; *single_extruder_multi_material*  =  0
; *single_extruder_multi_material_priming*  =  0
; *skirt_distance*  =  2
; *skirt_height*  =  1
; *skirts*  =  0
; *slice_closing_radius*  =  0.049
; *slowdown_below_layer_time*  =  0
; *small_perimeter_speed*  =  25
; *solid infill extrusion width *  =  0.70mm
; *solid_fill_pattern *  =  rectilineargapfill
; *solid_infill_below_area*  =  0
; *solid_infill_every_layers*  =  0
; *solid_infill_extruder*  =  1
; *solid_infill_extrusion_width*  =  0.7
; *solid_infill_speed*  =  28
; *spiral_vase*  =  1
; *standby_temperature_delta *  =  -5
; *start_filament_gcode *  =  "M900 K{if nozzle_diameter[0]>=0.6}0.05{else}0.12{endif} ; Filament gcode LA 1.5\n{if printer_notes=~/.*PRINTER_MODEL_MINI.*/};{elsif printer_notes=~/.*PRINTER_HAS_BOWDEN.*/}M900 K200{elsif nozzle_diameter[0]>=0.6}M900 K24{else}M900 K45{endif} ; Filament gcode LA 1.0"
; *start_gcode *  =  ; Cribbed from http://projects.ttlexceeded.com/3dprinting_prusaslicer_gcode.html\n; Last updated 20200215\nM300 S40 P10 ; chirp\nM862.3 P "[printer_model]" ; printer model check\n{if nozzle_diameter[0] == 0.25 or nozzle_diameter[0] == 0.4 or nozzle_diameter[0] == 0.6}M862.1 P[nozzle_diameter] ; nozzle diameter check{endif}\nM115 U3.9.0 ; tell printer latest fw version\nM117 Initializing\n; Set coordinate modes\nG90 ; use absolute coordinates\nM83 ; extruder relative mode\n; Reset speed and extrusion rates\nM200 D0 ; disable volumetric e\nM220 S100 ; reset speed\nM221 S{if layer_height<0.075}100{elsif layer_height>=0.32}90{else}95{endif} ; compensate for extreme layer heights\n; Set initial warmup temps\nM117 Nozzle preheat\nM104 S{min(160,(first_layer_temperature[0]-50))} ; set extruder no-ooze temp\nM140 S{min(first_layer_bed_temperature[0],80)}  ; set bed PINDA warmup temp\n; Nozzle warmup before home to avoid driving hardened ooze into PEI surface\nM109 S{min(160,first_layer_temperature[0]-50)} ; wait for extruder no-ooze warmup temp before mesh bed leveling, cool hot PINDA\nM300 S40 P10 ; chirp\n; Home\nM117 Homing\nG28 W ; home all without mesh bed level\n; Present bed for final cleaning\nG0 Z3; Raise nozzle before move\nG0 X125 Y180 F10200; Move nozzle to PINDA warming position\nG0 Z0.15 F10200; Lower nozzle to PINDA warming position\n; Wait for PINDA warmup\nM117 PINDA warmup\nM860 S35 ; wait for PINDA temp to stabilize\nM140 S[first_layer_bed_temperature] ; set target bed temp\nG0 Z3; Raise nozzle before move\nM300 S40 P10 ; chirp\n; Mesh bed leveling\nM117 Mesh bed leveling\nG80 N7 ; mesh bed leveling\nM117 Saving results\nG81 ; save mesh leveling results\n; Final warmup routine\nM117 Final warmup\nG0 Z5; Raise nozzle to avoid denting bed while nozzle heats\nM140 S[first_layer_bed_temperature] ; set bed final temp\nM104 S[first_layer_temperature] ; set extruder final temp\nM109 S[first_layer_temperature] ; wait for extruder final temp\nM190 S[first_layer_bed_temperature] ; wait for bed final temp\nM300 S40 P10 ; chirp\n; Prime line routine\nM117 Printing prime line\nG0 Z0.15 ; Restore nozzle position - (thanks tim.m30)\nM900 K0; Disable Linear Advance for prime line\nG92 E0.0 ; reset extrusion distance\nG1 Y-3.0 F1000.0 ; go outside print area\nG1 E2 F1000 ; de-retract and push ooze\nG1 X20.0 E{3.1416*nozzle_diameter[0]*nozzle_diameter[0]/4*8+6} F{3.1416*nozzle_diameter[0]*nozzle_diameter[0]/4*3918+508} ; fat 20mm intro line @ 0.30\nG1 X60.0 E{3.1416*nozzle_diameter[0]*nozzle_diameter[0]/4*8+2.2} F{3.1416*nozzle_diameter[0]*nozzle_diameter[0]/4*3918+508} ; thin +40mm intro line @ 0.08\nG1 X100.0 E{3.1416*nozzle_diameter[0]*nozzle_diameter[0]/4*8+7} F{3.1416*nozzle_diameter[0]*nozzle_diameter[0]/4*3918+508} ; fat +40mm intro line @ 0.15\nG1 E-0.8 F3000; retract to avoid stringing\nG1 X99.5 E0 F1000.0 ; -0.5mm wipe action to avoid string\nG1 X110.0 E0 F1000.0 ; +10mm intro line @ 0.00\nG1 E0.6 F1500; de-retract\nG92 E0.0 ; reset extrusion distance\n; Final print adjustments\nM117 Preparing to print\nM300 S40 P10 ; chirp\nM117 Print in progress\n; start of print
; *support_material*  =  0
; *support_material_angle*  =  0
; *support_material_auto*  =  0
; *support_material_buildplate_only*  =  0
; *support_material_contact_distance_bottom*  =  0.1
; *support_material_contact_distance_top*  =  0.1
; *support_material_contact_distance_type *  =  filament
; *support_material_enforce_layers*  =  0
; *support_material_extruder*  =  0
; *support_material_extrusion_width*  =  0.35
; *support_material_interface_contact_loops*  =  0
; *support_material_interface_extruder*  =  0
; *support_material_interface_layers*  =  2
; *support_material_interface_pattern *  =  rectilinear
; *support_material_interface_spacing*  =  0.2
; *support_material_interface_speed*  =  100
; *support_material_pattern *  =  rectilinear
; *support_material_solid_first_layer*  =  0
; *support_material_spacing*  =  2
; *support_material_speed*  =  50
; *support_material_synchronize_layers*  =  0
; *support_material_threshold*  =  50
; *support_material_with_sheath*  =  0
; *support_material_xy_spacing*  =  50
; *temperature*  =  240
; *thin_perimeters*  =  0
; *thin_walls*  =  1
; *thin_walls_merge*  =  1
; *thin_walls_min_width*  =  50
; *thin_walls_overlap*  =  50
; *thin_walls_speed*  =  28
; *threads*  =  16
; *thumbnails *  =  
; *time_estimation_compensation*  =  100
; *toolchange_gcode *  =  
; *top infill extrusion width *  =  0.40mm
; *top_fan_speed*  =  0
; *top_fill_pattern *  =  concentricgapfill
; *top_infill_extrusion_width*  =  0.4
; *top_solid_infill_speed*  =  28
; *top_solid_layers*  =  0
; *top_solid_min_thickness*  =  0.6
; *total filament cost *  =  0.1
; *travel_speed*  =  200
; *use_firmware_retraction*  =  0
; *use_relative_e_distances*  =  1
; *use_volumetric_e*  =  0
; *variable_layer_height*  =  1
; *wipe*  =  1
; *wipe_advanced*  =  0
; *wipe_advanced_algo *  =  linear
; *wipe_advanced_multiplier*  =  60
; *wipe_advanced_nozzle_melted_volume*  =  120
; *wipe_extra_perimeter*  =  0
; *wipe_into_infill*  =  0
; *wipe_into_objects*  =  0
; *wipe_tower*  =  0
; *wipe_tower_bridging*  =  10
; *wipe_tower_brim*  =  150
; *wipe_tower_no_sparse_layers*  =  0
; *wipe_tower_rotation_angle*  =  0
; *wipe_tower_width*  =  60
; *wipe_tower_x*  =  170
; *wipe_tower_y*  =  125
; *wiping_volumes_extruders*  =  70
; *wiping_volumes_matrix*  =  0
; *xy_inner_size_compensation*  =  0
; *xy_size_compensation*  =  0
; *z_offset*  =  0
; *z_step*  =  0.005

; State Script Variables:
; *current_layer_height*  =  9.8
; *current_layer_num*  =  48

; generated by SuperSlicer 2.2.52 on 2020-08-26 at 10:51:42 UTC

; 

; external perimeters extrusion width = 0.45mm
; perimeters extrusion width = 0.50mm
; infill extrusion width = 0.45mm
; solid infill extrusion width = 0.70mm
; top infill extrusion width = 0.40mm
; first layer extrusion width = 0.50mm

; external perimeters extrusion width = 0.45mm
; perimeters extrusion width = 0.50mm
; infill extrusion width = 0.45mm
; solid infill extrusion width = 0.70mm
; top infill extrusion width = 0.40mm
; first layer extrusion width = 0.50mm

; object:{"name":"snap_lock_box_lid_65x40x35","id":"snap_lock_box_lid_65x40x35.stl id:0 copy 0","object_center":[128.946001,104.713650,128.946001],"boundingbox_center":[104.713650,5.000000,69.099998],"boundingbox_size":[44.099998,10.000000,0.000000]}

M73 P0 R17
M73 Q0 S17
M201 X1000 Y1000 Z1000 E5000 ; sets maximum accelerations, mm/sec^2
M203 X200 Y200 Z12 E140 ; sets maximum feedrates, mm/sec
M204 P1250 R1250 T1250 ; sets acceleration (P, T) and retract acceleration (R), mm/sec^2
M566 X8.00 Y8.00 Z0.40 E4.50 ; sets the jerk limits, mm/sec
M205 S0 T0 ; sets the minimum extruding and travel feed rate, mm/sec
M107 ; disable fan
; Cribbed from http://projects.ttlexceeded.com/3dprinting_prusaslicer_gcode.html
; Last updated 20200215
M300 S40 P10 ; chirp
M862.3 P "MK3S" ; printer model check
M862.1 P0.4 ; nozzle diameter check
M115 U3.9.0 ; tell printer latest fw version
M117 Initializing
; Set coordinate modes
G90 ; use absolute coordinates
M83 ; extruder relative mode
; Reset speed and extrusion rates
M200 D0 ; disable volumetric e
M220 S100 ; reset speed
M221 S95 ; compensate for extreme layer heights
; Set initial warmup temps
M117 Nozzle preheat
M104 S160 ; set extruder no-ooze temp
M140 S80  ; set bed PINDA warmup temp
; Nozzle warmup before home to avoid driving hardened ooze into PEI surface
M109 S160 ; wait for extruder no-ooze warmup temp before mesh bed leveling, cool hot PINDA
M300 S40 P10 ; chirp
; Home
M117 Homing
G28 W ; home all without mesh bed level
; Present bed for final cleaning
G0 Z3; Raise nozzle before move
G0 X125 Y180 F10200; Move nozzle to PINDA warming position
G0 Z0.15 F10200; Lower nozzle to PINDA warming position
; Wait for PINDA warmup
M117 PINDA warmup
M860 S35 ; wait for PINDA temp to stabilize
M140 S105 ; set target bed temp
G0 Z3; Raise nozzle before move
M300 S40 P10 ; chirp
; Mesh bed leveling
M117 Mesh bed leveling
G80 N7 ; mesh bed leveling
M117 Saving results
G81 ; save mesh leveling results
; Final warmup routine
M117 Final warmup
G0 Z5; Raise nozzle to avoid denting bed while nozzle heats
M140 S105 ; set bed final temp
M104 S240 ; set extruder final temp
M109 S240 ; wait for extruder final temp
M190 S105 ; wait for bed final temp
M300 S40 P10 ; chirp
; Prime line routine
M117 Printing prime line
G0 Z0.15 ; Restore nozzle position - (thanks tim.m30)
M900 K0; Disable Linear Advance for prime line
G92 E0.0 ; reset extrusion distance
G1 Y-3.0 F1000.0 ; go outside print area
G1 E2 F1000 ; de-retract and push ooze
M73 Q0 S17
M73 P0 R17
G1 X20.0 E7.00531 F1000.35 ; fat 20mm intro line @ 0.30
G1 X60.0 E3.20531 F1000.35 ; thin +40mm intro line @ 0.08
G1 X100.0 E8.00531 F1000.35 ; fat +40mm intro line @ 0.15
G1 E-0.8 F3000; retract to avoid stringing
G1 X99.5 E0 F1000.0 ; -0.5mm wipe action to avoid string
G1 X110.0 E0 F1000.0 ; +10mm intro line @ 0.00
G1 E0.6 F1500; de-retract
G92 E0.0 ; reset extrusion distance
; Final print adjustments
M117 Preparing to print
M300 S40 P10 ; chirp
M117 Print in progress
; start of print
G21 ; set units to millimeters
G90 ; use absolute coordinates
M83 ; use relative distances for extrusion
M900 K0.12 ; Filament gcode LA 1.5
M900 K45 ; Filament gcode LA 1.0
;BEFORE_LAYER_CHANGE
G92 E0.0
0.2;0.2


G1 Z0.200 F12000.000 ; move to next layer (0)
;AFTER_LAYER_CHANGE
; starting layer 0, at 0.2mm
;0.2

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
G1 E-0.40000 F2100.00000 ; retract
G1 Z0.800 F12000.000 ; lift Z
G1 X99.146 Y87.414 ; move to first perimeter point
G1 Z0.200 ; restore layer Z
G1 E0.40000 F2100.00000 ; unretract
M204 S1000 ; adjust acceleration
G1 F1200.000
G1 X158.746 Y87.414 E2.26291 ; perimeter
G1 X158.746 Y87.527 E0.00374 ; perimeter
G1 X158.746 Y87.868 E0.01261 ; perimeter
G1 X158.746 Y122.014 E1.29774 ; perimeter
G1 X158.632 Y122.014 E0.00374 ; perimeter
G1 X158.291 Y122.014 E0.01261 ; perimeter
G1 X99.146 Y122.014 E2.24790 ; perimeter
G1 X99.146 Y121.900 E0.00374 ; perimeter
G1 X99.146 Y121.559 E0.01261 ; perimeter
G1 X99.146 Y87.474 E1.29546 ; perimeter
G1 X99.466 Y87.734 F12000.000 ; move to first infill point
G1 F1500.000
G1 X158.426 Y87.734 E2.24086 ; infill
G1 X158.426 Y121.694 E1.29070 ; infill
G1 X99.466 Y121.694 E2.24086 ; infill
G1 X99.466 Y87.794 E1.28842 ; infill
G1 X99.923 Y88.191 F12000.000 ; move to first infill point
G1 F1500.000
G1 X157.969 Y88.191 E2.20611 ; infill
G1 X157.969 Y121.237 E1.25596 ; infill
G1 X99.923 Y121.237 E2.20611 ; infill
G1 X99.923 Y88.251 E1.25368 ; infill
G1 X100.380 Y88.648 F12000.000 ; move to first infill point
G1 F1500.000
G1 X157.512 Y88.648 E2.17137 ; infill
G1 X157.512 Y120.780 E1.22121 ; infill
G1 X100.380 Y120.780 E2.17137 ; infill
G1 X100.380 Y88.708 E1.21893 ; infill
G1 X100.837 Y89.105 F12000.000 ; move to first infill point
G1 F1500.000
G1 X157.055 Y89.105 E2.13663 ; infill
G1 X157.055 Y120.322 E1.18647 ; infill
G1 X100.837 Y120.322 E2.13663 ; infill
G1 X100.837 Y89.165 E1.18419 ; infill
G1 X101.294 Y89.562 F12000.000 ; move to first infill point
G1 F1500.000
G1 X156.598 Y89.562 E2.10188 ; infill
G1 X156.598 Y119.865 E1.15172 ; infill
G1 X101.294 Y119.865 E2.10188 ; infill
G1 X101.294 Y89.622 E1.14944 ; infill
G1 X101.751 Y90.019 F12000.000 ; move to first infill point
G1 F1500.000
G1 X156.141 Y90.019 E2.06714 ; infill
G1 X156.141 Y119.408 E1.11698 ; infill
G1 X101.751 Y119.408 E2.06714 ; infill
G1 X101.751 Y90.079 E1.11470 ; infill
M73 Q5 S16
G1 X102.208 Y90.476 F12000.000 ; move to first infill point
G1 F1500.000
G1 X155.684 Y90.476 E2.03240 ; infill
M73 P6 R16
G1 X155.684 Y118.951 E1.08224 ; infill
G1 X102.208 Y118.951 E2.03240 ; infill
G1 X102.208 Y90.536 E1.07996 ; infill
G1 X102.665 Y90.933 F12000.000 ; move to first infill point
G1 F1500.000
G1 X155.227 Y90.933 E1.99765 ; infill
G1 X155.227 Y118.494 E1.04749 ; infill
G1 X102.665 Y118.494 E1.99765 ; infill
G1 X102.665 Y90.993 E1.04521 ; infill
G1 X103.123 Y91.390 F12000.000 ; move to first infill point
G1 F1500.000
G1 X154.769 Y91.390 E1.96291 ; infill
G1 X154.769 Y118.037 E1.01275 ; infill
G1 X103.123 Y118.037 E1.96291 ; infill
G1 X103.123 Y91.450 E1.01047 ; infill
G1 X103.580 Y91.847 F12000.000 ; move to first infill point
G1 F1500.000
G1 X154.312 Y91.847 E1.92816 ; infill
G1 X154.312 Y117.580 E0.97801 ; infill
G1 X103.580 Y117.580 E1.92816 ; infill
G1 X103.580 Y91.907 E0.97573 ; infill
G1 X104.037 Y92.304 F12000.000 ; move to first infill point
G1 F1500.000
G1 X153.855 Y92.304 E1.89342 ; infill
G1 X153.855 Y117.123 E0.94326 ; infill
G1 X104.037 Y117.123 E1.89342 ; infill
G1 X104.037 Y92.364 E0.94098 ; infill
G1 X104.494 Y92.761 F12000.000 ; move to first infill point
G1 F1500.000
G1 X153.398 Y92.761 E1.85868 ; infill
G1 X153.398 Y116.666 E0.90852 ; infill
G1 X104.494 Y116.666 E1.85868 ; infill
G1 X104.494 Y92.821 E0.90624 ; infill
G1 X104.951 Y93.219 F12000.000 ; move to first infill point
G1 F1500.000
G1 X152.941 Y93.219 E1.82393 ; infill
G1 X152.941 Y116.209 E0.87377 ; infill
G1 X104.951 Y116.209 E1.82393 ; infill
G1 X104.951 Y93.279 E0.87149 ; infill
G1 X105.408 Y93.676 F12000.000 ; move to first infill point
G1 F1500.000
G1 X152.484 Y93.676 E1.78919 ; infill
G1 X152.484 Y115.752 E0.83903 ; infill
G1 X105.408 Y115.752 E1.78919 ; infill
G1 X105.408 Y93.736 E0.83675 ; infill
G1 X105.865 Y94.133 F12000.000 ; move to first infill point
G1 F1500.000
G1 X152.027 Y94.133 E1.75444 ; infill
G1 X152.027 Y115.295 E0.80429 ; infill
G1 X105.865 Y115.295 E1.75444 ; infill
G1 X105.865 Y94.193 E0.80201 ; infill
G1 X106.322 Y94.590 F12000.000 ; move to first infill point
G1 F1500.000
G1 X151.570 Y94.590 E1.71970 ; infill
G1 X151.570 Y114.838 E0.76954 ; infill
G1 X106.322 Y114.838 E1.71970 ; infill
G1 X106.322 Y94.650 E0.76726 ; infill
G1 X106.779 Y95.047 F12000.000 ; move to first infill point
G1 F1500.000
G1 X151.113 Y95.047 E1.68496 ; infill
M73 Q11 S15
G1 X151.113 Y114.380 E0.73480 ; infill
M73 P11 R15
G1 X106.779 Y114.380 E1.68496 ; infill
G1 X106.779 Y95.107 E0.73252 ; infill
G1 X107.236 Y95.504 F12000.000 ; move to first infill point
G1 F1500.000
G1 X150.656 Y95.504 E1.65021 ; infill
G1 X150.656 Y113.923 E0.70006 ; infill
G1 X107.236 Y113.923 E1.65021 ; infill
G1 X107.236 Y95.564 E0.69778 ; infill
G1 X107.693 Y95.961 F12000.000 ; move to first infill point
G1 F1500.000
G1 X150.199 Y95.961 E1.61547 ; infill
G1 X150.199 Y113.466 E0.66531 ; infill
G1 X107.693 Y113.466 E1.61547 ; infill
G1 X107.693 Y96.021 E0.66303 ; infill
G1 X108.150 Y96.418 F12000.000 ; move to first infill point
G1 F1500.000
G1 X149.742 Y96.418 E1.58073 ; infill
G1 X149.742 Y113.009 E0.63057 ; infill
G1 X108.150 Y113.009 E1.58073 ; infill
G1 X108.150 Y96.478 E0.62829 ; infill
G1 X108.608 Y96.875 F12000.000 ; move to first infill point
G1 F1500.000
G1 X149.284 Y96.875 E1.54598 ; infill
G1 X149.284 Y112.552 E0.59582 ; infill
G1 X108.608 Y112.552 E1.54598 ; infill
G1 X108.608 Y96.935 E0.59354 ; infill
G1 X109.065 Y97.332 F12000.000 ; move to first infill point
G1 F1500.000
G1 X148.827 Y97.332 E1.51124 ; infill
G1 X148.827 Y112.095 E0.56108 ; infill
G1 X109.065 Y112.095 E1.51124 ; infill
G1 X109.065 Y97.392 E0.55880 ; infill
G1 X109.522 Y97.789 F12000.000 ; move to first infill point
G1 F1500.000
G1 X148.370 Y97.789 E1.47649 ; infill
G1 X148.370 Y111.638 E0.52634 ; infill
G1 X109.522 Y111.638 E1.47649 ; infill
G1 X109.522 Y97.849 E0.52406 ; infill
G1 X109.979 Y98.246 F12000.000 ; move to first infill point
G1 F1500.000
G1 X147.913 Y98.246 E1.44175 ; infill
G1 X147.913 Y111.181 E0.49159 ; infill
G1 X109.979 Y111.181 E1.44175 ; infill
G1 X109.979 Y98.306 E0.48931 ; infill
G1 X110.436 Y98.703 F12000.000 ; move to first infill point
G1 F1500.000
G1 X147.456 Y98.703 E1.40701 ; infill
G1 X147.456 Y110.724 E0.45685 ; infill
G1 X110.436 Y110.724 E1.40701 ; infill
G1 X110.436 Y98.763 E0.45457 ; infill
G1 X110.893 Y99.161 F12000.000 ; move to first infill point
G1 F1500.000
G1 X146.999 Y99.161 E1.37226 ; infill
G1 X146.999 Y110.267 E0.42211 ; infill
G1 X110.893 Y110.267 E1.37226 ; infill
G1 X110.893 Y99.221 E0.41982 ; infill
G1 X111.350 Y99.618 F12000.000 ; move to first infill point
G1 F1500.000
G1 X146.542 Y99.618 E1.33752 ; infill
G1 X146.542 Y109.810 E0.38736 ; infill
G1 X111.350 Y109.810 E1.33752 ; infill
G1 X111.350 Y99.678 E0.38508 ; infill
G1 X111.807 Y100.075 F12000.000 ; move to first infill point
G1 F1500.000
G1 X146.085 Y100.075 E1.30278 ; infill
G1 X146.085 Y109.353 E0.35262 ; infill
G1 X111.807 Y109.353 E1.30278 ; infill
G1 X111.807 Y100.135 E0.35034 ; infill
G1 X112.264 Y100.532 F12000.000 ; move to first infill point
G1 F1500.000
G1 X145.628 Y100.532 E1.26803 ; infill
G1 X145.628 Y108.896 E0.31787 ; infill
G1 X112.264 Y108.896 E1.26803 ; infill
G1 X112.264 Y100.592 E0.31559 ; infill
G1 X112.721 Y100.989 F12000.000 ; move to first infill point
G1 F1500.000
G1 X145.171 Y100.989 E1.23329 ; infill
G1 X145.171 Y108.438 E0.28313 ; infill
G1 X112.721 Y108.438 E1.23329 ; infill
G1 X112.721 Y101.049 E0.28085 ; infill
G1 X113.178 Y101.446 F12000.000 ; move to first infill point
G1 F1500.000
G1 X144.714 Y101.446 E1.19854 ; infill
G1 X144.714 Y107.981 E0.24839 ; infill
G1 X113.178 Y107.981 E1.19854 ; infill
M73 Q17 S14
G1 X113.178 Y101.506 E0.24611 ; infill
G1 X113.635 Y101.903 F12000.000 ; move to first infill point
G1 F1500.000
G1 X144.257 Y101.903 E1.16380 ; infill
M73 P17 R14
G1 X144.257 Y107.524 E0.21364 ; infill
G1 X113.635 Y107.524 E1.16380 ; infill
G1 X113.635 Y101.963 E0.21136 ; infill
G1 X114.092 Y102.360 F12000.000 ; move to first infill point
G1 F1500.000
G1 X143.800 Y102.360 E1.12906 ; infill
G1 X143.800 Y107.067 E0.17890 ; infill
G1 X114.092 Y107.067 E1.12906 ; infill
G1 X114.092 Y102.420 E0.17662 ; infill
G1 X114.550 Y102.817 F12000.000 ; move to first infill point
G1 F1500.000
G1 X143.342 Y102.817 E1.09431 ; infill
G1 X143.342 Y106.610 E0.14415 ; infill
G1 X114.550 Y106.610 E1.09431 ; infill
G1 X114.550 Y102.877 E0.14187 ; infill
G1 X115.007 Y103.274 F12000.000 ; move to first infill point
G1 F1500.000
G1 X142.885 Y103.274 E1.05957 ; infill
G1 X142.885 Y106.153 E0.10941 ; infill
G1 X115.007 Y106.153 E1.05957 ; infill
G1 X115.007 Y103.334 E0.10713 ; infill
G1 X115.464 Y103.731 F12000.000 ; move to first infill point
G1 F1500.000
G1 X142.428 Y103.731 E1.02483 ; infill
G1 X142.428 Y105.696 E0.07467 ; infill
G1 X115.464 Y105.696 E1.02483 ; infill
G1 X115.464 Y103.791 E0.07239 ; infill
G1 X115.921 Y104.188 F12000.000 ; move to first infill point
G1 F1500.000
G1 X141.971 Y104.188 E0.99008 ; infill
G1 X141.971 Y105.239 E0.03992 ; infill
G1 X115.921 Y105.239 E0.99008 ; infill
G1 X115.921 Y104.248 E0.03764 ; infill
G1 F9600.000
G1 X117.749 Y104.244 E-0.38000 ; wipe and retract
G1 E-0.02000 F2100.00000 ; retract
G1 Z0.400 F12000.000 ; lift Z
G1 X141.743 Y104.714 ; move to first infill point
G1 Z0.200 ; restore layer Z
G1 E0.40000 F2100.00000 ; unretract
G1 F1200.000
G1 X116.149 Y104.714 E1.26274 ; infill
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
0.4;0.4


G1 Z0.400 F12000.000 ; move to next layer (1)
;AFTER_LAYER_CHANGE
; starting layer 1, at 0.4mm
;0.4

snap
M140 S90 ; set bed temperature
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
G1 E-0.40000 F2100.00000 ; retract
G1 Z0.600 F12000.000 ; lift Z
G1 X98.721 Y104.714 ; move to first perimeter point
G1 Z0.400 ; restore layer Z
G1 E0.40000 F2100.00000 ; unretract
M204 S800 ; adjust acceleration
G1 F1680.000
G1 X98.721 Y87.157 E0.59246 ; perimeter
G1 X98.765 Y87.113 E0.00202 ; perimeter
G1 X98.889 Y86.989 E0.00590 ; perimeter
G1 X98.951 Y86.989 E0.00202 ; perimeter
G1 X99.138 Y86.989 E0.00627 ; perimeter
G1 X159.003 Y86.989 E2.02635 ; perimeter
G1 X159.047 Y87.033 E0.00202 ; perimeter
G1 X159.171 Y87.157 E0.00590 ; perimeter
G1 X159.171 Y87.219 E0.00202 ; perimeter
G1 X159.171 Y87.406 E0.00627 ; perimeter
G1 X159.171 Y122.270 E1.18012 ; perimeter
G1 X159.127 Y122.314 E0.00202 ; perimeter
G1 X159.003 Y122.439 E0.00590 ; perimeter
G1 X158.941 Y122.439 E0.00202 ; perimeter
G1 X158.754 Y122.439 E0.00627 ; perimeter
G1 X98.889 Y122.439 E2.02635 ; perimeter
G1 X98.845 Y122.395 E0.00202 ; perimeter
G1 X98.721 Y122.270 E0.00590 ; perimeter
G1 X98.721 Y122.208 E0.00202 ; perimeter
G1 X98.721 Y122.021 E0.00627 ; perimeter
G1 X98.721 Y104.774 E0.58382 ; perimeter
M204 S1000 ; adjust acceleration
G1 F9600.000
G1 X98.721 Y102.945 E-0.38000 ; wipe and retract
G1 E-0.02000 F2100.00000 ; retract
G1 Z0.600 F12000.000 ; lift Z
G1 X157.635 Y122.231 ; move to first infill point
G1 Z0.400 ; restore layer Z
G1 E0.40000 F2100.00000 ; unretract
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X158.667 Y121.198 E0.07978 ; infill
G1 X158.667 Y120.269 E0.05077 ; infill
G1 X157.001 Y121.935 E0.12874 ; infill
G1 X156.072 Y121.935 E0.05077 ; infill
G1 X158.667 Y119.340 E0.20054 ; infill
G1 X158.667 Y118.411 E0.05077 ; infill
G1 X155.143 Y121.935 E0.27234 ; infill
G1 X154.214 Y121.935 E0.05077 ; infill
G1 X158.667 Y117.481 E0.34414 ; infill
G1 X158.667 Y116.552 E0.05077 ; infill
G1 X153.284 Y121.935 E0.41594 ; infill
G1 X152.355 Y121.935 E0.05077 ; infill
G1 X158.667 Y115.623 E0.48774 ; infill
G1 X158.667 Y114.694 E0.05077 ; infill
G1 X151.426 Y121.935 E0.55954 ; infill
G1 X150.497 Y121.935 E0.05077 ; infill
G1 X158.667 Y113.764 E0.63134 ; infill
G1 X158.667 Y112.835 E0.05077 ; infill
G1 X149.567 Y121.935 E0.70314 ; infill
G1 X148.638 Y121.935 E0.05077 ; infill
G1 X158.667 Y111.906 E0.77494 ; infill
G1 X158.667 Y110.977 E0.05077 ; infill
G1 X147.709 Y121.935 E0.84675 ; infill
G1 X146.780 Y121.935 E0.05077 ; infill
G1 X158.667 Y110.047 E0.91855 ; infill
G1 X158.667 Y109.118 E0.05077 ; infill
G1 X145.850 Y121.935 E0.99035 ; infill
G1 X144.921 Y121.935 E0.05077 ; infill
G1 X158.667 Y108.189 E1.06215 ; infill
G1 X158.667 Y107.260 E0.05077 ; infill
G1 X143.992 Y121.935 E1.13395 ; infill
G1 X143.063 Y121.935 E0.05077 ; infill
G1 X158.667 Y106.330 E1.20575 ; infill
G1 X158.667 Y105.401 E0.05077 ; infill
G1 X142.133 Y121.935 E1.27755 ; infill
G1 X141.204 Y121.935 E0.05077 ; infill
G1 X158.667 Y104.472 E1.34935 ; infill
G1 X158.667 Y103.543 E0.05077 ; infill
G1 X140.275 Y121.935 E1.42115 ; infill
G1 X139.346 Y121.935 E0.05077 ; infill
G1 X158.667 Y102.613 E1.49295 ; infill
G1 X158.667 Y101.684 E0.05077 ; infill
G1 X138.416 Y121.935 E1.56475 ; infill
G1 X137.487 Y121.935 E0.05077 ; infill
G1 X158.667 Y100.755 E1.63655 ; infill
G1 X158.667 Y99.826 E0.05077 ; infill
G1 X136.558 Y121.935 E1.70836 ; infill
G1 X135.629 Y121.935 E0.05077 ; infill
G1 X158.667 Y98.896 E1.78016 ; infill
G1 X158.667 Y97.967 E0.05077 ; infill
G1 X134.699 Y121.935 E1.85196 ; infill
G1 X133.770 Y121.935 E0.05077 ; infill
G1 X158.667 Y97.038 E1.92376 ; infill
G1 X158.667 Y96.109 E0.05077 ; infill
G1 X132.841 Y121.935 E1.99556 ; infill
G1 X131.912 Y121.935 E0.05077 ; infill
G1 X158.667 Y95.179 E2.06736 ; infill
G1 X158.667 Y94.250 E0.05077 ; infill
G1 X130.982 Y121.935 E2.13916 ; infill
G1 X130.053 Y121.935 E0.05077 ; infill
G1 X158.667 Y93.321 E2.21096 ; infill
G1 X158.667 Y92.392 E0.05077 ; infill
G1 X129.124 Y121.935 E2.28276 ; infill
G1 X128.195 Y121.935 E0.05077 ; infill
G1 X158.667 Y91.462 E2.35456 ; infill
G1 X158.667 Y90.533 E0.05077 ; infill
G1 X127.265 Y121.935 E2.42636 ; infill
G1 X126.336 Y121.935 E0.05077 ; infill
G1 X158.667 Y89.604 E2.49817 ; infill
G1 X158.667 Y88.675 E0.05077 ; infill
G1 X125.407 Y121.935 E2.56997 ; infill
G1 X124.478 Y121.935 E0.05077 ; infill
G1 X158.667 Y87.745 E2.64177 ; infill
M73 Q23 S13
G1 X158.667 Y87.492 E0.01383 ; infill
G1 X157.991 Y87.492 E0.03694 ; infill
G1 X123.548 Y121.935 E2.66132 ; infill
M73 P23 R13
G1 X122.619 Y121.935 E0.05077 ; infill
G1 X157.062 Y87.492 E2.66132 ; infill
G1 X156.133 Y87.492 E0.05077 ; infill
G1 X121.690 Y121.935 E2.66132 ; infill
G1 X120.761 Y121.935 E0.05077 ; infill
G1 X155.204 Y87.492 E2.66132 ; infill
G1 X154.274 Y87.492 E0.05077 ; infill
G1 X119.831 Y121.935 E2.66132 ; infill
G1 X118.902 Y121.935 E0.05077 ; infill
G1 X153.345 Y87.492 E2.66132 ; infill
G1 X152.416 Y87.492 E0.05077 ; infill
G1 X117.973 Y121.935 E2.66132 ; infill
G1 X117.044 Y121.935 E0.05077 ; infill
G1 X151.487 Y87.492 E2.66132 ; infill
G1 X150.557 Y87.492 E0.05077 ; infill
G1 X116.114 Y121.935 E2.66132 ; infill
G1 X115.185 Y121.935 E0.05077 ; infill
G1 X149.628 Y87.492 E2.66132 ; infill
G1 X148.699 Y87.492 E0.05077 ; infill
G1 X114.256 Y121.935 E2.66132 ; infill
G1 X113.327 Y121.935 E0.05077 ; infill
G1 X147.770 Y87.492 E2.66132 ; infill
G1 X146.840 Y87.492 E0.05077 ; infill
G1 X112.397 Y121.935 E2.66132 ; infill
G1 X111.468 Y121.935 E0.05077 ; infill
G1 X145.911 Y87.492 E2.66132 ; infill
G1 X144.982 Y87.492 E0.05077 ; infill
G1 X110.539 Y121.935 E2.66132 ; infill
G1 X109.610 Y121.935 E0.05077 ; infill
G1 X144.053 Y87.492 E2.66132 ; infill
G1 X143.123 Y87.492 E0.05077 ; infill
G1 X108.680 Y121.935 E2.66132 ; infill
G1 X107.751 Y121.935 E0.05077 ; infill
G1 X142.194 Y87.492 E2.66132 ; infill
G1 X141.265 Y87.492 E0.05077 ; infill
G1 X106.822 Y121.935 E2.66132 ; infill
G1 X105.893 Y121.935 E0.05077 ; infill
G1 X140.336 Y87.492 E2.66132 ; infill
G1 X139.406 Y87.492 E0.05077 ; infill
G1 X104.963 Y121.935 E2.66132 ; infill
G1 X104.034 Y121.935 E0.05077 ; infill
G1 X138.477 Y87.492 E2.66132 ; infill
G1 X137.548 Y87.492 E0.05077 ; infill
G1 X103.105 Y121.935 E2.66132 ; infill
G1 X102.176 Y121.935 E0.05077 ; infill
G1 X136.619 Y87.492 E2.66132 ; infill
G1 X135.689 Y87.492 E0.05077 ; infill
G1 X101.246 Y121.935 E2.66132 ; infill
G1 X100.317 Y121.935 E0.05077 ; infill
G1 X134.760 Y87.492 E2.66132 ; infill
G1 X133.831 Y87.492 E0.05077 ; infill
G1 X99.388 Y121.935 E2.66132 ; infill
G1 X99.225 Y121.935 E0.00892 ; infill
G1 X99.225 Y121.169 E0.04185 ; infill
G1 X132.902 Y87.492 E2.60214 ; infill
G1 X131.972 Y87.492 E0.05077 ; infill
G1 X99.225 Y120.240 E2.53034 ; infill
G1 X99.225 Y119.311 E0.05077 ; infill
G1 X131.043 Y87.492 E2.45854 ; infill
G1 X130.114 Y87.492 E0.05077 ; infill
G1 X99.225 Y118.381 E2.38674 ; infill
G1 X99.225 Y117.452 E0.05077 ; infill
G1 X129.185 Y87.492 E2.31494 ; infill
G1 X128.255 Y87.492 E0.05077 ; infill
G1 X99.225 Y116.523 E2.24314 ; infill
G1 X99.225 Y115.594 E0.05077 ; infill
G1 X127.326 Y87.492 E2.17133 ; infill
G1 X126.397 Y87.492 E0.05077 ; infill
G1 X99.225 Y114.664 E2.09953 ; infill
M73 Q29 S12
G1 X99.225 Y113.735 E0.05077 ; infill
G1 X125.468 Y87.492 E2.02773 ; infill
M73 P29 R12
G1 X124.538 Y87.492 E0.05077 ; infill
G1 X99.225 Y112.806 E1.95593 ; infill
G1 X99.225 Y111.877 E0.05077 ; infill
G1 X123.609 Y87.492 E1.88413 ; infill
G1 X122.680 Y87.492 E0.05077 ; infill
G1 X99.225 Y110.947 E1.81233 ; infill
G1 X99.225 Y110.018 E0.05077 ; infill
G1 X121.751 Y87.492 E1.74053 ; infill
G1 X120.821 Y87.492 E0.05077 ; infill
G1 X99.225 Y109.089 E1.66873 ; infill
G1 X99.225 Y108.160 E0.05077 ; infill
G1 X119.892 Y87.492 E1.59693 ; infill
G1 X118.963 Y87.492 E0.05077 ; infill
G1 X99.225 Y107.230 E1.52513 ; infill
G1 X99.225 Y106.301 E0.05077 ; infill
G1 X118.034 Y87.492 E1.45333 ; infill
G1 X117.104 Y87.492 E0.05077 ; infill
G1 X99.225 Y105.372 E1.38152 ; infill
G1 X99.225 Y104.443 E0.05077 ; infill
G1 X116.175 Y87.492 E1.30972 ; infill
G1 X115.246 Y87.492 E0.05077 ; infill
G1 X99.225 Y103.513 E1.23792 ; infill
G1 X99.225 Y102.584 E0.05077 ; infill
G1 X114.317 Y87.492 E1.16612 ; infill
G1 X113.387 Y87.492 E0.05077 ; infill
G1 X99.225 Y101.655 E1.09432 ; infill
G1 X99.225 Y100.726 E0.05077 ; infill
G1 X112.458 Y87.492 E1.02252 ; infill
G1 X111.529 Y87.492 E0.05077 ; infill
G1 X99.225 Y99.796 E0.95072 ; infill
G1 X99.225 Y98.867 E0.05077 ; infill
G1 X110.600 Y87.492 E0.87892 ; infill
G1 X109.670 Y87.492 E0.05077 ; infill
G1 X99.225 Y97.938 E0.80712 ; infill
G1 X99.225 Y97.009 E0.05077 ; infill
G1 X108.741 Y87.492 E0.73532 ; infill
G1 X107.812 Y87.492 E0.05077 ; infill
G1 X99.225 Y96.079 E0.66352 ; infill
G1 X99.225 Y95.150 E0.05077 ; infill
G1 X106.883 Y87.492 E0.59172 ; infill
G1 X105.953 Y87.492 E0.05077 ; infill
G1 X99.225 Y94.221 E0.51991 ; infill
G1 X99.225 Y93.292 E0.05077 ; infill
G1 X105.024 Y87.492 E0.44811 ; infill
G1 X104.095 Y87.492 E0.05077 ; infill
G1 X99.225 Y92.362 E0.37631 ; infill
G1 X99.225 Y91.433 E0.05077 ; infill
G1 X103.166 Y87.492 E0.30451 ; infill
G1 X102.236 Y87.492 E0.05077 ; infill
G1 X99.225 Y90.504 E0.23271 ; infill
G1 X99.225 Y89.575 E0.05077 ; infill
G1 X101.307 Y87.492 E0.16091 ; infill
G1 X100.378 Y87.492 E0.05077 ; infill
G1 X99.225 Y88.645 E0.08911 ; infill
G1 X99.225 Y87.716 E0.05077 ; infill
G1 X99.744 Y87.196 E0.04016 ; infill
M204 S1000 ; adjust acceleration
G1 F9600.000
G1 X99.225 Y87.716 E-0.15273 ; wipe and retract
G1 X99.225 Y88.645 E-0.19311 ; wipe and retract
G1 X99.341 Y88.529 E-0.03416 ; wipe and retract
G1 E-0.02000 F2100.00000 ; retract
G1 Z0.600 F12000.000 ; lift Z
G1 X158.636 Y122.264 ; move to first infill point
G1 Z0.400 ; restore layer Z
G1 E0.40000 F2100.00000 ; unretract
G1 F1680.000
G1 X158.648 Y122.225 E0.00285 ; infill
G1 X158.661 Y122.186 E0.00268 ; infill
G1 X158.673 Y122.147 E0.00251 ; infill
G1 X158.686 Y122.108 E0.00235 ; infill
G1 X158.699 Y122.069 E0.00218 ; infill
G1 X158.711 Y122.030 E0.00202 ; infill
G1 X158.744 Y121.943 E0.00424 ; infill
G1 X158.764 Y121.894 E0.00219 ; infill
G1 X158.784 Y121.845 E0.00200 ; infill
G1 X158.805 Y121.796 E0.00180 ; infill
G1 X158.825 Y121.747 E0.00160 ; infill
G1 X158.845 Y121.699 E0.00140 ; infill
G1 X158.865 Y121.650 E0.00121 ; infill
G1 X158.886 Y121.601 E0.00101 ; infill
G1 X158.906 Y121.552 E0.00081 ; infill
G1 X158.926 Y121.503 E0.00062 ; infill
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
0.6;0.6

M106 S56

G1 Z0.600 F12000.000 ; move to next layer (2)
;AFTER_LAYER_CHANGE
; starting layer 2, at 0.6mm
;0.6

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
G1 X159.371 Y121.503 ; move to first perimeter point
M204 S800 ; adjust acceleration
G1 F1680.000
G1 X159.371 Y122.270 E0.02415 ; perimeter
G1 X159.327 Y122.314 E0.00202 ; perimeter
G1 X159.195 Y122.447 E0.00627 ; perimeter
G1 X159.003 Y122.639 E0.00920 ; perimeter
G1 X158.941 Y122.639 E0.00202 ; perimeter
G1 X158.754 Y122.639 E0.00627 ; perimeter
G1 X98.889 Y122.639 E2.02635 ; perimeter
G1 X98.845 Y122.595 E0.00202 ; perimeter
G1 X98.713 Y122.463 E0.00627 ; perimeter
G1 X98.521 Y122.270 E0.00920 ; perimeter
G1 X98.521 Y122.208 E0.00202 ; perimeter
G1 X98.521 Y122.021 E0.00627 ; perimeter
G1 X98.521 Y87.157 E1.18012 ; perimeter
G1 X98.565 Y87.113 E0.00202 ; perimeter
G1 X98.697 Y86.981 E0.00627 ; perimeter
G1 X98.889 Y86.789 E0.00920 ; perimeter
G1 X98.951 Y86.789 E0.00202 ; perimeter
G1 X99.138 Y86.789 E0.00627 ; perimeter
G1 X159.003 Y86.789 E2.02635 ; perimeter
G1 X159.047 Y86.833 E0.00202 ; perimeter
G1 X159.179 Y86.965 E0.00627 ; perimeter
G1 X159.371 Y87.157 E0.00920 ; perimeter
G1 X159.371 Y87.219 E0.00202 ; perimeter
G1 X159.371 Y87.406 E0.00627 ; perimeter
G1 X159.371 Y121.443 E1.15213 ; perimeter
M204 S1000 ; adjust acceleration
G1 F9600.000
G1 X159.371 Y122.270 E-0.17188 ; wipe and retract
G1 X159.003 Y122.639 E-0.10821 ; wipe and retract
G1 X158.522 Y122.639 E-0.09991 ; wipe and retract
G1 E-0.02000 F2100.00000 ; retract
G1 Z0.800 F12000.000 ; lift Z
G1 X158.963 Y88.525 ; move to first infill point
G1 Z0.600 ; restore layer Z
G1 E0.40000 F2100.00000 ; unretract
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X157.931 Y87.492 E0.07978 ; infill
G1 X157.001 Y87.492 E0.05077 ; infill
G1 X158.667 Y89.158 E0.12874 ; infill
G1 X158.667 Y90.088 E0.05077 ; infill
G1 X156.072 Y87.492 E0.20054 ; infill
G1 X155.143 Y87.492 E0.05077 ; infill
G1 X158.667 Y91.017 E0.27234 ; infill
G1 X158.667 Y91.946 E0.05077 ; infill
G1 X154.214 Y87.492 E0.34414 ; infill
G1 X153.284 Y87.492 E0.05077 ; infill
G1 X158.667 Y92.875 E0.41594 ; infill
G1 X158.667 Y93.805 E0.05077 ; infill
G1 X152.355 Y87.492 E0.48774 ; infill
G1 X151.426 Y87.492 E0.05077 ; infill
G1 X158.667 Y94.734 E0.55954 ; infill
G1 X158.667 Y95.663 E0.05077 ; infill
G1 X150.497 Y87.492 E0.63134 ; infill
G1 X149.567 Y87.492 E0.05077 ; infill
G1 X158.667 Y96.592 E0.70314 ; infill
G1 X158.667 Y97.522 E0.05077 ; infill
G1 X148.638 Y87.492 E0.77494 ; infill
G1 X147.709 Y87.492 E0.05077 ; infill
G1 X158.667 Y98.451 E0.84675 ; infill
G1 X158.667 Y99.380 E0.05077 ; infill
G1 X146.780 Y87.492 E0.91855 ; infill
G1 X145.850 Y87.492 E0.05077 ; infill
G1 X158.667 Y100.309 E0.99035 ; infill
G1 X158.667 Y101.239 E0.05077 ; infill
G1 X144.921 Y87.492 E1.06215 ; infill
G1 X143.992 Y87.492 E0.05077 ; infill
G1 X158.667 Y102.168 E1.13395 ; infill
G1 X158.667 Y103.097 E0.05077 ; infill
G1 X143.063 Y87.492 E1.20575 ; infill
G1 X142.133 Y87.492 E0.05077 ; infill
G1 X158.667 Y104.026 E1.27755 ; infill
G1 X158.667 Y104.956 E0.05077 ; infill
G1 X141.204 Y87.492 E1.34935 ; infill
G1 X140.275 Y87.492 E0.05077 ; infill
G1 X158.667 Y105.885 E1.42115 ; infill
G1 X158.667 Y106.814 E0.05077 ; infill
G1 X139.346 Y87.492 E1.49295 ; infill
G1 X138.416 Y87.492 E0.05077 ; infill
G1 X158.667 Y107.743 E1.56475 ; infill
G1 X158.667 Y108.673 E0.05077 ; infill
G1 X137.487 Y87.492 E1.63655 ; infill
G1 X136.558 Y87.492 E0.05077 ; infill
G1 X158.667 Y109.602 E1.70836 ; infill
G1 X158.667 Y110.531 E0.05077 ; infill
G1 X135.629 Y87.492 E1.78016 ; infill
G1 X134.699 Y87.492 E0.05077 ; infill
G1 X158.667 Y111.460 E1.85196 ; infill
G1 X158.667 Y112.390 E0.05077 ; infill
G1 X133.770 Y87.492 E1.92376 ; infill
G1 X132.841 Y87.492 E0.05077 ; infill
G1 X158.667 Y113.319 E1.99556 ; infill
G1 X158.667 Y114.248 E0.05077 ; infill
G1 X131.912 Y87.492 E2.06736 ; infill
G1 X130.982 Y87.492 E0.05077 ; infill
G1 X158.667 Y115.177 E2.13916 ; infill
G1 X158.667 Y116.107 E0.05077 ; infill
G1 X130.053 Y87.492 E2.21096 ; infill
G1 X129.124 Y87.492 E0.05077 ; infill
G1 X158.667 Y117.036 E2.28276 ; infill
G1 X158.667 Y117.965 E0.05077 ; infill
G1 X128.195 Y87.492 E2.35456 ; infill
G1 X127.265 Y87.492 E0.05077 ; infill
G1 X158.667 Y118.894 E2.42636 ; infill
G1 X158.667 Y119.824 E0.05077 ; infill
G1 X126.336 Y87.492 E2.49817 ; infill
M73 Q35 S11
G1 X125.407 Y87.492 E0.05077 ; infill
G1 X158.667 Y120.753 E2.56997 ; infill
M73 P35 R11
G1 X158.667 Y121.682 E0.05077 ; infill
G1 X124.478 Y87.492 E2.64177 ; infill
G1 X123.548 Y87.492 E0.05077 ; infill
G1 X157.991 Y121.935 E2.66132 ; infill
G1 X157.062 Y121.935 E0.05077 ; infill
G1 X122.619 Y87.492 E2.66132 ; infill
G1 X121.690 Y87.492 E0.05077 ; infill
G1 X156.133 Y121.935 E2.66132 ; infill
G1 X155.204 Y121.935 E0.05077 ; infill
G1 X120.761 Y87.492 E2.66132 ; infill
G1 X119.831 Y87.492 E0.05077 ; infill
G1 X154.274 Y121.935 E2.66132 ; infill
G1 X153.345 Y121.935 E0.05077 ; infill
G1 X118.902 Y87.492 E2.66132 ; infill
G1 X117.973 Y87.492 E0.05077 ; infill
G1 X152.416 Y121.935 E2.66132 ; infill
G1 X151.487 Y121.935 E0.05077 ; infill
G1 X117.044 Y87.492 E2.66132 ; infill
G1 X116.114 Y87.492 E0.05077 ; infill
G1 X150.557 Y121.935 E2.66132 ; infill
G1 X149.628 Y121.935 E0.05077 ; infill
G1 X115.185 Y87.492 E2.66132 ; infill
G1 X114.256 Y87.492 E0.05077 ; infill
G1 X148.699 Y121.935 E2.66132 ; infill
G1 X147.770 Y121.935 E0.05077 ; infill
G1 X113.327 Y87.492 E2.66132 ; infill
G1 X112.397 Y87.492 E0.05077 ; infill
G1 X146.840 Y121.935 E2.66132 ; infill
G1 X145.911 Y121.935 E0.05077 ; infill
G1 X111.468 Y87.492 E2.66132 ; infill
G1 X110.539 Y87.492 E0.05077 ; infill
G1 X144.982 Y121.935 E2.66132 ; infill
G1 X144.053 Y121.935 E0.05077 ; infill
G1 X109.610 Y87.492 E2.66132 ; infill
G1 X108.680 Y87.492 E0.05077 ; infill
G1 X143.123 Y121.935 E2.66132 ; infill
G1 X142.194 Y121.935 E0.05077 ; infill
G1 X107.751 Y87.492 E2.66132 ; infill
G1 X106.822 Y87.492 E0.05077 ; infill
G1 X141.265 Y121.935 E2.66132 ; infill
G1 X140.336 Y121.935 E0.05077 ; infill
G1 X105.893 Y87.492 E2.66132 ; infill
G1 X104.963 Y87.492 E0.05077 ; infill
G1 X139.406 Y121.935 E2.66132 ; infill
G1 X138.477 Y121.935 E0.05077 ; infill
G1 X104.034 Y87.492 E2.66132 ; infill
G1 X103.105 Y87.492 E0.05077 ; infill
G1 X137.548 Y121.935 E2.66132 ; infill
G1 X136.619 Y121.935 E0.05077 ; infill
G1 X102.176 Y87.492 E2.66132 ; infill
G1 X101.246 Y87.492 E0.05077 ; infill
G1 X135.689 Y121.935 E2.66132 ; infill
G1 X134.760 Y121.935 E0.05077 ; infill
G1 X100.317 Y87.492 E2.66132 ; infill
G1 X99.388 Y87.492 E0.05077 ; infill
G1 X133.831 Y121.935 E2.66132 ; infill
G1 X132.902 Y121.935 E0.05077 ; infill
G1 X99.225 Y88.258 E2.60214 ; infill
G1 X99.225 Y89.187 E0.05077 ; infill
G1 X131.972 Y121.935 E2.53034 ; infill
G1 X131.043 Y121.935 E0.05077 ; infill
G1 X99.225 Y90.117 E2.45854 ; infill
G1 X99.225 Y91.046 E0.05077 ; infill
G1 X130.114 Y121.935 E2.38674 ; infill
G1 X129.185 Y121.935 E0.05077 ; infill
G1 X99.225 Y91.975 E2.31494 ; infill
M73 Q41 S10
G1 X99.225 Y92.904 E0.05077 ; infill
G1 X128.255 Y121.935 E2.24314 ; infill
M73 P41 R10
G1 X127.326 Y121.935 E0.05077 ; infill
G1 X99.225 Y93.834 E2.17133 ; infill
G1 X99.225 Y94.763 E0.05077 ; infill
G1 X126.397 Y121.935 E2.09953 ; infill
G1 X125.468 Y121.935 E0.05077 ; infill
G1 X99.225 Y95.692 E2.02773 ; infill
G1 X99.225 Y96.621 E0.05077 ; infill
G1 X124.538 Y121.935 E1.95593 ; infill
G1 X123.609 Y121.935 E0.05077 ; infill
G1 X99.225 Y97.551 E1.88413 ; infill
G1 X99.225 Y98.480 E0.05077 ; infill
G1 X122.680 Y121.935 E1.81233 ; infill
G1 X121.751 Y121.935 E0.05077 ; infill
G1 X99.225 Y99.409 E1.74053 ; infill
G1 X99.225 Y100.338 E0.05077 ; infill
G1 X120.821 Y121.935 E1.66873 ; infill
G1 X119.892 Y121.935 E0.05077 ; infill
G1 X99.225 Y101.268 E1.59693 ; infill
G1 X99.225 Y102.197 E0.05077 ; infill
G1 X118.963 Y121.935 E1.52513 ; infill
G1 X118.034 Y121.935 E0.05077 ; infill
G1 X99.225 Y103.126 E1.45333 ; infill
G1 X99.225 Y104.055 E0.05077 ; infill
G1 X117.104 Y121.935 E1.38153 ; infill
G1 X116.175 Y121.935 E0.05077 ; infill
G1 X99.225 Y104.985 E1.30972 ; infill
G1 X99.225 Y105.914 E0.05077 ; infill
G1 X115.246 Y121.935 E1.23792 ; infill
G1 X114.317 Y121.935 E0.05077 ; infill
G1 X99.225 Y106.843 E1.16612 ; infill
G1 X99.225 Y107.772 E0.05077 ; infill
G1 X113.387 Y121.935 E1.09432 ; infill
G1 X112.458 Y121.935 E0.05077 ; infill
G1 X99.225 Y108.702 E1.02252 ; infill
G1 X99.225 Y109.631 E0.05077 ; infill
G1 X111.529 Y121.935 E0.95072 ; infill
G1 X110.600 Y121.935 E0.05077 ; infill
G1 X99.225 Y110.560 E0.87892 ; infill
G1 X99.225 Y111.489 E0.05077 ; infill
G1 X109.670 Y121.935 E0.80712 ; infill
G1 X108.741 Y121.935 E0.05077 ; infill
G1 X99.225 Y112.419 E0.73532 ; infill
G1 X99.225 Y113.348 E0.05077 ; infill
G1 X107.812 Y121.935 E0.66352 ; infill
G1 X106.883 Y121.935 E0.05077 ; infill
G1 X99.225 Y114.277 E0.59172 ; infill
G1 X99.225 Y115.206 E0.05077 ; infill
G1 X105.953 Y121.935 E0.51992 ; infill
G1 X105.024 Y121.935 E0.05077 ; infill
G1 X99.225 Y116.136 E0.44811 ; infill
G1 X99.225 Y117.065 E0.05077 ; infill
G1 X104.095 Y121.935 E0.37631 ; infill
G1 X103.166 Y121.935 E0.05077 ; infill
G1 X99.225 Y117.994 E0.30451 ; infill
G1 X99.225 Y118.923 E0.05077 ; infill
G1 X102.236 Y121.935 E0.23271 ; infill
G1 X101.307 Y121.935 E0.05077 ; infill
G1 X99.225 Y119.853 E0.16091 ; infill
G1 X99.225 Y120.782 E0.05077 ; infill
G1 X100.378 Y121.935 E0.08911 ; infill
G1 X99.449 Y121.935 E0.05077 ; infill
G1 X98.929 Y121.415 E0.04016 ; infill
M204 S1000 ; adjust acceleration
G1 F9600.000
G1 X99.449 Y121.935 E-0.15274 ; wipe and retract
G1 X100.378 Y121.935 E-0.19311 ; wipe and retract
G1 X100.262 Y121.819 E-0.03415 ; wipe and retract
G1 E-0.02000 F2100.00000 ; retract
G1 Z0.800 F12000.000 ; lift Z
G1 X158.996 Y87.524 ; move to first infill point
G1 Z0.600 ; restore layer Z
G1 E0.40000 F2100.00000 ; unretract
G1 F1680.000
G1 X158.957 Y87.511 E0.00285 ; infill
G1 X158.918 Y87.499 E0.00268 ; infill
G1 X158.879 Y87.486 E0.00251 ; infill
G1 X158.840 Y87.474 E0.00235 ; infill
G1 X158.802 Y87.461 E0.00218 ; infill
G1 X158.763 Y87.448 E0.00202 ; infill
G1 X158.675 Y87.416 E0.00424 ; infill
G1 X158.626 Y87.395 E0.00219 ; infill
G1 X158.577 Y87.375 E0.00200 ; infill
G1 X158.529 Y87.355 E0.00180 ; infill
G1 X158.480 Y87.335 E0.00160 ; infill
G1 X158.431 Y87.315 E0.00140 ; infill
G1 X158.382 Y87.294 E0.00121 ; infill
G1 X158.333 Y87.274 E0.00101 ; infill
G1 X158.285 Y87.254 E0.00081 ; infill
G1 X158.236 Y87.234 E0.00062 ; infill
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M106 S20.4 ; enable fan
;BEFORE_LAYER_CHANGE
G92 E0.0
0.8;0.8

M106 S56

G1 Z0.800 F12000.000 ; move to next layer (3)
;AFTER_LAYER_CHANGE
; starting layer 3, at 0.8mm
;0.8

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
G1 X158.236 Y86.589 ; move to first perimeter point
M204 S800 ; adjust acceleration
G1 F1680.000
G1 X159.003 Y86.589 E0.02415 ; perimeter
G1 X159.047 Y86.633 E0.00202 ; perimeter
G1 X159.179 Y86.765 E0.00627 ; perimeter
G1 X159.571 Y87.157 E0.01877 ; perimeter
G1 X159.571 Y87.219 E0.00202 ; perimeter
G1 X159.571 Y87.406 E0.00627 ; perimeter
G1 X159.571 Y122.270 E1.18012 ; perimeter
G1 X159.527 Y122.314 E0.00202 ; perimeter
G1 X159.395 Y122.447 E0.00627 ; perimeter
G1 X159.003 Y122.839 E0.01877 ; perimeter
G1 X158.941 Y122.839 E0.00202 ; perimeter
G1 X158.754 Y122.839 E0.00627 ; perimeter
G1 X98.889 Y122.839 E2.02635 ; perimeter
G1 X98.845 Y122.795 E0.00202 ; perimeter
G1 X98.713 Y122.663 E0.00627 ; perimeter
G1 X98.321 Y122.270 E0.01877 ; perimeter
G1 X98.321 Y122.208 E0.00202 ; perimeter
G1 X98.321 Y122.021 E0.00627 ; perimeter
G1 X98.321 Y87.157 E1.18012 ; perimeter
G1 X98.365 Y87.113 E0.00202 ; perimeter
G1 X98.497 Y86.981 E0.00627 ; perimeter
G1 X98.889 Y86.589 E0.01877 ; perimeter
G1 X98.951 Y86.589 E0.00202 ; perimeter
G1 X99.138 Y86.589 E0.00627 ; perimeter
G1 X158.176 Y86.589 E1.99835 ; perimeter
M204 S1000 ; adjust acceleration
G1 X158.176 Y86.804 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X158.914 Y86.804 E0.02191 ; infill
G1 X159.356 Y87.246 E0.01857 ; infill
G1 X159.356 Y122.181 E1.03728 ; infill
G1 X158.914 Y122.624 E0.01857 ; infill
G1 X98.978 Y122.624 E1.77956 ; infill
G1 X98.536 Y122.181 E0.01857 ; infill
G1 X98.536 Y87.246 E1.03728 ; infill
G1 X98.978 Y86.804 E0.01857 ; infill
G1 X158.116 Y86.804 E1.75587 ; infill
M204 S1000 ; adjust acceleration
G1 X158.116 Y87.161 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X158.766 Y87.161 E0.01930 ; infill
G1 X158.999 Y87.394 E0.00979 ; infill
G1 X158.999 Y122.034 E1.02850 ; infill
G1 X158.766 Y122.267 E0.00979 ; infill
G1 X99.126 Y122.267 E1.77078 ; infill
G1 X98.893 Y122.034 E0.00979 ; infill
G1 X98.893 Y87.394 E1.02850 ; infill
G1 X99.126 Y87.161 E0.00979 ; infill
G1 X158.056 Y87.161 E1.74970 ; infill
M204 S1000 ; adjust acceleration
G1 X158.056 Y87.518 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X158.642 Y87.518 E0.01741 ; infill
G1 X158.642 Y121.910 E1.02114 ; infill
G1 X99.250 Y121.910 E1.76342 ; infill
G1 X99.250 Y87.518 E1.02114 ; infill
G1 X157.996 Y87.518 E1.74423 ; infill
M204 S1000 ; adjust acceleration
G1 X157.996 Y87.875 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X158.285 Y87.875 E0.00858 ; infill
G1 X158.285 Y121.552 E0.99993 ; infill
G1 X99.607 Y121.552 E1.74222 ; infill
G1 X99.607 Y87.875 E0.99993 ; infill
G1 X157.936 Y87.875 E1.73185 ; infill
M73 Q47 S9
M204 S1000 ; adjust acceleration
G1 X157.928 Y88.232 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X157.928 Y121.195 E0.97873 ; infill
M73 P47 R9
G1 X99.964 Y121.195 E1.72101 ; infill
G1 X99.964 Y88.232 E0.97873 ; infill
G1 X157.868 Y88.232 E1.71923 ; infill
M204 S1000 ; adjust acceleration
G1 X157.571 Y88.589 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X157.571 Y120.838 E0.95752 ; infill
G1 X100.321 Y120.838 E1.69981 ; infill
G1 X100.321 Y88.589 E0.95752 ; infill
G1 X157.511 Y88.589 E1.69803 ; infill
M204 S1000 ; adjust acceleration
G1 X157.214 Y88.946 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X157.214 Y120.481 E0.93632 ; infill
G1 X100.678 Y120.481 E1.67860 ; infill
G1 X100.678 Y88.946 E0.93632 ; infill
G1 X157.154 Y88.946 E1.67682 ; infill
M204 S1000 ; adjust acceleration
G1 X156.857 Y89.303 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X156.857 Y120.124 E0.91512 ; infill
G1 X101.035 Y120.124 E1.65740 ; infill
G1 X101.035 Y89.303 E0.91512 ; infill
G1 X156.797 Y89.303 E1.65562 ; infill
M204 S1000 ; adjust acceleration
G1 X156.499 Y89.660 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X156.499 Y119.767 E0.89391 ; infill
G1 X101.393 Y119.767 E1.63619 ; infill
G1 X101.393 Y89.660 E0.89391 ; infill
G1 X156.439 Y89.660 E1.63441 ; infill
M204 S1000 ; adjust acceleration
G1 X156.142 Y90.017 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X156.142 Y119.410 E0.87271 ; infill
G1 X101.750 Y119.410 E1.61499 ; infill
G1 X101.750 Y90.017 E0.87271 ; infill
G1 X156.082 Y90.017 E1.61321 ; infill
M204 S1000 ; adjust acceleration
G1 X155.785 Y90.374 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X155.785 Y119.053 E0.85150 ; infill
G1 X102.107 Y119.053 E1.59379 ; infill
G1 X102.107 Y90.374 E0.85150 ; infill
G1 X155.725 Y90.374 E1.59200 ; infill
M204 S1000 ; adjust acceleration
G1 X155.428 Y90.731 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X155.428 Y118.696 E0.83030 ; infill
G1 X102.464 Y118.696 E1.57258 ; infill
G1 X102.464 Y90.731 E0.83030 ; infill
G1 X155.368 Y90.731 E1.57080 ; infill
M204 S1000 ; adjust acceleration
G1 X155.071 Y91.089 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X155.071 Y118.339 E0.80909 ; infill
G1 X102.821 Y118.339 E1.55138 ; infill
G1 X102.821 Y91.089 E0.80909 ; infill
G1 X155.011 Y91.089 E1.54960 ; infill
M204 S1000 ; adjust acceleration
G1 X154.714 Y91.446 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X154.714 Y117.982 E0.78789 ; infill
G1 X103.178 Y117.982 E1.53017 ; infill
G1 X103.178 Y91.446 E0.78789 ; infill
G1 X154.654 Y91.446 E1.52839 ; infill
M73 Q53 S8
M204 S1000 ; adjust acceleration
G1 X154.357 Y91.803 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X154.357 Y117.625 E0.76669 ; infill
M73 P53 R8
G1 X103.535 Y117.625 E1.50897 ; infill
G1 X103.535 Y91.803 E0.76669 ; infill
G1 X154.297 Y91.803 E1.50719 ; infill
M204 S1000 ; adjust acceleration
G1 X154.000 Y92.160 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X154.000 Y117.268 E0.74548 ; infill
G1 X103.892 Y117.268 E1.48776 ; infill
G1 X103.892 Y92.160 E0.74548 ; infill
G1 X153.940 Y92.160 E1.48598 ; infill
M204 S1000 ; adjust acceleration
G1 X153.643 Y92.517 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X153.643 Y116.910 E0.72428 ; infill
G1 X104.249 Y116.910 E1.46656 ; infill
G1 X104.249 Y92.517 E0.72428 ; infill
G1 X153.583 Y92.517 E1.46478 ; infill
M204 S1000 ; adjust acceleration
G1 X153.286 Y92.874 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X153.286 Y116.553 E0.70307 ; infill
G1 X104.606 Y116.553 E1.44536 ; infill
G1 X104.606 Y92.874 E0.70307 ; infill
G1 X153.226 Y92.874 E1.44357 ; infill
M204 S1000 ; adjust acceleration
G1 X152.929 Y93.231 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X152.929 Y116.196 E0.68187 ; infill
G1 X104.963 Y116.196 E1.42415 ; infill
G1 X104.963 Y93.231 E0.68187 ; infill
G1 X152.869 Y93.231 E1.42237 ; infill
M204 S1000 ; adjust acceleration
G1 X152.572 Y93.588 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X152.572 Y115.839 E0.66066 ; infill
G1 X105.320 Y115.839 E1.40295 ; infill
G1 X105.320 Y93.588 E0.66066 ; infill
G1 X152.512 Y93.588 E1.40117 ; infill
M204 S1000 ; adjust acceleration
G1 X152.214 Y93.945 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X152.214 Y115.482 E0.63946 ; infill
G1 X105.678 Y115.482 E1.38174 ; infill
G1 X105.678 Y93.945 E0.63946 ; infill
G1 X152.154 Y93.945 E1.37996 ; infill
M204 S1000 ; adjust acceleration
G1 X151.857 Y94.302 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X151.857 Y115.125 E0.61826 ; infill
G1 X106.035 Y115.125 E1.36054 ; infill
G1 X106.035 Y94.302 E0.61826 ; infill
G1 X151.797 Y94.302 E1.35876 ; infill
M204 S1000 ; adjust acceleration
G1 X151.500 Y94.659 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X151.500 Y114.768 E0.59705 ; infill
G1 X106.392 Y114.768 E1.33933 ; infill
G1 X106.392 Y94.659 E0.59705 ; infill
G1 X151.440 Y94.659 E1.33755 ; infill
M204 S1000 ; adjust acceleration
G1 X151.143 Y95.016 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X151.143 Y114.411 E0.57585 ; infill
G1 X106.749 Y114.411 E1.31813 ; infill
G1 X106.749 Y95.016 E0.57585 ; infill
G1 X151.083 Y95.016 E1.31635 ; infill
M204 S1000 ; adjust acceleration
G1 X150.786 Y95.373 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X150.786 Y114.054 E0.55464 ; infill
G1 X107.106 Y114.054 E1.29693 ; infill
G1 X107.106 Y95.373 E0.55464 ; infill
G1 X150.726 Y95.373 E1.29514 ; infill
M204 S1000 ; adjust acceleration
G1 X150.429 Y95.731 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X150.429 Y113.697 E0.53344 ; infill
G1 X107.463 Y113.697 E1.27572 ; infill
G1 X107.463 Y95.731 E0.53344 ; infill
G1 X150.369 Y95.731 E1.27394 ; infill
M204 S1000 ; adjust acceleration
G1 X150.072 Y96.088 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X150.072 Y113.340 E0.51223 ; infill
M73 Q59 S7
G1 X107.820 Y113.340 E1.25452 ; infill
M73 P59 R7
G1 X107.820 Y96.088 E0.51223 ; infill
G1 X150.012 Y96.088 E1.25274 ; infill
M204 S1000 ; adjust acceleration
G1 X149.715 Y96.445 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X149.715 Y112.983 E0.49103 ; infill
G1 X108.177 Y112.983 E1.23331 ; infill
G1 X108.177 Y96.445 E0.49103 ; infill
G1 X149.655 Y96.445 E1.23153 ; infill
M204 S1000 ; adjust acceleration
G1 X149.358 Y96.802 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X149.358 Y112.626 E0.46983 ; infill
G1 X108.534 Y112.626 E1.21211 ; infill
G1 X108.534 Y96.802 E0.46983 ; infill
G1 X149.298 Y96.802 E1.21033 ; infill
M204 S1000 ; adjust acceleration
G1 X149.001 Y97.159 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X149.001 Y112.268 E0.44862 ; infill
G1 X108.891 Y112.268 E1.19090 ; infill
G1 X108.891 Y97.159 E0.44862 ; infill
G1 X148.941 Y97.159 E1.18912 ; infill
M204 S1000 ; adjust acceleration
G1 X148.644 Y97.516 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X148.644 Y111.911 E0.42742 ; infill
G1 X109.248 Y111.911 E1.16970 ; infill
G1 X109.248 Y97.516 E0.42742 ; infill
G1 X148.584 Y97.516 E1.16792 ; infill
M204 S1000 ; adjust acceleration
G1 X148.287 Y97.873 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X148.287 Y111.554 E0.40621 ; infill
G1 X109.605 Y111.554 E1.14850 ; infill
G1 X109.605 Y97.873 E0.40621 ; infill
G1 X148.227 Y97.873 E1.14671 ; infill
M204 S1000 ; adjust acceleration
G1 X147.930 Y98.230 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X147.930 Y111.197 E0.38501 ; infill
G1 X109.962 Y111.197 E1.12729 ; infill
G1 X109.962 Y98.230 E0.38501 ; infill
G1 X147.870 Y98.230 E1.12551 ; infill
M204 S1000 ; adjust acceleration
G1 X147.572 Y98.587 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X147.572 Y110.840 E0.36381 ; infill
G1 X110.320 Y110.840 E1.10609 ; infill
G1 X110.320 Y98.587 E0.36381 ; infill
G1 X147.512 Y98.587 E1.10431 ; infill
M204 S1000 ; adjust acceleration
G1 X147.215 Y98.944 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X147.215 Y110.483 E0.34260 ; infill
G1 X110.677 Y110.483 E1.08488 ; infill
G1 X110.677 Y98.944 E0.34260 ; infill
G1 X147.155 Y98.944 E1.08310 ; infill
M204 S1000 ; adjust acceleration
G1 X146.858 Y99.301 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X146.858 Y110.126 E0.32140 ; infill
G1 X111.034 Y110.126 E1.06368 ; infill
G1 X111.034 Y99.301 E0.32140 ; infill
G1 X146.798 Y99.301 E1.06190 ; infill
M204 S1000 ; adjust acceleration
G1 X146.501 Y99.658 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X146.501 Y109.769 E0.30019 ; infill
G1 X111.391 Y109.769 E1.04247 ; infill
G1 X111.391 Y99.658 E0.30019 ; infill
G1 X146.441 Y99.658 E1.04069 ; infill
M204 S1000 ; adjust acceleration
G1 X146.144 Y100.016 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X146.144 Y109.412 E0.27899 ; infill
G1 X111.748 Y109.412 E1.02127 ; infill
G1 X111.748 Y100.016 E0.27899 ; infill
G1 X146.084 Y100.016 E1.01949 ; infill
M204 S1000 ; adjust acceleration
G1 X145.787 Y100.373 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X145.787 Y109.055 E0.25778 ; infill
G1 X112.105 Y109.055 E1.00007 ; infill
G1 X112.105 Y100.373 E0.25778 ; infill
G1 X145.727 Y100.373 E0.99828 ; infill
M204 S1000 ; adjust acceleration
G1 X145.430 Y100.730 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X145.430 Y108.698 E0.23658 ; infill
G1 X112.462 Y108.698 E0.97886 ; infill
G1 X112.462 Y100.730 E0.23658 ; infill
G1 X145.370 Y100.730 E0.97708 ; infill
M204 S1000 ; adjust acceleration
G1 X145.073 Y101.087 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X145.073 Y108.341 E0.21538 ; infill
G1 X112.819 Y108.341 E0.95766 ; infill
G1 X112.819 Y101.087 E0.21538 ; infill
G1 X145.013 Y101.087 E0.95588 ; infill
M204 S1000 ; adjust acceleration
G1 X144.716 Y101.444 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X144.716 Y107.983 E0.19417 ; infill
G1 X113.176 Y107.983 E0.93645 ; infill
G1 X113.176 Y101.444 E0.19417 ; infill
G1 X144.656 Y101.444 E0.93467 ; infill
M204 S1000 ; adjust acceleration
G1 X144.359 Y101.801 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X144.359 Y107.626 E0.17297 ; infill
G1 X113.533 Y107.626 E0.91525 ; infill
G1 X113.533 Y101.801 E0.17297 ; infill
G1 X144.299 Y101.801 E0.91347 ; infill
M204 S1000 ; adjust acceleration
G1 X144.002 Y102.158 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X144.002 Y107.269 E0.15176 ; infill
G1 X113.890 Y107.269 E0.89404 ; infill
M73 Q64 S6
G1 X113.890 Y102.158 E0.15176 ; infill
G1 X143.942 Y102.158 E0.89226 ; infill
M73 P65 R6
M204 S1000 ; adjust acceleration
G1 X143.645 Y102.515 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X143.645 Y106.912 E0.13056 ; infill
G1 X114.247 Y106.912 E0.87284 ; infill
G1 X114.247 Y102.515 E0.13056 ; infill
G1 X143.585 Y102.515 E0.87106 ; infill
M204 S1000 ; adjust acceleration
G1 X143.288 Y102.872 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X143.288 Y106.555 E0.10935 ; infill
G1 X114.604 Y106.555 E0.85164 ; infill
G1 X114.604 Y102.872 E0.10935 ; infill
G1 X143.228 Y102.872 E0.84985 ; infill
M204 S1000 ; adjust acceleration
G1 X142.930 Y103.229 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X142.930 Y106.198 E0.08815 ; infill
G1 X114.962 Y106.198 E0.83043 ; infill
G1 X114.962 Y103.229 E0.08815 ; infill
G1 X142.870 Y103.229 E0.82865 ; infill
M204 S1000 ; adjust acceleration
G1 X142.573 Y103.586 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X142.573 Y105.841 E0.06695 ; infill
G1 X115.319 Y105.841 E0.80923 ; infill
G1 X115.319 Y103.586 E0.06695 ; infill
G1 X142.513 Y103.586 E0.80745 ; infill
M204 S1000 ; adjust acceleration
G1 X142.216 Y103.943 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X142.216 Y105.484 E0.04574 ; infill
G1 X115.676 Y105.484 E0.78802 ; infill
G1 X115.676 Y103.943 E0.04574 ; infill
G1 X142.156 Y103.943 E0.78624 ; infill
M204 S1000 ; adjust acceleration
G1 X141.859 Y104.300 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X141.859 Y105.127 E0.02454 ; infill
G1 X116.033 Y105.127 E0.76682 ; infill
G1 X116.033 Y104.300 E0.02454 ; infill
G1 X141.799 Y104.300 E0.76504 ; infill
M204 S1000 ; adjust acceleration
G1 X141.681 Y104.714 F12000.000 ; move to first infill point
M204 S1250 ; adjust acceleration
G1 F1680.000
G1 X116.211 Y104.714 E0.99390 ; infill
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
; starting change to layer 4, at 1mm
;1

M106 S56

G1 Z0.800 F12000.000 ; move to next layer (4)
;AFTER_LAYER_CHANGE
; starting layer 4, at 1mm
;1

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
G1 E-0.40000 F2100.00000 ; retract
G1 Z0.800 F12000.000 ; lift Z
G1 Z0.800 ; restore layer Z
G1 E0.40000 F2100.00000 ; unretract
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z0.818 X98.121 Y87.157 E0.59246 ; perimeter
G1 Z0.818 X98.165 Y87.113 E0.00202 ; perimeter
G1 Z0.818 X98.297 Y86.981 E0.00627 ; perimeter
G1 Z0.819 X98.889 Y86.389 E0.02834 ; perimeter
G1 Z0.819 X98.951 Y86.389 E0.00202 ; perimeter
G1 Z0.819 X99.138 Y86.389 E0.00627 ; perimeter
G1 Z0.881 X159.003 Y86.389 E2.02635 ; perimeter
G1 Z0.881 X159.047 Y86.433 E0.00202 ; perimeter
G1 Z0.881 X159.179 Y86.565 E0.00627 ; perimeter
G1 Z0.882 X159.771 Y87.157 E0.02834 ; perimeter
G1 Z0.882 X159.771 Y87.219 E0.00202 ; perimeter
G1 Z0.882 X159.771 Y87.406 E0.00627 ; perimeter
G1 Z0.918 X159.771 Y122.270 E1.18012 ; perimeter
G1 Z0.918 X159.727 Y122.314 E0.00202 ; perimeter
G1 Z0.918 X159.595 Y122.447 E0.00627 ; perimeter
G1 Z0.919 X159.003 Y123.039 E0.02834 ; perimeter
G1 Z0.919 X158.941 Y123.039 E0.00202 ; perimeter
G1 Z0.919 X158.754 Y123.039 E0.00627 ; perimeter
G1 Z0.981 X98.889 Y123.039 E2.02635 ; perimeter
G1 Z0.981 X98.845 Y122.995 E0.00202 ; perimeter
G1 Z0.981 X98.713 Y122.863 E0.00627 ; perimeter
G1 Z0.982 X98.121 Y122.270 E0.02834 ; perimeter
G1 Z0.982 X98.121 Y122.208 E0.00202 ; perimeter
G1 Z0.982 X98.121 Y122.021 E0.00627 ; perimeter
G1 Z1.000 X98.121 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
1.2;1.2

M106 S56

G1 Z1.000 F12000.000 ; move to next layer (5)
;AFTER_LAYER_CHANGE
; starting layer 5, at 1.2mm
;1.2

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F600
G1 Z1.018 X97.921 Y87.157 E0.59246 ; perimeter
G1 Z1.018 X97.965 Y87.113 E0.00202 ; perimeter
G1 Z1.018 X98.097 Y86.981 E0.00627 ; perimeter
G1 Z1.019 X98.889 Y86.189 E0.03792 ; perimeter
G1 Z1.019 X98.951 Y86.189 E0.00202 ; perimeter
G1 Z1.020 X99.138 Y86.189 E0.00627 ; perimeter
G1 Z1.081 X159.003 Y86.189 E2.02635 ; perimeter
G1 Z1.081 X159.047 Y86.233 E0.00202 ; perimeter
G1 Z1.081 X159.179 Y86.365 E0.00627 ; perimeter
G1 Z1.082 X159.971 Y87.157 E0.03792 ; perimeter
G1 Z1.082 X159.971 Y87.219 E0.00202 ; perimeter
G1 Z1.082 X159.971 Y87.406 E0.00627 ; perimeter
G1 Z1.118 X159.971 Y122.270 E1.18012 ; perimeter
G1 Z1.118 X159.927 Y122.314 E0.00202 ; perimeter
G1 Z1.118 X159.795 Y122.447 E0.00627 ; perimeter
G1 Z1.119 X159.003 Y123.239 E0.03792 ; perimeter
G1 Z1.119 X158.941 Y123.239 E0.00202 ; perimeter
G1 Z1.120 X158.754 Y123.239 E0.00627 ; perimeter
G1 Z1.181 X98.889 Y123.239 E2.02635 ; perimeter
G1 Z1.181 X98.845 Y123.195 E0.00202 ; perimeter
G1 Z1.181 X98.713 Y123.063 E0.00627 ; perimeter
G1 Z1.182 X97.921 Y122.270 E0.03792 ; perimeter
G1 Z1.182 X97.921 Y122.208 E0.00202 ; perimeter
G1 Z1.182 X97.921 Y122.021 E0.00627 ; perimeter
G1 Z1.200 X97.921 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
1.4;1.4

M106 S56

G1 Z1.200 F12000.000 ; move to next layer (6)
;AFTER_LAYER_CHANGE
; starting layer 6, at 1.4mm
;1.4

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F600
G1 Z1.218 X97.721 Y87.157 E0.59246 ; perimeter
G1 Z1.218 X97.765 Y87.113 E0.00202 ; perimeter
G1 Z1.218 X97.897 Y86.981 E0.00627 ; perimeter
G1 Z1.219 X98.889 Y85.989 E0.04749 ; perimeter
G1 Z1.220 X98.951 Y85.989 E0.00202 ; perimeter
G1 Z1.220 X99.138 Y85.989 E0.00627 ; perimeter
G1 Z1.281 X159.003 Y85.989 E2.02635 ; perimeter
G1 Z1.281 X159.047 Y86.033 E0.00202 ; perimeter
G1 Z1.281 X159.179 Y86.165 E0.00627 ; perimeter
G1 Z1.282 X160.171 Y87.157 E0.04749 ; perimeter
G1 Z1.282 X160.171 Y87.219 E0.00202 ; perimeter
G1 Z1.282 X160.171 Y87.406 E0.00627 ; perimeter
G1 Z1.318 X160.171 Y122.270 E1.18012 ; perimeter
G1 Z1.318 X160.127 Y122.314 E0.00202 ; perimeter
G1 Z1.318 X159.995 Y122.447 E0.00627 ; perimeter
G1 Z1.319 X159.003 Y123.439 E0.04749 ; perimeter
G1 Z1.320 X158.941 Y123.439 E0.00202 ; perimeter
G1 Z1.320 X158.754 Y123.439 E0.00627 ; perimeter
G1 Z1.381 X98.889 Y123.439 E2.02635 ; perimeter
G1 Z1.381 X98.845 Y123.395 E0.00202 ; perimeter
G1 Z1.381 X98.713 Y123.263 E0.00627 ; perimeter
G1 Z1.382 X97.721 Y122.270 E0.04749 ; perimeter
G1 Z1.382 X97.721 Y122.208 E0.00202 ; perimeter
G1 Z1.382 X97.721 Y122.021 E0.00627 ; perimeter
G1 Z1.400 X97.721 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
1.6;1.6

M106 S56

G1 Z1.400 F12000.000 ; move to next layer (7)
;AFTER_LAYER_CHANGE
; starting layer 7, at 1.6mm
;1.6

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F600
G1 Z1.418 X97.521 Y87.157 E0.59246 ; perimeter
G1 Z1.418 X97.565 Y87.113 E0.00202 ; perimeter
G1 Z1.418 X97.697 Y86.981 E0.00627 ; perimeter
G1 Z1.420 X98.889 Y85.789 E0.05707 ; perimeter
G1 Z1.420 X98.951 Y85.789 E0.00202 ; perimeter
G1 Z1.420 X99.138 Y85.789 E0.00627 ; perimeter
G1 Z1.480 X159.003 Y85.789 E2.02635 ; perimeter
G1 Z1.480 X159.047 Y85.833 E0.00202 ; perimeter
G1 Z1.481 X159.179 Y85.965 E0.00627 ; perimeter
G1 Z1.482 X160.371 Y87.157 E0.05707 ; perimeter
G1 Z1.482 X160.371 Y87.219 E0.00202 ; perimeter
G1 Z1.483 X160.371 Y87.406 E0.00627 ; perimeter
G1 Z1.518 X160.371 Y122.270 E1.18012 ; perimeter
G1 Z1.518 X160.327 Y122.314 E0.00202 ; perimeter
G1 Z1.518 X160.195 Y122.447 E0.00627 ; perimeter
G1 Z1.520 X159.003 Y123.639 E0.05707 ; perimeter
G1 Z1.520 X158.941 Y123.639 E0.00202 ; perimeter
G1 Z1.520 X158.754 Y123.639 E0.00627 ; perimeter
G1 Z1.580 X98.889 Y123.639 E2.02635 ; perimeter
G1 Z1.580 X98.845 Y123.595 E0.00202 ; perimeter
G1 Z1.581 X98.713 Y123.463 E0.00627 ; perimeter
G1 Z1.582 X97.521 Y122.270 E0.05707 ; perimeter
G1 Z1.582 X97.521 Y122.208 E0.00202 ; perimeter
G1 Z1.583 X97.521 Y122.021 E0.00627 ; perimeter
G1 Z1.600 X97.521 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
1.8;1.8

M106 S56

G1 Z1.600 F12000.000 ; move to next layer (8)
;AFTER_LAYER_CHANGE
; starting layer 8, at 1.8mm
;1.8

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F600
G1 Z1.618 X97.321 Y87.157 E0.59246 ; perimeter
G1 Z1.618 X97.365 Y87.113 E0.00202 ; perimeter
G1 Z1.618 X97.497 Y86.981 E0.00627 ; perimeter
G1 Z1.620 X98.889 Y85.589 E0.06664 ; perimeter
G1 Z1.620 X98.951 Y85.589 E0.00202 ; perimeter
G1 Z1.620 X99.138 Y85.589 E0.00627 ; perimeter
G1 Z1.680 X159.003 Y85.589 E2.02635 ; perimeter
G1 Z1.680 X159.047 Y85.633 E0.00202 ; perimeter
G1 Z1.680 X159.179 Y85.765 E0.00627 ; perimeter
G1 Z1.682 X160.571 Y87.157 E0.06664 ; perimeter
G1 Z1.682 X160.571 Y87.219 E0.00202 ; perimeter
G1 Z1.683 X160.571 Y87.406 E0.00627 ; perimeter
G1 Z1.718 X160.571 Y122.270 E1.18012 ; perimeter
G1 Z1.718 X160.527 Y122.314 E0.00202 ; perimeter
G1 Z1.718 X160.395 Y122.447 E0.00627 ; perimeter
G1 Z1.720 X159.003 Y123.839 E0.06664 ; perimeter
G1 Z1.720 X158.941 Y123.839 E0.00202 ; perimeter
G1 Z1.720 X158.754 Y123.839 E0.00627 ; perimeter
G1 Z1.780 X98.889 Y123.839 E2.02635 ; perimeter
G1 Z1.780 X98.845 Y123.795 E0.00202 ; perimeter
G1 Z1.780 X98.713 Y123.663 E0.00627 ; perimeter
G1 Z1.782 X97.321 Y122.270 E0.06664 ; perimeter
G1 Z1.782 X97.321 Y122.208 E0.00202 ; perimeter
G1 Z1.783 X97.321 Y122.021 E0.00627 ; perimeter
G1 Z1.800 X97.321 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
; starting change to layer 9, at 2mm
;2

M106 S56

G1 Z1.800 F12000.000 ; move to next layer (9)
;AFTER_LAYER_CHANGE
; starting layer 9, at 2mm
;2

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F600
G1 Z1.818 X97.121 Y87.157 E0.59246 ; perimeter
G1 Z1.818 X97.165 Y87.113 E0.00202 ; perimeter
G1 Z1.818 X97.297 Y86.981 E0.00627 ; perimeter
G1 Z1.820 X98.889 Y85.389 E0.07621 ; perimeter
G1 Z1.820 X98.951 Y85.389 E0.00202 ; perimeter
G1 Z1.820 X99.138 Y85.389 E0.00627 ; perimeter
G1 Z1.880 X159.003 Y85.389 E2.02635 ; perimeter
G1 Z1.880 X159.047 Y85.433 E0.00202 ; perimeter
G1 Z1.880 X159.179 Y85.565 E0.00627 ; perimeter
G1 Z1.882 X160.771 Y87.157 E0.07621 ; perimeter
G1 Z1.883 X160.771 Y87.219 E0.00202 ; perimeter
G1 Z1.883 X160.771 Y87.406 E0.00627 ; perimeter
G1 Z1.918 X160.771 Y122.270 E1.18012 ; perimeter
G1 Z1.918 X160.727 Y122.314 E0.00202 ; perimeter
G1 Z1.918 X160.595 Y122.447 E0.00627 ; perimeter
G1 Z1.920 X159.003 Y124.039 E0.07621 ; perimeter
G1 Z1.920 X158.941 Y124.039 E0.00202 ; perimeter
G1 Z1.920 X158.754 Y124.039 E0.00627 ; perimeter
G1 Z1.980 X98.889 Y124.039 E2.02635 ; perimeter
G1 Z1.980 X98.845 Y123.995 E0.00202 ; perimeter
G1 Z1.980 X98.713 Y123.863 E0.00627 ; perimeter
G1 Z1.982 X97.121 Y122.270 E0.07621 ; perimeter
G1 Z1.983 X97.121 Y122.208 E0.00202 ; perimeter
G1 Z1.983 X97.121 Y122.021 E0.00627 ; perimeter
G1 Z2.000 X97.121 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
2.2;2.2

M106 S56

G1 Z2.000 F12000.000 ; move to next layer (10)
;AFTER_LAYER_CHANGE
; starting layer 10, at 2.2mm
;2.2

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F600
G1 Z2.017 X96.921 Y87.157 E0.59246 ; perimeter
G1 Z2.017 X96.965 Y87.113 E0.00202 ; perimeter
G1 Z2.018 X97.097 Y86.981 E0.00627 ; perimeter
G1 Z2.020 X98.889 Y85.189 E0.08579 ; perimeter
G1 Z2.020 X98.951 Y85.189 E0.00202 ; perimeter
G1 Z2.020 X99.138 Y85.189 E0.00627 ; perimeter
G1 Z2.080 X159.003 Y85.189 E2.02635 ; perimeter
M73 Q70 S5
M73 P70 R5
G1 Z2.080 X159.047 Y85.233 E0.00202 ; perimeter
G1 Z2.080 X159.179 Y85.365 E0.00627 ; perimeter
G1 Z2.083 X160.971 Y87.157 E0.08579 ; perimeter
G1 Z2.083 X160.971 Y87.219 E0.00202 ; perimeter
G1 Z2.083 X160.971 Y87.406 E0.00627 ; perimeter
G1 Z2.117 X160.971 Y122.270 E1.18012 ; perimeter
G1 Z2.117 X160.927 Y122.314 E0.00202 ; perimeter
G1 Z2.118 X160.795 Y122.447 E0.00627 ; perimeter
G1 Z2.120 X159.003 Y124.239 E0.08579 ; perimeter
G1 Z2.120 X158.941 Y124.239 E0.00202 ; perimeter
G1 Z2.120 X158.754 Y124.239 E0.00627 ; perimeter
G1 Z2.180 X98.889 Y124.239 E2.02635 ; perimeter
G1 Z2.180 X98.845 Y124.195 E0.00202 ; perimeter
G1 Z2.180 X98.713 Y124.063 E0.00627 ; perimeter
G1 Z2.183 X96.921 Y122.270 E0.08579 ; perimeter
G1 Z2.183 X96.921 Y122.208 E0.00202 ; perimeter
G1 Z2.183 X96.921 Y122.021 E0.00627 ; perimeter
G1 Z2.200 X96.921 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
2.4;2.4

M106 S56

G1 Z2.200 F12000.000 ; move to next layer (11)
;AFTER_LAYER_CHANGE
; starting layer 11, at 2.4mm
;2.4

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F600
G1 Z2.217 X96.721 Y87.157 E0.59246 ; perimeter
G1 Z2.217 X96.765 Y87.113 E0.00202 ; perimeter
G1 Z2.218 X96.897 Y86.981 E0.00627 ; perimeter
G1 Z2.220 X98.889 Y84.989 E0.09536 ; perimeter
G1 Z2.220 X98.951 Y84.989 E0.00202 ; perimeter
G1 Z2.221 X99.138 Y84.989 E0.00627 ; perimeter
G1 Z2.280 X159.003 Y84.989 E2.02635 ; perimeter
G1 Z2.280 X159.047 Y85.033 E0.00202 ; perimeter
G1 Z2.280 X159.179 Y85.165 E0.00627 ; perimeter
G1 Z2.283 X161.171 Y87.157 E0.09536 ; perimeter
G1 Z2.283 X161.171 Y87.219 E0.00202 ; perimeter
G1 Z2.283 X161.171 Y87.406 E0.00627 ; perimeter
G1 Z2.317 X161.171 Y122.270 E1.18012 ; perimeter
G1 Z2.317 X161.127 Y122.314 E0.00202 ; perimeter
G1 Z2.318 X160.995 Y122.447 E0.00627 ; perimeter
G1 Z2.320 X159.003 Y124.439 E0.09536 ; perimeter
G1 Z2.320 X158.941 Y124.439 E0.00202 ; perimeter
G1 Z2.321 X158.754 Y124.439 E0.00627 ; perimeter
G1 Z2.380 X98.889 Y124.439 E2.02635 ; perimeter
G1 Z2.380 X98.845 Y124.395 E0.00202 ; perimeter
G1 Z2.380 X98.713 Y124.263 E0.00627 ; perimeter
G1 Z2.383 X96.721 Y122.270 E0.09536 ; perimeter
G1 Z2.383 X96.721 Y122.208 E0.00202 ; perimeter
G1 Z2.383 X96.721 Y122.021 E0.00627 ; perimeter
G1 Z2.400 X96.721 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
2.6;2.6

M106 S56

G1 Z2.400 F12000.000 ; move to next layer (12)
;AFTER_LAYER_CHANGE
; starting layer 12, at 2.6mm
;2.6

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F600
G1 Z2.417 X96.521 Y87.157 E0.59246 ; perimeter
G1 Z2.417 X96.565 Y87.113 E0.00202 ; perimeter
G1 Z2.417 X96.697 Y86.981 E0.00627 ; perimeter
G1 Z2.421 X98.889 Y84.789 E0.10494 ; perimeter
G1 Z2.421 X98.951 Y84.789 E0.00202 ; perimeter
G1 Z2.421 X99.138 Y84.789 E0.00627 ; perimeter
G1 Z2.479 X159.003 Y84.789 E2.02635 ; perimeter
G1 Z2.480 X159.047 Y84.833 E0.00202 ; perimeter
G1 Z2.480 X159.179 Y84.965 E0.00627 ; perimeter
G1 Z2.483 X161.371 Y87.157 E0.10494 ; perimeter
G1 Z2.483 X161.371 Y87.219 E0.00202 ; perimeter
G1 Z2.483 X161.371 Y87.406 E0.00627 ; perimeter
G1 Z2.517 X161.371 Y122.270 E1.18012 ; perimeter
G1 Z2.517 X161.327 Y122.314 E0.00202 ; perimeter
G1 Z2.517 X161.195 Y122.447 E0.00627 ; perimeter
G1 Z2.521 X159.003 Y124.639 E0.10494 ; perimeter
G1 Z2.521 X158.941 Y124.639 E0.00202 ; perimeter
G1 Z2.521 X158.754 Y124.639 E0.00627 ; perimeter
G1 Z2.579 X98.889 Y124.639 E2.02635 ; perimeter
G1 Z2.580 X98.845 Y124.595 E0.00202 ; perimeter
G1 Z2.580 X98.713 Y124.463 E0.00627 ; perimeter
G1 Z2.583 X96.521 Y122.270 E0.10494 ; perimeter
G1 Z2.583 X96.521 Y122.208 E0.00202 ; perimeter
G1 Z2.583 X96.521 Y122.021 E0.00627 ; perimeter
G1 Z2.600 X96.521 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
2.8;2.8

M106 S56

G1 Z2.600 F12000.000 ; move to next layer (13)
;AFTER_LAYER_CHANGE
; starting layer 13, at 2.8mm
;2.8

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F600
G1 Z2.617 X96.321 Y87.157 E0.59246 ; perimeter
G1 Z2.617 X96.365 Y87.113 E0.00202 ; perimeter
G1 Z2.617 X96.497 Y86.981 E0.00627 ; perimeter
G1 Z2.621 X98.889 Y84.589 E0.11451 ; perimeter
G1 Z2.621 X98.951 Y84.589 E0.00202 ; perimeter
G1 Z2.621 X99.138 Y84.589 E0.00627 ; perimeter
G1 Z2.679 X159.003 Y84.589 E2.02635 ; perimeter
G1 Z2.679 X159.047 Y84.633 E0.00202 ; perimeter
G1 Z2.680 X159.179 Y84.765 E0.00627 ; perimeter
G1 Z2.683 X161.571 Y87.157 E0.11451 ; perimeter
G1 Z2.683 X161.571 Y87.219 E0.00202 ; perimeter
G1 Z2.683 X161.571 Y87.406 E0.00627 ; perimeter
G1 Z2.717 X161.571 Y122.270 E1.18012 ; perimeter
G1 Z2.717 X161.527 Y122.314 E0.00202 ; perimeter
G1 Z2.717 X161.395 Y122.447 E0.00627 ; perimeter
G1 Z2.721 X159.003 Y124.839 E0.11451 ; perimeter
G1 Z2.721 X158.941 Y124.839 E0.00202 ; perimeter
G1 Z2.721 X158.754 Y124.839 E0.00627 ; perimeter
G1 Z2.779 X98.889 Y124.839 E2.02635 ; perimeter
G1 Z2.779 X98.845 Y124.795 E0.00202 ; perimeter
G1 Z2.780 X98.713 Y124.663 E0.00627 ; perimeter
G1 Z2.783 X96.321 Y122.270 E0.11451 ; perimeter
G1 Z2.783 X96.321 Y122.208 E0.00202 ; perimeter
G1 Z2.783 X96.321 Y122.021 E0.00627 ; perimeter
G1 Z2.800 X96.321 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
; starting change to layer 14, at 3mm
;3

M106 S56

G1 Z2.800 F12000.000 ; move to next layer (14)
;AFTER_LAYER_CHANGE
; starting layer 14, at 3mm
;3

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F600
G1 Z2.817 X96.121 Y87.157 E0.59246 ; perimeter
G1 Z2.817 X96.165 Y87.113 E0.00202 ; perimeter
G1 Z2.817 X96.297 Y86.981 E0.00627 ; perimeter
G1 Z2.821 X98.889 Y84.389 E0.12408 ; perimeter
G1 Z2.821 X98.951 Y84.389 E0.00202 ; perimeter
G1 Z2.821 X99.138 Y84.389 E0.00627 ; perimeter
G1 Z2.879 X159.003 Y84.389 E2.02635 ; perimeter
G1 Z2.879 X159.047 Y84.433 E0.00202 ; perimeter
G1 Z2.879 X159.179 Y84.565 E0.00627 ; perimeter
G1 Z2.883 X161.771 Y87.157 E0.12408 ; perimeter
G1 Z2.883 X161.771 Y87.219 E0.00202 ; perimeter
G1 Z2.883 X161.771 Y87.406 E0.00627 ; perimeter
G1 Z2.917 X161.771 Y122.270 E1.18012 ; perimeter
G1 Z2.917 X161.727 Y122.314 E0.00202 ; perimeter
G1 Z2.917 X161.595 Y122.447 E0.00627 ; perimeter
G1 Z2.921 X159.003 Y125.039 E0.12408 ; perimeter
G1 Z2.921 X158.941 Y125.039 E0.00202 ; perimeter
G1 Z2.921 X158.754 Y125.039 E0.00627 ; perimeter
G1 Z2.979 X98.889 Y125.039 E2.02635 ; perimeter
G1 Z2.979 X98.845 Y124.995 E0.00202 ; perimeter
G1 Z2.979 X98.713 Y124.863 E0.00627 ; perimeter
G1 Z2.983 X96.121 Y122.270 E0.12408 ; perimeter
G1 Z2.983 X96.121 Y122.208 E0.00202 ; perimeter
G1 Z2.983 X96.121 Y122.021 E0.00627 ; perimeter
G1 Z3.000 X96.121 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
3.2;3.2

M106 S56

G1 Z3.000 F12000.000 ; move to next layer (15)
;AFTER_LAYER_CHANGE
; starting layer 15, at 3.2mm
;3.2

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z3.017 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z3.017 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z3.017 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z3.021 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z3.021 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z3.021 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z3.079 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z3.079 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z3.079 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z3.083 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z3.083 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z3.083 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z3.117 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z3.117 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z3.117 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z3.121 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z3.121 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z3.121 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z3.179 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z3.179 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z3.179 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z3.183 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z3.183 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z3.183 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z3.200 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
3.4;3.4

M106 S56

G1 Z3.200 F12000.000 ; move to next layer (16)
;AFTER_LAYER_CHANGE
; starting layer 16, at 3.4mm
;3.4

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z3.217 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z3.217 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z3.217 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z3.221 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z3.221 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z3.221 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z3.279 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z3.279 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z3.279 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z3.283 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z3.283 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z3.283 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z3.317 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z3.317 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z3.317 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z3.321 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z3.321 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z3.321 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z3.379 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z3.379 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z3.379 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z3.383 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z3.383 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z3.383 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z3.400 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
3.6;3.6

M106 S56

G1 Z3.400 F12000.000 ; move to next layer (17)
;AFTER_LAYER_CHANGE
; starting layer 17, at 3.6mm
;3.6

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z3.417 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z3.417 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z3.417 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z3.421 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z3.421 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z3.421 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z3.479 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z3.479 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z3.479 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z3.483 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z3.483 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z3.483 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z3.517 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z3.517 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z3.517 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z3.521 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z3.521 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z3.521 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z3.579 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z3.579 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z3.579 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z3.583 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z3.583 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z3.583 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z3.600 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
3.8;3.8

M106 S56

G1 Z3.600 F12000.000 ; move to next layer (18)
;AFTER_LAYER_CHANGE
; starting layer 18, at 3.8mm
;3.8

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z3.617 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z3.617 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z3.617 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z3.621 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z3.621 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z3.621 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z3.679 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z3.679 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z3.679 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z3.683 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z3.683 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z3.683 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z3.717 X161.871 Y122.270 E1.18012 ; perimeter
M73 Q76 S4
M73 P76 R4
G1 Z3.717 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z3.717 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z3.721 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z3.721 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z3.721 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z3.779 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z3.779 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z3.779 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z3.783 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z3.783 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z3.783 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z3.800 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
; starting change to layer 19, at 4mm
;4

M106 S56

G1 Z3.800 F12000.000 ; move to next layer (19)
;AFTER_LAYER_CHANGE
; starting layer 19, at 4mm
;4

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z3.817 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z3.817 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z3.817 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z3.821 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z3.821 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z3.821 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z3.879 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z3.879 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z3.879 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z3.883 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z3.883 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z3.883 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z3.917 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z3.917 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z3.917 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z3.921 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z3.921 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z3.921 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z3.979 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z3.979 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z3.979 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z3.983 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z3.983 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z3.983 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z4.000 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
4.2;4.2

M106 S56

G1 Z4.000 F12000.000 ; move to next layer (20)
;AFTER_LAYER_CHANGE
; starting layer 20, at 4.2mm
;4.2

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z4.017 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z4.017 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z4.017 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z4.021 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z4.021 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z4.021 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z4.079 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z4.079 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z4.079 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z4.083 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z4.083 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z4.083 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z4.117 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z4.117 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z4.117 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z4.121 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z4.121 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z4.121 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z4.179 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z4.179 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z4.179 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z4.183 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z4.183 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z4.183 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z4.200 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
4.4;4.4

M106 S56

G1 Z4.200 F12000.000 ; move to next layer (21)
;AFTER_LAYER_CHANGE
; starting layer 21, at 4.4mm
;4.4

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z4.217 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z4.217 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z4.217 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z4.221 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z4.221 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z4.221 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z4.279 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z4.279 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z4.279 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z4.283 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z4.283 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z4.283 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z4.317 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z4.317 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z4.317 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z4.321 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z4.321 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z4.321 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z4.379 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z4.379 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z4.379 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z4.383 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z4.383 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z4.383 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z4.400 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
4.6;4.6

M106 S56

G1 Z4.400 F12000.000 ; move to next layer (22)
;AFTER_LAYER_CHANGE
; starting layer 22, at 4.6mm
;4.6

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z4.417 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z4.417 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z4.417 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z4.421 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z4.421 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z4.421 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z4.479 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z4.479 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z4.479 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z4.483 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z4.483 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z4.483 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z4.517 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z4.517 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z4.517 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z4.521 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z4.521 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z4.521 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z4.579 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z4.579 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z4.579 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z4.583 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z4.583 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z4.583 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z4.600 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
4.8;4.8

M106 S56

G1 Z4.600 F12000.000 ; move to next layer (23)
;AFTER_LAYER_CHANGE
; starting layer 23, at 4.8mm
;4.8

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z4.617 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z4.617 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z4.617 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z4.621 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z4.621 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z4.621 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z4.679 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z4.679 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z4.679 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z4.683 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z4.683 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z4.683 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z4.717 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z4.717 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z4.717 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z4.721 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z4.721 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z4.721 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z4.779 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z4.779 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z4.779 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z4.783 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z4.783 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z4.783 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z4.800 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
; starting change to layer 24, at 5mm
;5

M106 S56

G1 Z4.800 F12000.000 ; move to next layer (24)
;AFTER_LAYER_CHANGE
; starting layer 24, at 5mm
;5

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z4.817 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z4.817 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z4.817 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z4.821 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z4.821 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z4.821 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z4.879 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z4.879 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z4.879 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z4.883 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z4.883 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z4.883 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z4.917 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z4.917 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z4.917 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z4.921 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z4.921 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z4.921 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z4.979 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z4.979 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z4.979 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z4.983 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z4.983 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z4.983 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z5.000 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
5.2;5.2

M106 S56

G1 Z5.000 F12000.000 ; move to next layer (25)
;AFTER_LAYER_CHANGE
; starting layer 25, at 5.2mm
;5.2

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z5.009 X95.971 Y95.039 E0.32567 ; perimeter
G1 Z5.009 X96.021 Y94.936 E0.00300 ; perimeter
G1 Z5.010 X96.021 Y94.630 E0.01011 ; perimeter
G1 Z5.017 X96.021 Y87.157 E0.25294 ; perimeter
G1 Z5.017 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z5.017 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z5.021 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z5.021 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z5.021 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z5.041 X119.271 Y84.289 E0.68147 ; perimeter
G1 Z5.041 X119.373 Y84.239 E0.00300 ; perimeter
G1 Z5.041 X119.680 Y84.239 E0.01011 ; perimeter
G1 Z5.059 X138.621 Y84.239 E0.64113 ; perimeter
G1 Z5.059 X138.723 Y84.289 E0.00300 ; perimeter
G1 Z5.060 X139.030 Y84.289 E0.01011 ; perimeter
G1 Z5.079 X159.003 Y84.289 E0.67605 ; perimeter
G1 Z5.079 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z5.079 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z5.083 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z5.083 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z5.083 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z5.091 X161.871 Y95.039 E0.25836 ; perimeter
G1 Z5.091 X161.921 Y95.141 E0.00300 ; perimeter
G1 Z5.091 X161.921 Y95.448 E0.01011 ; perimeter
G1 Z5.109 X161.921 Y114.389 E0.64113 ; perimeter
G1 Z5.109 X161.871 Y114.491 E0.00300 ; perimeter
G1 Z5.110 X161.871 Y114.798 E0.01011 ; perimeter
G1 Z5.117 X161.871 Y122.270 E0.25294 ; perimeter
G1 Z5.117 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z5.117 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z5.121 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z5.121 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z5.121 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z5.141 X138.621 Y125.139 E0.68147 ; perimeter
G1 Z5.141 X138.519 Y125.189 E0.00300 ; perimeter
G1 Z5.141 X138.212 Y125.189 E0.01011 ; perimeter
G1 Z5.159 X119.271 Y125.189 E0.64113 ; perimeter
G1 Z5.159 X119.169 Y125.139 E0.00300 ; perimeter
G1 Z5.160 X118.862 Y125.139 E0.01011 ; perimeter
G1 Z5.179 X98.889 Y125.139 E0.67605 ; perimeter
G1 Z5.179 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z5.179 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z5.183 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z5.183 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z5.183 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z5.191 X96.021 Y114.389 E0.25836 ; perimeter
G1 Z5.191 X95.971 Y114.286 E0.00300 ; perimeter
G1 Z5.191 X95.971 Y113.980 E0.01011 ; perimeter
G1 Z5.200 X95.971 Y104.714 E0.31364 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
5.4;5.4

M106 S56

G1 Z5.200 F12000.000 ; move to next layer (26)
;AFTER_LAYER_CHANGE
; starting layer 26, at 5.4mm
;5.4

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
G1 E0.00731 F2100.00000 ; unretract
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z5.209 X95.671 Y95.039 E0.32567 ; perimeter
G1 Z5.209 X95.773 Y95.039 E0.00300 ; perimeter
G1 Z5.210 X96.021 Y95.039 E0.00816 ; perimeter
G1 Z5.210 X96.021 Y94.936 E0.00300 ; perimeter
G1 Z5.210 X96.021 Y94.630 E0.01011 ; perimeter
G1 Z5.217 X96.021 Y87.157 E0.25294 ; perimeter
G1 Z5.217 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z5.217 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z5.221 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z5.221 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z5.221 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z5.240 X119.271 Y84.289 E0.68147 ; perimeter
G1 Z5.241 X119.271 Y84.186 E0.00300 ; perimeter
G1 Z5.241 X119.271 Y83.939 E0.00816 ; perimeter
G1 Z5.241 X119.373 Y83.939 E0.00300 ; perimeter
G1 Z5.241 X119.680 Y83.939 E0.01011 ; perimeter
G1 Z5.259 X138.621 Y83.939 E0.64113 ; perimeter
G1 Z5.259 X138.621 Y84.041 E0.00300 ; perimeter
G1 Z5.260 X138.621 Y84.289 E0.00816 ; perimeter
G1 Z5.260 X138.723 Y84.289 E0.00300 ; perimeter
G1 Z5.260 X139.030 Y84.289 E0.01011 ; perimeter
G1 Z5.279 X159.003 Y84.289 E0.67605 ; perimeter
G1 Z5.279 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z5.279 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z5.283 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z5.283 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z5.283 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z5.290 X161.871 Y95.039 E0.25836 ; perimeter
G1 Z5.291 X161.973 Y95.039 E0.00300 ; perimeter
G1 Z5.291 X162.221 Y95.039 E0.00816 ; perimeter
G1 Z5.291 X162.221 Y95.141 E0.00300 ; perimeter
G1 Z5.291 X162.221 Y95.448 E0.01011 ; perimeter
G1 Z5.309 X162.221 Y114.389 E0.64113 ; perimeter
G1 Z5.309 X162.119 Y114.389 E0.00300 ; perimeter
G1 Z5.310 X161.871 Y114.389 E0.00816 ; perimeter
G1 Z5.310 X161.871 Y114.491 E0.00300 ; perimeter
G1 Z5.310 X161.871 Y114.798 E0.01011 ; perimeter
G1 Z5.317 X161.871 Y122.270 E0.25294 ; perimeter
G1 Z5.317 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z5.317 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z5.321 X159.003 Y125.139 E0.12887 ; perimeter
M73 Q82 S3
M73 P82 R3
G1 Z5.321 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z5.321 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z5.340 X138.621 Y125.139 E0.68147 ; perimeter
G1 Z5.341 X138.621 Y125.241 E0.00300 ; perimeter
G1 Z5.341 X138.621 Y125.489 E0.00816 ; perimeter
G1 Z5.341 X138.519 Y125.489 E0.00300 ; perimeter
G1 Z5.341 X138.212 Y125.489 E0.01011 ; perimeter
G1 Z5.359 X119.271 Y125.489 E0.64113 ; perimeter
G1 Z5.359 X119.271 Y125.386 E0.00300 ; perimeter
G1 Z5.360 X119.271 Y125.139 E0.00816 ; perimeter
G1 Z5.360 X119.169 Y125.139 E0.00300 ; perimeter
G1 Z5.360 X118.862 Y125.139 E0.01011 ; perimeter
G1 Z5.379 X98.889 Y125.139 E0.67605 ; perimeter
G1 Z5.379 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z5.379 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z5.383 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z5.383 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z5.383 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z5.390 X96.021 Y114.389 E0.25836 ; perimeter
G1 Z5.391 X95.919 Y114.389 E0.00300 ; perimeter
G1 Z5.391 X95.671 Y114.389 E0.00816 ; perimeter
G1 Z5.391 X95.671 Y114.286 E0.00300 ; perimeter
G1 Z5.391 X95.671 Y113.980 E0.01011 ; perimeter
G1 Z5.400 X95.671 Y104.714 E0.31364 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
5.6;5.6

M106 S56

G1 Z5.400 F12000.000 ; move to next layer (27)
;AFTER_LAYER_CHANGE
; starting layer 27, at 5.6mm
;5.6

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z5.409 X95.371 Y95.039 E0.32567 ; perimeter
G1 Z5.409 X95.473 Y95.039 E0.00300 ; perimeter
G1 Z5.410 X95.780 Y95.039 E0.01011 ; perimeter
G1 Z5.410 X96.021 Y95.039 E0.00816 ; perimeter
G1 Z5.410 X96.021 Y94.936 E0.00300 ; perimeter
G1 Z5.410 X96.021 Y94.630 E0.01011 ; perimeter
G1 Z5.417 X96.021 Y87.157 E0.25294 ; perimeter
G1 Z5.417 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z5.417 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z5.421 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z5.421 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z5.421 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z5.440 X119.271 Y84.289 E0.68147 ; perimeter
G1 Z5.440 X119.271 Y84.186 E0.00300 ; perimeter
G1 Z5.441 X119.271 Y83.880 E0.01011 ; perimeter
G1 Z5.441 X119.271 Y83.639 E0.00816 ; perimeter
G1 Z5.441 X119.373 Y83.639 E0.00300 ; perimeter
G1 Z5.441 X119.680 Y83.639 E0.01011 ; perimeter
G1 Z5.459 X138.621 Y83.639 E0.64113 ; perimeter
G1 Z5.459 X138.621 Y83.741 E0.00300 ; perimeter
G1 Z5.460 X138.621 Y84.048 E0.01011 ; perimeter
G1 Z5.460 X138.621 Y84.289 E0.00815 ; perimeter
G1 Z5.460 X138.723 Y84.289 E0.00300 ; perimeter
G1 Z5.460 X139.030 Y84.289 E0.01011 ; perimeter
G1 Z5.479 X159.003 Y84.289 E0.67605 ; perimeter
G1 Z5.479 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z5.479 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z5.483 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z5.483 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z5.483 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z5.490 X161.871 Y95.039 E0.25836 ; perimeter
G1 Z5.490 X161.973 Y95.039 E0.00300 ; perimeter
G1 Z5.491 X162.280 Y95.039 E0.01011 ; perimeter
G1 Z5.491 X162.521 Y95.039 E0.00816 ; perimeter
G1 Z5.491 X162.521 Y95.141 E0.00300 ; perimeter
G1 Z5.491 X162.521 Y95.448 E0.01011 ; perimeter
G1 Z5.509 X162.521 Y114.389 E0.64113 ; perimeter
G1 Z5.509 X162.419 Y114.389 E0.00300 ; perimeter
G1 Z5.510 X162.112 Y114.389 E0.01011 ; perimeter
G1 Z5.510 X161.871 Y114.389 E0.00816 ; perimeter
G1 Z5.510 X161.871 Y114.491 E0.00300 ; perimeter
G1 Z5.510 X161.871 Y114.798 E0.01011 ; perimeter
G1 Z5.517 X161.871 Y122.270 E0.25294 ; perimeter
G1 Z5.517 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z5.517 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z5.521 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z5.521 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z5.521 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z5.540 X138.621 Y125.139 E0.68147 ; perimeter
G1 Z5.540 X138.621 Y125.241 E0.00300 ; perimeter
G1 Z5.541 X138.621 Y125.548 E0.01011 ; perimeter
G1 Z5.541 X138.621 Y125.789 E0.00816 ; perimeter
G1 Z5.541 X138.519 Y125.789 E0.00300 ; perimeter
G1 Z5.541 X138.212 Y125.789 E0.01011 ; perimeter
G1 Z5.559 X119.271 Y125.789 E0.64113 ; perimeter
G1 Z5.559 X119.271 Y125.686 E0.00300 ; perimeter
G1 Z5.560 X119.271 Y125.380 E0.01011 ; perimeter
G1 Z5.560 X119.271 Y125.139 E0.00815 ; perimeter
G1 Z5.560 X119.169 Y125.139 E0.00300 ; perimeter
G1 Z5.560 X118.862 Y125.139 E0.01011 ; perimeter
G1 Z5.579 X98.889 Y125.139 E0.67605 ; perimeter
G1 Z5.579 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z5.579 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z5.583 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z5.583 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z5.583 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z5.590 X96.021 Y114.389 E0.25836 ; perimeter
G1 Z5.590 X95.919 Y114.389 E0.00300 ; perimeter
G1 Z5.591 X95.612 Y114.389 E0.01011 ; perimeter
G1 Z5.591 X95.371 Y114.389 E0.00816 ; perimeter
G1 Z5.591 X95.371 Y114.286 E0.00300 ; perimeter
G1 Z5.591 X95.371 Y113.980 E0.01011 ; perimeter
G1 Z5.600 X95.371 Y104.714 E0.31364 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
5.8;5.8

M106 S56

G1 Z5.600 F12000.000 ; move to next layer (28)
;AFTER_LAYER_CHANGE
; starting layer 28, at 5.8mm
;5.8

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z5.609 X95.071 Y95.039 E0.32567 ; perimeter
G1 Z5.609 X95.173 Y95.039 E0.00300 ; perimeter
G1 Z5.609 X95.480 Y95.039 E0.01011 ; perimeter
G1 Z5.610 X96.021 Y95.039 E0.01831 ; perimeter
G1 Z5.610 X96.021 Y94.936 E0.00300 ; perimeter
G1 Z5.610 X96.021 Y94.630 E0.01011 ; perimeter
G1 Z5.617 X96.021 Y87.157 E0.25294 ; perimeter
G1 Z5.617 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z5.618 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z5.621 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z5.621 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z5.621 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z5.640 X119.271 Y84.289 E0.68147 ; perimeter
G1 Z5.640 X119.271 Y84.186 E0.00300 ; perimeter
G1 Z5.640 X119.271 Y83.880 E0.01011 ; perimeter
G1 Z5.641 X119.271 Y83.339 E0.01831 ; perimeter
G1 Z5.641 X119.373 Y83.339 E0.00300 ; perimeter
G1 Z5.641 X119.680 Y83.339 E0.01011 ; perimeter
G1 Z5.659 X138.621 Y83.339 E0.64113 ; perimeter
G1 Z5.659 X138.621 Y83.441 E0.00300 ; perimeter
G1 Z5.659 X138.621 Y83.748 E0.01011 ; perimeter
G1 Z5.660 X138.621 Y84.289 E0.01831 ; perimeter
G1 Z5.660 X138.723 Y84.289 E0.00300 ; perimeter
G1 Z5.660 X139.030 Y84.289 E0.01011 ; perimeter
G1 Z5.679 X159.003 Y84.289 E0.67605 ; perimeter
G1 Z5.679 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z5.679 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z5.683 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z5.683 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z5.683 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z5.690 X161.871 Y95.039 E0.25836 ; perimeter
G1 Z5.690 X161.973 Y95.039 E0.00300 ; perimeter
G1 Z5.690 X162.280 Y95.039 E0.01011 ; perimeter
G1 Z5.691 X162.821 Y95.039 E0.01831 ; perimeter
G1 Z5.691 X162.821 Y95.141 E0.00300 ; perimeter
G1 Z5.691 X162.821 Y95.448 E0.01011 ; perimeter
G1 Z5.709 X162.821 Y114.389 E0.64113 ; perimeter
G1 Z5.709 X162.719 Y114.389 E0.00300 ; perimeter
G1 Z5.709 X162.412 Y114.389 E0.01011 ; perimeter
G1 Z5.710 X161.871 Y114.389 E0.01831 ; perimeter
G1 Z5.710 X161.871 Y114.491 E0.00300 ; perimeter
G1 Z5.710 X161.871 Y114.798 E0.01011 ; perimeter
G1 Z5.717 X161.871 Y122.270 E0.25294 ; perimeter
G1 Z5.717 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z5.718 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z5.721 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z5.721 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z5.721 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z5.740 X138.621 Y125.139 E0.68147 ; perimeter
G1 Z5.740 X138.621 Y125.241 E0.00300 ; perimeter
G1 Z5.740 X138.621 Y125.548 E0.01011 ; perimeter
G1 Z5.741 X138.621 Y126.089 E0.01831 ; perimeter
G1 Z5.741 X138.519 Y126.089 E0.00300 ; perimeter
G1 Z5.741 X138.212 Y126.089 E0.01011 ; perimeter
G1 Z5.759 X119.271 Y126.089 E0.64113 ; perimeter
G1 Z5.759 X119.271 Y125.986 E0.00300 ; perimeter
G1 Z5.759 X119.271 Y125.680 E0.01011 ; perimeter
G1 Z5.760 X119.271 Y125.139 E0.01831 ; perimeter
G1 Z5.760 X119.169 Y125.139 E0.00300 ; perimeter
G1 Z5.760 X118.862 Y125.139 E0.01011 ; perimeter
G1 Z5.779 X98.889 Y125.139 E0.67605 ; perimeter
G1 Z5.779 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z5.779 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z5.783 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z5.783 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z5.783 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z5.790 X96.021 Y114.389 E0.25836 ; perimeter
G1 Z5.790 X95.919 Y114.389 E0.00300 ; perimeter
G1 Z5.790 X95.612 Y114.389 E0.01011 ; perimeter
G1 Z5.791 X95.071 Y114.389 E0.01831 ; perimeter
G1 Z5.791 X95.071 Y114.286 E0.00300 ; perimeter
G1 Z5.791 X95.071 Y113.980 E0.01011 ; perimeter
G1 Z5.800 X95.071 Y104.714 E0.31364 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
; starting change to layer 29, at 6mm
;6

M106 S20

G1 Z5.800 F12000.000 ; move to next layer (29)
;AFTER_LAYER_CHANGE
; starting layer 29, at 6mm
;6

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z5.809 X94.771 Y95.039 E0.32567 ; perimeter
G1 Z5.809 X94.873 Y95.039 E0.00300 ; perimeter
G1 Z5.809 X95.180 Y95.039 E0.01011 ; perimeter
G1 Z5.810 X96.021 Y95.039 E0.02847 ; perimeter
G1 Z5.810 X96.021 Y94.936 E0.00300 ; perimeter
G1 Z5.810 X96.021 Y94.630 E0.01011 ; perimeter
G1 Z5.817 X96.021 Y87.157 E0.25294 ; perimeter
G1 Z5.817 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z5.818 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z5.821 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z5.821 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z5.821 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z5.840 X119.271 Y84.289 E0.68147 ; perimeter
G1 Z5.840 X119.271 Y84.186 E0.00300 ; perimeter
G1 Z5.840 X119.271 Y83.880 E0.01011 ; perimeter
G1 Z5.841 X119.271 Y83.039 E0.02847 ; perimeter
G1 Z5.841 X119.373 Y83.039 E0.00300 ; perimeter
G1 Z5.841 X119.680 Y83.039 E0.01011 ; perimeter
G1 Z5.859 X138.621 Y83.039 E0.64113 ; perimeter
G1 Z5.859 X138.621 Y83.141 E0.00300 ; perimeter
G1 Z5.859 X138.621 Y83.448 E0.01011 ; perimeter
G1 Z5.860 X138.621 Y84.289 E0.02846 ; perimeter
G1 Z5.860 X138.723 Y84.289 E0.00300 ; perimeter
G1 Z5.860 X139.030 Y84.289 E0.01011 ; perimeter
G1 Z5.879 X159.003 Y84.289 E0.67605 ; perimeter
G1 Z5.879 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z5.879 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z5.883 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z5.883 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z5.883 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z5.890 X161.871 Y95.039 E0.25836 ; perimeter
G1 Z5.890 X161.973 Y95.039 E0.00300 ; perimeter
G1 Z5.890 X162.280 Y95.039 E0.01011 ; perimeter
G1 Z5.891 X163.121 Y95.039 E0.02847 ; perimeter
G1 Z5.891 X163.121 Y95.141 E0.00300 ; perimeter
G1 Z5.891 X163.121 Y95.448 E0.01011 ; perimeter
G1 Z5.909 X163.121 Y114.389 E0.64113 ; perimeter
G1 Z5.909 X163.019 Y114.389 E0.00300 ; perimeter
G1 Z5.909 X162.712 Y114.389 E0.01011 ; perimeter
G1 Z5.910 X161.871 Y114.389 E0.02847 ; perimeter
G1 Z5.910 X161.871 Y114.491 E0.00300 ; perimeter
G1 Z5.910 X161.871 Y114.798 E0.01011 ; perimeter
G1 Z5.917 X161.871 Y122.270 E0.25294 ; perimeter
G1 Z5.917 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z5.918 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z5.921 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z5.921 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z5.921 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z5.940 X138.621 Y125.139 E0.68147 ; perimeter
G1 Z5.940 X138.621 Y125.241 E0.00300 ; perimeter
G1 Z5.940 X138.621 Y125.548 E0.01011 ; perimeter
G1 Z5.941 X138.621 Y126.389 E0.02847 ; perimeter
G1 Z5.941 X138.519 Y126.389 E0.00300 ; perimeter
G1 Z5.941 X138.212 Y126.389 E0.01011 ; perimeter
G1 Z5.959 X119.271 Y126.389 E0.64113 ; perimeter
G1 Z5.959 X119.271 Y126.286 E0.00300 ; perimeter
G1 Z5.959 X119.271 Y125.980 E0.01011 ; perimeter
G1 Z5.960 X119.271 Y125.139 E0.02846 ; perimeter
G1 Z5.960 X119.169 Y125.139 E0.00300 ; perimeter
G1 Z5.960 X118.862 Y125.139 E0.01011 ; perimeter
G1 Z5.979 X98.889 Y125.139 E0.67605 ; perimeter
G1 Z5.979 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z5.979 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z5.983 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z5.983 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z5.983 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z5.990 X96.021 Y114.389 E0.25836 ; perimeter
G1 Z5.990 X95.919 Y114.389 E0.00300 ; perimeter
G1 Z5.990 X95.612 Y114.389 E0.01011 ; perimeter
G1 Z5.991 X94.771 Y114.389 E0.02847 ; perimeter
G1 Z5.991 X94.771 Y114.286 E0.00300 ; perimeter
G1 Z5.991 X94.771 Y113.980 E0.01011 ; perimeter
G1 Z6.000 X94.771 Y104.714 E0.31364 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
6.2;6.2

M106 S20

G1 Z6.000 F12000.000 ; move to next layer (30)
;AFTER_LAYER_CHANGE
; starting layer 30, at 6.2mm
;6.2

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z6.009 X94.771 Y95.039 E0.32567 ; perimeter
G1 Z6.009 X94.873 Y95.039 E0.00300 ; perimeter
G1 Z6.009 X95.180 Y95.039 E0.01011 ; perimeter
G1 Z6.010 X96.021 Y95.039 E0.02846 ; perimeter
G1 Z6.010 X96.021 Y94.936 E0.00300 ; perimeter
G1 Z6.010 X96.021 Y94.630 E0.01011 ; perimeter
G1 Z6.017 X96.021 Y87.157 E0.25294 ; perimeter
G1 Z6.017 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z6.018 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z6.021 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z6.021 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z6.021 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z6.040 X119.271 Y84.289 E0.68147 ; perimeter
G1 Z6.040 X119.271 Y84.186 E0.00300 ; perimeter
G1 Z6.040 X119.271 Y83.880 E0.01011 ; perimeter
G1 Z6.041 X119.271 Y83.039 E0.02847 ; perimeter
G1 Z6.041 X119.373 Y83.039 E0.00300 ; perimeter
G1 Z6.041 X119.680 Y83.039 E0.01011 ; perimeter
G1 Z6.059 X138.621 Y83.039 E0.64113 ; perimeter
G1 Z6.059 X138.621 Y83.141 E0.00300 ; perimeter
G1 Z6.059 X138.621 Y83.448 E0.01011 ; perimeter
G1 Z6.060 X138.621 Y84.289 E0.02847 ; perimeter
G1 Z6.060 X138.723 Y84.289 E0.00300 ; perimeter
G1 Z6.060 X139.030 Y84.289 E0.01011 ; perimeter
G1 Z6.079 X159.003 Y84.289 E0.67605 ; perimeter
G1 Z6.079 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z6.079 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z6.083 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z6.083 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z6.083 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z6.090 X161.871 Y95.039 E0.25836 ; perimeter
G1 Z6.090 X161.973 Y95.039 E0.00300 ; perimeter
G1 Z6.090 X162.280 Y95.039 E0.01011 ; perimeter
G1 Z6.091 X163.121 Y95.039 E0.02847 ; perimeter
G1 Z6.091 X163.121 Y95.141 E0.00300 ; perimeter
G1 Z6.091 X163.121 Y95.448 E0.01011 ; perimeter
G1 Z6.109 X163.121 Y114.389 E0.64113 ; perimeter
G1 Z6.109 X163.019 Y114.389 E0.00300 ; perimeter
G1 Z6.109 X162.712 Y114.389 E0.01011 ; perimeter
G1 Z6.110 X161.871 Y114.389 E0.02846 ; perimeter
G1 Z6.110 X161.871 Y114.491 E0.00300 ; perimeter
G1 Z6.110 X161.871 Y114.798 E0.01011 ; perimeter
G1 Z6.117 X161.871 Y122.270 E0.25294 ; perimeter
G1 Z6.117 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z6.118 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z6.121 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z6.121 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z6.121 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z6.140 X138.621 Y125.139 E0.68147 ; perimeter
G1 Z6.140 X138.621 Y125.241 E0.00300 ; perimeter
G1 Z6.140 X138.621 Y125.548 E0.01011 ; perimeter
G1 Z6.141 X138.621 Y126.389 E0.02847 ; perimeter
G1 Z6.141 X138.519 Y126.389 E0.00300 ; perimeter
G1 Z6.141 X138.212 Y126.389 E0.01011 ; perimeter
G1 Z6.159 X119.271 Y126.389 E0.64113 ; perimeter
G1 Z6.159 X119.271 Y126.286 E0.00300 ; perimeter
G1 Z6.159 X119.271 Y125.980 E0.01011 ; perimeter
G1 Z6.160 X119.271 Y125.139 E0.02847 ; perimeter
G1 Z6.160 X119.169 Y125.139 E0.00300 ; perimeter
G1 Z6.160 X118.862 Y125.139 E0.01011 ; perimeter
G1 Z6.179 X98.889 Y125.139 E0.67605 ; perimeter
G1 Z6.179 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z6.179 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z6.183 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z6.183 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z6.183 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z6.190 X96.021 Y114.389 E0.25836 ; perimeter
G1 Z6.190 X95.919 Y114.389 E0.00300 ; perimeter
G1 Z6.190 X95.612 Y114.389 E0.01011 ; perimeter
G1 Z6.191 X94.771 Y114.389 E0.02847 ; perimeter
G1 Z6.191 X94.771 Y114.286 E0.00300 ; perimeter
G1 Z6.191 X94.771 Y113.980 E0.01011 ; perimeter
G1 Z6.200 X94.771 Y104.714 E0.31364 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
6.4;6.4

M106 S20

G1 Z6.200 F12000.000 ; move to next layer (31)
;AFTER_LAYER_CHANGE
; starting layer 31, at 6.4mm
;6.4

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z6.209 X95.071 Y95.039 E0.32567 ; perimeter
G1 Z6.209 X95.173 Y95.039 E0.00300 ; perimeter
G1 Z6.209 X95.480 Y95.039 E0.01011 ; perimeter
G1 Z6.210 X96.021 Y95.039 E0.01831 ; perimeter
G1 Z6.210 X96.021 Y94.936 E0.00300 ; perimeter
G1 Z6.210 X96.021 Y94.630 E0.01011 ; perimeter
G1 Z6.217 X96.021 Y87.157 E0.25294 ; perimeter
G1 Z6.217 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z6.218 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z6.221 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z6.221 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z6.221 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z6.240 X119.271 Y84.289 E0.68147 ; perimeter
G1 Z6.240 X119.271 Y84.186 E0.00300 ; perimeter
G1 Z6.240 X119.271 Y83.880 E0.01011 ; perimeter
G1 Z6.241 X119.271 Y83.339 E0.01831 ; perimeter
G1 Z6.241 X119.373 Y83.339 E0.00300 ; perimeter
G1 Z6.241 X119.680 Y83.339 E0.01011 ; perimeter
G1 Z6.259 X138.621 Y83.339 E0.64113 ; perimeter
G1 Z6.259 X138.621 Y83.441 E0.00300 ; perimeter
G1 Z6.259 X138.621 Y83.748 E0.01011 ; perimeter
G1 Z6.260 X138.621 Y84.289 E0.01831 ; perimeter
G1 Z6.260 X138.723 Y84.289 E0.00300 ; perimeter
G1 Z6.260 X139.030 Y84.289 E0.01011 ; perimeter
G1 Z6.279 X159.003 Y84.289 E0.67605 ; perimeter
G1 Z6.279 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z6.279 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z6.283 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z6.283 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z6.283 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z6.290 X161.871 Y95.039 E0.25836 ; perimeter
G1 Z6.290 X161.973 Y95.039 E0.00300 ; perimeter
G1 Z6.290 X162.280 Y95.039 E0.01011 ; perimeter
G1 Z6.291 X162.821 Y95.039 E0.01831 ; perimeter
G1 Z6.291 X162.821 Y95.141 E0.00300 ; perimeter
G1 Z6.291 X162.821 Y95.448 E0.01011 ; perimeter
G1 Z6.309 X162.821 Y114.389 E0.64113 ; perimeter
G1 Z6.309 X162.719 Y114.389 E0.00300 ; perimeter
G1 Z6.309 X162.412 Y114.389 E0.01011 ; perimeter
G1 Z6.310 X161.871 Y114.389 E0.01831 ; perimeter
G1 Z6.310 X161.871 Y114.491 E0.00300 ; perimeter
G1 Z6.310 X161.871 Y114.798 E0.01011 ; perimeter
G1 Z6.317 X161.871 Y122.270 E0.25294 ; perimeter
G1 Z6.317 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z6.318 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z6.321 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z6.321 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z6.321 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z6.340 X138.621 Y125.139 E0.68147 ; perimeter
G1 Z6.340 X138.621 Y125.241 E0.00300 ; perimeter
G1 Z6.340 X138.621 Y125.548 E0.01011 ; perimeter
G1 Z6.341 X138.621 Y126.089 E0.01831 ; perimeter
G1 Z6.341 X138.519 Y126.089 E0.00300 ; perimeter
G1 Z6.341 X138.212 Y126.089 E0.01011 ; perimeter
G1 Z6.359 X119.271 Y126.089 E0.64113 ; perimeter
G1 Z6.359 X119.271 Y125.986 E0.00300 ; perimeter
G1 Z6.359 X119.271 Y125.680 E0.01011 ; perimeter
G1 Z6.360 X119.271 Y125.139 E0.01831 ; perimeter
G1 Z6.360 X119.169 Y125.139 E0.00300 ; perimeter
G1 Z6.360 X118.862 Y125.139 E0.01011 ; perimeter
G1 Z6.379 X98.889 Y125.139 E0.67605 ; perimeter
G1 Z6.379 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z6.379 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z6.383 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z6.383 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z6.383 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z6.390 X96.021 Y114.389 E0.25836 ; perimeter
G1 Z6.390 X95.919 Y114.389 E0.00300 ; perimeter
G1 Z6.390 X95.612 Y114.389 E0.01011 ; perimeter
G1 Z6.391 X95.071 Y114.389 E0.01831 ; perimeter
G1 Z6.391 X95.071 Y114.286 E0.00300 ; perimeter
G1 Z6.391 X95.071 Y113.980 E0.01011 ; perimeter
G1 Z6.400 X95.071 Y104.714 E0.31364 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
6.6;6.6

M106 S20

G1 Z6.400 F12000.000 ; move to next layer (32)
;AFTER_LAYER_CHANGE
; starting layer 32, at 6.6mm
;6.6

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z6.409 X95.371 Y95.039 E0.32567 ; perimeter
G1 Z6.409 X95.473 Y95.039 E0.00300 ; perimeter
G1 Z6.410 X95.780 Y95.039 E0.01011 ; perimeter
G1 Z6.410 X96.021 Y95.039 E0.00815 ; perimeter
G1 Z6.410 X96.021 Y94.936 E0.00300 ; perimeter
G1 Z6.410 X96.021 Y94.630 E0.01011 ; perimeter
G1 Z6.417 X96.021 Y87.157 E0.25294 ; perimeter
G1 Z6.417 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z6.417 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z6.421 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z6.421 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z6.421 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z6.440 X119.271 Y84.289 E0.68147 ; perimeter
G1 Z6.440 X119.271 Y84.186 E0.00300 ; perimeter
G1 Z6.441 X119.271 Y83.880 E0.01011 ; perimeter
G1 Z6.441 X119.271 Y83.639 E0.00816 ; perimeter
G1 Z6.441 X119.373 Y83.639 E0.00300 ; perimeter
G1 Z6.441 X119.680 Y83.639 E0.01011 ; perimeter
G1 Z6.459 X138.621 Y83.639 E0.64113 ; perimeter
G1 Z6.459 X138.621 Y83.741 E0.00300 ; perimeter
G1 Z6.460 X138.621 Y84.048 E0.01011 ; perimeter
G1 Z6.460 X138.621 Y84.289 E0.00816 ; perimeter
G1 Z6.460 X138.723 Y84.289 E0.00300 ; perimeter
G1 Z6.460 X139.030 Y84.289 E0.01011 ; perimeter
G1 Z6.479 X159.003 Y84.289 E0.67605 ; perimeter
G1 Z6.479 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z6.479 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z6.483 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z6.483 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z6.483 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z6.490 X161.871 Y95.039 E0.25836 ; perimeter
G1 Z6.490 X161.973 Y95.039 E0.00300 ; perimeter
G1 Z6.491 X162.280 Y95.039 E0.01011 ; perimeter
G1 Z6.491 X162.521 Y95.039 E0.00816 ; perimeter
G1 Z6.491 X162.521 Y95.141 E0.00300 ; perimeter
G1 Z6.491 X162.521 Y95.448 E0.01011 ; perimeter
G1 Z6.509 X162.521 Y114.389 E0.64113 ; perimeter
G1 Z6.509 X162.419 Y114.389 E0.00300 ; perimeter
G1 Z6.510 X162.112 Y114.389 E0.01011 ; perimeter
G1 Z6.510 X161.871 Y114.389 E0.00815 ; perimeter
G1 Z6.510 X161.871 Y114.491 E0.00300 ; perimeter
G1 Z6.510 X161.871 Y114.798 E0.01011 ; perimeter
G1 Z6.517 X161.871 Y122.270 E0.25294 ; perimeter
G1 Z6.517 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z6.517 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z6.521 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z6.521 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z6.521 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z6.540 X138.621 Y125.139 E0.68147 ; perimeter
G1 Z6.540 X138.621 Y125.241 E0.00300 ; perimeter
G1 Z6.541 X138.621 Y125.548 E0.01011 ; perimeter
G1 Z6.541 X138.621 Y125.789 E0.00816 ; perimeter
G1 Z6.541 X138.519 Y125.789 E0.00300 ; perimeter
G1 Z6.541 X138.212 Y125.789 E0.01011 ; perimeter
G1 Z6.559 X119.271 Y125.789 E0.64113 ; perimeter
G1 Z6.559 X119.271 Y125.686 E0.00300 ; perimeter
G1 Z6.560 X119.271 Y125.380 E0.01011 ; perimeter
G1 Z6.560 X119.271 Y125.139 E0.00816 ; perimeter
G1 Z6.560 X119.169 Y125.139 E0.00300 ; perimeter
G1 Z6.560 X118.862 Y125.139 E0.01011 ; perimeter
G1 Z6.579 X98.889 Y125.139 E0.67605 ; perimeter
G1 Z6.579 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z6.579 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z6.583 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z6.583 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z6.583 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z6.590 X96.021 Y114.389 E0.25836 ; perimeter
G1 Z6.590 X95.919 Y114.389 E0.00300 ; perimeter
G1 Z6.591 X95.612 Y114.389 E0.01011 ; perimeter
G1 Z6.591 X95.371 Y114.389 E0.00816 ; perimeter
G1 Z6.591 X95.371 Y114.286 E0.00300 ; perimeter
G1 Z6.591 X95.371 Y113.980 E0.01011 ; perimeter
G1 Z6.600 X95.371 Y104.714 E0.31364 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
6.8;6.8

M106 S20

G1 Z6.600 F12000.000 ; move to next layer (33)
;AFTER_LAYER_CHANGE
; starting layer 33, at 6.8mm
;6.8

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z6.609 X95.671 Y95.039 E0.32567 ; perimeter
G1 Z6.609 X95.773 Y95.039 E0.00300 ; perimeter
G1 Z6.610 X96.021 Y95.039 E0.00816 ; perimeter
G1 Z6.610 X96.021 Y94.936 E0.00300 ; perimeter
G1 Z6.610 X96.021 Y94.630 E0.01011 ; perimeter
G1 Z6.617 X96.021 Y87.157 E0.25294 ; perimeter
G1 Z6.617 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z6.617 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z6.621 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z6.621 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z6.621 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z6.640 X119.271 Y84.289 E0.68147 ; perimeter
G1 Z6.641 X119.271 Y84.186 E0.00300 ; perimeter
G1 Z6.641 X119.271 Y83.939 E0.00816 ; perimeter
G1 Z6.641 X119.373 Y83.939 E0.00300 ; perimeter
G1 Z6.641 X119.680 Y83.939 E0.01011 ; perimeter
G1 Z6.659 X138.621 Y83.939 E0.64113 ; perimeter
G1 Z6.659 X138.621 Y84.041 E0.00300 ; perimeter
G1 Z6.660 X138.621 Y84.289 E0.00816 ; perimeter
G1 Z6.660 X138.723 Y84.289 E0.00300 ; perimeter
G1 Z6.660 X139.030 Y84.289 E0.01011 ; perimeter
G1 Z6.679 X159.003 Y84.289 E0.67605 ; perimeter
G1 Z6.679 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z6.679 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z6.683 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z6.683 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z6.683 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z6.690 X161.871 Y95.039 E0.25836 ; perimeter
G1 Z6.691 X161.973 Y95.039 E0.00300 ; perimeter
G1 Z6.691 X162.221 Y95.039 E0.00816 ; perimeter
G1 Z6.691 X162.221 Y95.141 E0.00300 ; perimeter
G1 Z6.691 X162.221 Y95.448 E0.01011 ; perimeter
G1 Z6.709 X162.221 Y114.389 E0.64113 ; perimeter
G1 Z6.709 X162.119 Y114.389 E0.00300 ; perimeter
G1 Z6.710 X161.871 Y114.389 E0.00816 ; perimeter
G1 Z6.710 X161.871 Y114.491 E0.00300 ; perimeter
G1 Z6.710 X161.871 Y114.798 E0.01011 ; perimeter
G1 Z6.717 X161.871 Y122.270 E0.25294 ; perimeter
G1 Z6.717 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z6.717 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z6.721 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z6.721 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z6.721 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z6.740 X138.621 Y125.139 E0.68147 ; perimeter
G1 Z6.741 X138.621 Y125.241 E0.00300 ; perimeter
G1 Z6.741 X138.621 Y125.489 E0.00816 ; perimeter
G1 Z6.741 X138.519 Y125.489 E0.00300 ; perimeter
G1 Z6.741 X138.212 Y125.489 E0.01011 ; perimeter
G1 Z6.759 X119.271 Y125.489 E0.64113 ; perimeter
G1 Z6.759 X119.271 Y125.386 E0.00300 ; perimeter
G1 Z6.760 X119.271 Y125.139 E0.00816 ; perimeter
G1 Z6.760 X119.169 Y125.139 E0.00300 ; perimeter
G1 Z6.760 X118.862 Y125.139 E0.01011 ; perimeter
G1 Z6.779 X98.889 Y125.139 E0.67605 ; perimeter
G1 Z6.779 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z6.779 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z6.783 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z6.783 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z6.783 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z6.790 X96.021 Y114.389 E0.25836 ; perimeter
G1 Z6.791 X95.919 Y114.389 E0.00300 ; perimeter
G1 Z6.791 X95.671 Y114.389 E0.00816 ; perimeter
G1 Z6.791 X95.671 Y114.286 E0.00300 ; perimeter
G1 Z6.791 X95.671 Y113.980 E0.01011 ; perimeter
G1 Z6.800 X95.671 Y104.714 E0.31364 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
; starting change to layer 34, at 7mm
;7

M106 S20

G1 Z6.800 F12000.000 ; move to next layer (34)
;AFTER_LAYER_CHANGE
; starting layer 34, at 7mm
;7

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z6.809 X95.971 Y95.039 E0.32567 ; perimeter
G1 Z6.809 X96.021 Y94.936 E0.00300 ; perimeter
G1 Z6.810 X96.021 Y94.630 E0.01011 ; perimeter
G1 Z6.817 X96.021 Y87.157 E0.25294 ; perimeter
G1 Z6.817 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z6.817 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z6.821 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z6.821 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z6.821 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z6.841 X119.271 Y84.289 E0.68147 ; perimeter
M73 Q88 S2
M73 P88 R2
G1 Z6.841 X119.373 Y84.239 E0.00300 ; perimeter
G1 Z6.841 X119.680 Y84.239 E0.01011 ; perimeter
G1 Z6.859 X138.621 Y84.239 E0.64113 ; perimeter
G1 Z6.859 X138.723 Y84.289 E0.00300 ; perimeter
G1 Z6.860 X139.030 Y84.289 E0.01011 ; perimeter
G1 Z6.879 X159.003 Y84.289 E0.67605 ; perimeter
G1 Z6.879 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z6.879 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z6.883 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z6.883 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z6.883 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z6.891 X161.871 Y95.039 E0.25836 ; perimeter
G1 Z6.891 X161.921 Y95.141 E0.00300 ; perimeter
G1 Z6.891 X161.921 Y95.448 E0.01011 ; perimeter
G1 Z6.909 X161.921 Y114.389 E0.64113 ; perimeter
G1 Z6.909 X161.871 Y114.491 E0.00300 ; perimeter
G1 Z6.910 X161.871 Y114.798 E0.01011 ; perimeter
G1 Z6.917 X161.871 Y122.270 E0.25294 ; perimeter
G1 Z6.917 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z6.917 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z6.921 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z6.921 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z6.921 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z6.941 X138.621 Y125.139 E0.68147 ; perimeter
G1 Z6.941 X138.519 Y125.189 E0.00300 ; perimeter
G1 Z6.941 X138.212 Y125.189 E0.01011 ; perimeter
G1 Z6.959 X119.271 Y125.189 E0.64113 ; perimeter
G1 Z6.959 X119.169 Y125.139 E0.00300 ; perimeter
G1 Z6.960 X118.862 Y125.139 E0.01011 ; perimeter
G1 Z6.979 X98.889 Y125.139 E0.67605 ; perimeter
G1 Z6.979 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z6.979 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z6.983 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z6.983 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z6.983 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z6.991 X96.021 Y114.389 E0.25836 ; perimeter
G1 Z6.991 X95.971 Y114.286 E0.00300 ; perimeter
G1 Z6.991 X95.971 Y113.980 E0.01011 ; perimeter
G1 Z7.000 X95.971 Y104.714 E0.31364 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
7.2;7.2

M106 S20

G1 Z7.000 F12000.000 ; move to next layer (35)
;AFTER_LAYER_CHANGE
; starting layer 35, at 7.2mm
;7.2

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
G1 E0.00731 F2100.00000 ; unretract
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z7.017 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z7.017 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z7.017 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z7.021 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z7.021 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z7.021 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z7.079 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z7.079 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z7.079 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z7.083 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z7.083 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z7.083 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z7.117 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z7.117 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z7.117 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z7.121 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z7.121 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z7.121 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z7.179 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z7.179 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z7.179 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z7.183 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z7.183 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z7.183 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z7.200 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
7.4;7.4

M106 S20

G1 Z7.200 F12000.000 ; move to next layer (36)
;AFTER_LAYER_CHANGE
; starting layer 36, at 7.4mm
;7.4

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z7.217 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z7.217 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z7.217 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z7.221 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z7.221 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z7.221 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z7.279 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z7.279 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z7.279 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z7.283 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z7.283 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z7.283 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z7.317 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z7.317 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z7.317 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z7.321 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z7.321 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z7.321 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z7.379 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z7.379 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z7.379 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z7.383 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z7.383 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z7.383 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z7.400 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
7.6;7.6

M106 S20

G1 Z7.400 F12000.000 ; move to next layer (37)
;AFTER_LAYER_CHANGE
; starting layer 37, at 7.6mm
;7.6

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z7.417 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z7.417 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z7.417 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z7.421 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z7.421 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z7.421 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z7.479 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z7.479 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z7.479 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z7.483 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z7.483 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z7.483 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z7.517 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z7.517 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z7.517 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z7.521 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z7.521 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z7.521 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z7.579 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z7.579 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z7.579 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z7.583 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z7.583 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z7.583 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z7.600 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
7.8;7.8

M106 S20

G1 Z7.600 F12000.000 ; move to next layer (38)
;AFTER_LAYER_CHANGE
; starting layer 38, at 7.8mm
;7.8

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z7.617 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z7.617 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z7.617 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z7.621 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z7.621 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z7.621 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z7.679 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z7.679 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z7.679 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z7.683 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z7.683 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z7.683 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z7.717 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z7.717 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z7.717 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z7.721 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z7.721 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z7.721 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z7.779 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z7.779 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z7.779 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z7.783 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z7.783 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z7.783 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z7.800 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
; starting change to layer 39, at 8mm
;8

M106 S20

G1 Z7.800 F12000.000 ; move to next layer (39)
;AFTER_LAYER_CHANGE
; starting layer 39, at 8mm
;8

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z7.817 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z7.817 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z7.817 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z7.821 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z7.821 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z7.821 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z7.879 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z7.879 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z7.879 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z7.883 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z7.883 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z7.883 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z7.917 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z7.917 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z7.917 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z7.921 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z7.921 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z7.921 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z7.979 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z7.979 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z7.979 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z7.983 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z7.983 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z7.983 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z8.000 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
8.2;8.2

M106 S20

G1 Z8.000 F12000.000 ; move to next layer (40)
;AFTER_LAYER_CHANGE
; starting layer 40, at 8.2mm
;8.2

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z8.017 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z8.017 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z8.017 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z8.021 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z8.021 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z8.021 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z8.079 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z8.079 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z8.079 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z8.083 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z8.083 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z8.083 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z8.117 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z8.117 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z8.117 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z8.121 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z8.121 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z8.121 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z8.179 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z8.179 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z8.179 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z8.183 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z8.183 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z8.183 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z8.200 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
8.4;8.4

M106 S20

G1 Z8.200 F12000.000 ; move to next layer (41)
;AFTER_LAYER_CHANGE
; starting layer 41, at 8.4mm
;8.4

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z8.217 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z8.217 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z8.217 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z8.221 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z8.221 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z8.221 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z8.279 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z8.279 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z8.279 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z8.283 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z8.283 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z8.283 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z8.317 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z8.317 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z8.317 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z8.321 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z8.321 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z8.321 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z8.379 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z8.379 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z8.379 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z8.383 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z8.383 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z8.383 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z8.400 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
8.6;8.6

M106 S20

G1 Z8.400 F12000.000 ; move to next layer (42)
;AFTER_LAYER_CHANGE
; starting layer 42, at 8.6mm
;8.6

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z8.417 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z8.417 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z8.417 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z8.421 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z8.421 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z8.421 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z8.479 X159.003 Y84.289 E2.02635 ; perimeter
M73 Q94 S1
M73 P94 R1
G1 Z8.479 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z8.479 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z8.483 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z8.483 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z8.483 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z8.517 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z8.517 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z8.517 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z8.521 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z8.521 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z8.521 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z8.579 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z8.579 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z8.579 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z8.583 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z8.583 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z8.583 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z8.600 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
8.8;8.8

M106 S20

G1 Z8.600 F12000.000 ; move to next layer (43)
;AFTER_LAYER_CHANGE
; starting layer 43, at 8.8mm
;8.8

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z8.617 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z8.617 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z8.617 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z8.621 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z8.621 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z8.621 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z8.679 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z8.679 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z8.679 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z8.683 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z8.683 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z8.683 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z8.717 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z8.717 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z8.717 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z8.721 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z8.721 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z8.721 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z8.779 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z8.779 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z8.779 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z8.783 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z8.783 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z8.783 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z8.800 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
; starting change to layer 44, at 9mm
;9

M106 S20

G1 Z8.800 F12000.000 ; move to next layer (44)
;AFTER_LAYER_CHANGE
; starting layer 44, at 9mm
;9

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z8.817 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z8.817 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z8.817 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z8.821 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z8.821 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z8.821 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z8.879 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z8.879 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z8.879 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z8.883 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z8.883 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z8.883 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z8.917 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z8.917 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z8.917 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z8.921 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z8.921 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z8.921 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z8.979 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z8.979 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z8.979 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z8.983 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z8.983 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z8.983 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z9.000 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
9.2;9.2

M106 S20

G1 Z9.000 F12000.000 ; move to next layer (45)
;AFTER_LAYER_CHANGE
; starting layer 45, at 9.2mm
;9.2

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z9.017 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z9.017 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z9.017 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z9.021 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z9.021 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z9.021 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z9.079 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z9.079 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z9.079 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z9.083 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z9.083 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z9.083 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z9.117 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z9.117 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z9.117 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z9.121 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z9.121 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z9.121 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z9.179 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z9.179 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z9.179 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z9.183 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z9.183 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z9.183 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z9.200 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
9.4;9.4

M106 S20

G1 Z9.200 F12000.000 ; move to next layer (46)
;AFTER_LAYER_CHANGE
; starting layer 46, at 9.4mm
;9.4

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z9.217 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z9.217 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z9.217 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z9.221 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z9.221 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z9.221 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z9.279 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z9.279 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z9.279 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z9.283 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z9.283 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z9.283 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z9.317 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z9.317 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z9.317 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z9.321 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z9.321 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z9.321 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z9.379 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z9.379 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z9.379 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z9.383 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z9.383 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z9.383 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z9.400 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
9.6;9.6

M106 S20

G1 Z9.400 F12000.000 ; move to next layer (47)
;AFTER_LAYER_CHANGE
; starting layer 47, at 9.6mm
;9.6

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z9.417 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z9.417 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z9.417 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z9.421 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z9.421 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z9.421 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z9.479 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z9.479 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z9.479 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z9.483 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z9.483 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z9.483 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z9.517 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z9.517 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z9.517 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z9.521 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z9.521 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z9.521 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z9.579 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z9.579 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z9.579 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z9.583 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z9.583 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z9.583 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z9.600 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
9.8;9.8

M106 S20

G1 Z9.600 F12000.000 ; move to next layer (48)
;AFTER_LAYER_CHANGE
; starting layer 48, at 9.8mm
;9.8

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z9.617 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z9.617 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z9.617 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z9.621 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z9.621 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z9.621 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z9.679 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z9.679 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z9.679 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z9.683 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z9.683 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z9.683 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z9.717 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z9.717 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z9.717 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z9.721 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z9.721 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z9.721 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z9.779 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z9.779 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z9.779 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z9.783 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z9.783 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z9.783 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z9.800 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
;BEFORE_LAYER_CHANGE
G92 E0.0
; starting change to layer 49, at 10mm
;10

M106 S20

G1 Z9.800 F12000.000 ; move to next layer (49)
;AFTER_LAYER_CHANGE
; starting layer 49, at 10mm
;10

snap
; printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
M204 S800 ; adjust acceleration
G1 F1680.000
G1 Z9.817 X96.021 Y87.157 E0.59246 ; perimeter
G1 Z9.817 X96.065 Y87.113 E0.00202 ; perimeter
G1 Z9.817 X96.197 Y86.981 E0.00627 ; perimeter
G1 Z9.821 X98.889 Y84.289 E0.12887 ; perimeter
G1 Z9.821 X98.951 Y84.289 E0.00202 ; perimeter
G1 Z9.821 X99.138 Y84.289 E0.00627 ; perimeter
G1 Z9.879 X159.003 Y84.289 E2.02635 ; perimeter
G1 Z9.879 X159.047 Y84.333 E0.00202 ; perimeter
G1 Z9.879 X159.179 Y84.465 E0.00627 ; perimeter
G1 Z9.883 X161.871 Y87.157 E0.12887 ; perimeter
G1 Z9.883 X161.871 Y87.219 E0.00202 ; perimeter
G1 Z9.883 X161.871 Y87.406 E0.00627 ; perimeter
G1 Z9.917 X161.871 Y122.270 E1.18012 ; perimeter
G1 Z9.917 X161.827 Y122.314 E0.00202 ; perimeter
G1 Z9.917 X161.695 Y122.447 E0.00627 ; perimeter
G1 Z9.921 X159.003 Y125.139 E0.12887 ; perimeter
G1 Z9.921 X158.941 Y125.139 E0.00202 ; perimeter
G1 Z9.921 X158.754 Y125.139 E0.00627 ; perimeter
G1 Z9.979 X98.889 Y125.139 E2.02635 ; perimeter
G1 Z9.979 X98.845 Y125.095 E0.00202 ; perimeter
G1 Z9.979 X98.713 Y124.963 E0.00627 ; perimeter
G1 Z9.983 X96.021 Y122.270 E0.12887 ; perimeter
G1 Z9.983 X96.021 Y122.208 E0.00202 ; perimeter
G1 Z9.983 X96.021 Y122.021 E0.00627 ; perimeter
G1 Z10.000 X96.021 Y104.714 E0.58585 ; perimeter
M204 S1000 ; adjust acceleration
; stop printing object snap_lock_box_lid_65x40x35.stl id:0 copy 0
G1 F9600.000;_WIPE
G1 X96.021 Y102.885 E-0.38000 ; wipe and retract
G1 E-0.02000 F2100.00000 ; retract
G1 Z10.200 F12000.000 ; lift Z
M107 ; disable fan
; Filament-specific end gcode
; end of print
; Cribbed from http://projects.ttlexceeded.com/3dprinting_prusaslicer_gcode.html
; Last updated 20200215
G4 ; wait
M117 Printing complete
G4 ; wait
; Raise nozzle and present bed
G92 E0 ; prepare to retract
G1 E-0.8 F3000; retract to avoid stringing
; Anti-stringing end wiggle
G91 ; use relative coordinates
G0 X-0.5 Y-0.5 F1200
G0 X1 Y1 F1200
G90 ; use absolute coordinates
G0 Z70.2 ; Move print head up
G0 X0 Y210 F10200; present bed
; Reset print setting overrides
M200 D0 ; disable volumetric e
M220 S100 ; reset speed factor to 100%
M221 S100 ; reset extruder factor to 100%
M900 K0 ; reset linear acceleration
; Shut down printer
M104 S0 ; turn off temperature
M140 S0 ; turn off heatbed
M107 ; turn off fan
M84 ; disable motors
M300 S40 P10 ; chirp
M73 P100 R0
M73 Q100 S0
; filament used [mm] = 1052.3
; filament used [cm3] = 2.5
; filament used [g] = 3.2
; filament cost = 0.1

; total filament used [g] = 3.2
; total filament cost = 0.1
; estimated printing time (normal mode) = 17m 6s
; estimated printing time (silent mode) = 17m 7s

; allow_empty_layers = 0
; avoid_crossing_not_first_layer = 1
; avoid_crossing_perimeters = 0
; bed_custom_model = /Users/matt/Documents/CAD/_print_meta/_Prusa/Prusa_i3_MK3_PrusaSlicer.stl
; bed_custom_texture = /Users/matt/Documents/CAD/_print_meta/_Prusa/mk3.svg
; bed_shape = 0x0,250x0,250x210,0x210
; bed_temperature = 90
; before_layer_gcode = ;BEFORE_LAYER_CHANGE\nG92 E0.0\n; starting change to layer [layer_num], at [layer_z]mm\n;[layer_z]\n{if layer_z<0.6}\n{elsif layer_z<6}\nM106 S56\n{else}\nM106 S20\n{endif}
; between_objects_gcode = 
; bottom_fill_pattern = concentricgapfill
; bottom_solid_layers = 4
; bottom_solid_min_thickness = 0.5
; bridge_acceleration = 1000
; bridge_angle = 0
; bridge_fan_speed = 70
; bridge_flow_ratio = 88%
; bridge_overlap = 100%
; bridge_speed = 28
; bridged_infill_margin = 200%
; brim_ears = 1
; brim_ears_max_angle = 125
; brim_inside_holes = 0
; brim_offset = 0
; brim_width = 0
; brim_width_interior = 0
; chamber_temperature = 0
; clip_multipart_objects = 1
; compatible_printers_condition_cummulative = "printer_notes=~/.*PRINTER_VENDOR_PRUSA3D.*/ and printer_notes=~/.*PRINTER_MODEL_MK3.*/ and nozzle_diameter[0]==0.4";"nozzle_diameter[0]!=0.6 and printer_model!=\"MK2SMM\" and printer_model!=\"MINI\" and ! (printer_notes=~/.*PRINTER_VENDOR_PRUSA3D.*/ and printer_notes=~/.*PRINTER_MODEL_MK(2.5|3).*/ and single_extruder_multi_material)"
; complete_objects = 1
; complete_objects_one_skirt = 1
; complete_objects_sort = object
; cooling = 1
; cooling_tube_length = 5
; cooling_tube_retraction = 91.5
; curve_smoothing_angle_concave = 0
; curve_smoothing_angle_convex = 0
; curve_smoothing_cutoff_dist = 2
; curve_smoothing_precision = 0
; default_acceleration = 1000
; default_filament_profile = "Prusa PETG - MF"
; default_print_profile = 0.20mm SPEED @MK3 - MF
; deretract_speed = 0
; disable_fan_first_layers = 3
; dont_support_bridges = 1
; draft_shield = 0
; duplicate_distance = 4
; end_filament_gcode = "; Filament-specific end gcode"
; end_gcode = ; end of print\n; Cribbed from http://projects.ttlexceeded.com/3dprinting_prusaslicer_gcode.html\n; Last updated 20200215\nG4 ; wait\nM117 Printing complete\nG4 ; wait\n; Raise nozzle and present bed\nG92 E0 ; prepare to retract\nG1 E-0.8 F3000; retract to avoid stringing\n; Anti-stringing end wiggle\nG91 ; use relative coordinates\nG0 X-0.5 Y-0.5 F1200\nG0 X1 Y1 F1200\nG90 ; use absolute coordinates\n{if layer_z < max_print_height}G0 Z{z_offset+min(layer_z+60, max_print_height)}{endif} ; Move print head up\nG0 X0 Y210 F10200; present bed\n; Reset print setting overrides\nM200 D0 ; disable volumetric e\nM220 S100 ; reset speed factor to 100%\nM221 S100 ; reset extruder factor to 100%\nM900 K0 ; reset linear acceleration\n; Shut down printer\nM104 S0 ; turn off temperature\nM140 S0 ; turn off heatbed\nM107 ; turn off fan\nM84 ; disable motors\nM300 S40 P10 ; chirp
; enforce_full_fill_volume = 1
; ensure_vertical_shell_thickness = 0
; exact_last_layer_height = 0
; external_infill_margin = 150%
; external_perimeter_cut_corners = 100%
; external_perimeter_extrusion_width = 0.45
; external_perimeter_fan_speed = 8
; external_perimeter_overlap = 100%
; external_perimeter_speed = 28
; external_perimeters_first = 0
; external_perimeters_hole = 1
; external_perimeters_nothole = 1
; external_perimeters_vase = 0
; extra_loading_move = -2
; extra_perimeters = 0
; extra_perimeters_odd_layers = 0
; extra_perimeters_overhangs = 0
; extruder_clearance_height = 60
; extruder_clearance_radius = 20
; extruder_colour = ""
; extruder_offset = 0x0
; extrusion_axis = E
; extrusion_multiplier = 1
; extrusion_width = 0.5
; fan_always_on = 1
; fan_below_layer_time = 0
; fan_speedup_time = -1
; feature_gcode = 
; filament_colour = #FF8000
; filament_cooling_final_speed = 3.4
; filament_cooling_initial_speed = 2.2
; filament_cooling_moves = 4
; filament_cooling_zone_pause = 0
; filament_cost = 32
; filament_density = 1.27
; filament_diameter = 1.75
; filament_dip_extraction_speed = 70
; filament_dip_insertion_speed = 33
; filament_enable_toolchange_part_fan = 0
; filament_enable_toolchange_temp = 0
; filament_load_time = 0
; filament_loading_speed = 28
; filament_loading_speed_start = 3
; filament_max_volumetric_speed = 12
; filament_max_wipe_tower_speed = 0
; filament_melt_zone_pause = 0
; filament_minimal_purge_on_wipe_tower = 15
; filament_notes = ""
; filament_ramming_parameters = "120 100 6.6 6.8 7.2 7.6 7.9 8.2 8.7 9.4 9.9 10.0| 0.05 6.6 0.45 6.8 0.95 7.8 1.45 8.3 1.95 9.7 2.45 10 2.95 7.6 3.45 7.6 3.95 7.6 4.45 7.6 4.95 7.6"
; filament_retract_length = 0.4
; filament_retract_lift = 0.2
; filament_settings_id = "Prusa PETG VASE - MF"
; filament_skinnydip_distance = 31
; filament_soluble = 0
; filament_toolchange_delay = 0
; filament_toolchange_part_fan_speed = 50
; filament_toolchange_temp = 200
; filament_type = PETG
; filament_unload_time = 0
; filament_unloading_speed = 90
; filament_unloading_speed_start = 100
; filament_use_fast_skinnydip = 0
; filament_use_skinnydip = 0
; filament_vendor = Made for Prusa
; filament_wipe_advanced_pigment = 0.5
; fill_angle = 45
; fill_density = 0%
; fill_pattern = gyroid
; fill_smooth_distribution = 10%
; fill_smooth_width = 50%
; fill_top_flow_ratio = 100%
; first_layer_acceleration = 1000
; first_layer_bed_temperature = 105
; first_layer_extrusion_width = 0.5
; first_layer_flow_ratio = 100%
; first_layer_height = 0.2
; first_layer_infill_speed = 25
; first_layer_size_compensation = -0.2
; first_layer_speed = 20
; first_layer_temperature = 240
; gap_fill = 1
; gap_fill_min_area = 100%
; gap_fill_speed = 28
; gcode_comments = 1
; gcode_flavor = marlin
; gcode_label_objects = 1
; high_current_on_filament_swap = 0
; hole_size_compensation = 0
; hole_to_polyhole = 0
; host_type = octoprint
; infill_acceleration = 1250
; infill_dense = 0
; infill_dense_algo = automatic
; infill_every_layers = 1
; infill_extruder = 1
; infill_extrusion_width = 0.45
; infill_first = 0
; infill_not_connected = 0
; infill_only_where_needed = 0
; infill_overlap = 30%
; infill_speed = 28
; inherits_cummulative = "0.20mm SPEED @MK3";"Prusa PETG";"Original Prusa i3 MK3S"
; interface_shells = 0
; layer_gcode = ;AFTER_LAYER_CHANGE\n; starting layer [layer_num], at [layer_z]mm\n;[layer_z]\n\nsnap
; layer_height = 0.2
; machine_max_acceleration_e = 5000,5000
; machine_max_acceleration_extruding = 1250,1250
; machine_max_acceleration_retracting = 1250,1250
; machine_max_acceleration_x = 1000,960
; machine_max_acceleration_y = 1000,960
; machine_max_acceleration_z = 1000,1000
; machine_max_feedrate_e = 140,140
; machine_max_feedrate_x = 200,100
; machine_max_feedrate_y = 200,100
; machine_max_feedrate_z = 12,12
; machine_max_jerk_e = 4.5,4.5
; machine_max_jerk_x = 8,8
; machine_max_jerk_y = 8,8
; machine_max_jerk_z = 0.4,0.4
; machine_min_extruding_rate = 0,0
; machine_min_travel_rate = 0,0
; max_fan_speed = 22
; max_layer_height = 0.25
; max_print_height = 205
; max_print_speed = 200
; max_speed_reduction = 90%
; max_volumetric_speed = 0
; milling_after_z = 200%
; milling_extra_size = 150%
; milling_post_process = 0
; milling_speed = 30
; milling_toolchange_end_gcode = 
; milling_toolchange_start_gcode = 
; min_fan_speed = 8
; min_layer_height = 0.07
; min_print_speed = 15
; min_skirt_length = 4
; min_width_top_surface = 100%
; model_precision = 0.0001
; no_perimeter_unsupported_algo = bridgesoverhangs
; notes = 
; nozzle_diameter = 0.4
; only_one_perimeter_top = 1
; only_retract_when_crossing_perimeters = 1
; ooze_prevention = 0
; output_filename_format = {input_filename_base}_{layer_height}mm_{filament_type[0]}.gcode
; over_bridge_flow_ratio = 120%
; overhangs = 1
; overhangs_reverse = 1
; overhangs_reverse_threshold = 250%
; overhangs_width = 50%
; parking_pos_retraction = 92
; perimeter_acceleration = 800
; perimeter_bonding = 0%
; perimeter_extruder = 1
; perimeter_extrusion_width = 0.5
; perimeter_loop = 0
; perimeter_loop_seam = hidden
; perimeter_overlap = 100%
; perimeter_speed = 28
; perimeters = 1
; post_process = /Users/matt/Documents/CAD/_print_meta/scripts/_otherpeople/Slic3r-Post-Processor-Template/post-processor_perimeter_speed_below_3mm.pl
; print_extrusion_multiplier = 100%
; print_machine_envelope = 1
; print_settings_id = 0.20mm clearVASE @MK3 - MF
; printer_model = MK3S
; printer_notes = Don't remove the following keywords! These keywords are used in the "compatible printer" condition of the print and filament profiles to link the particular print and filament profiles to this printer profile.\nPRINTER_VENDOR_PRUSA3D\nPRINTER_MODEL_MK3\n
; printer_settings_id = Original Prusa i3 MK3S VASE - MF
; printer_technology = FFF
; printer_variant = 0.4
; printer_vendor = 
; raft_layers = 0
; remaining_times = 1
; resolution = 0.02
; retract_before_travel = 1
; retract_before_wipe = 0%
; retract_layer_change = 0
; retract_length = 0.8
; retract_length_toolchange = 4
; retract_lift = 0.6
; retract_lift_above = 0
; retract_lift_below = 204
; retract_lift_not_last_layer = 0
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_speed = 35
; seam_position = near
; seam_travel = 1
; serial_port = 
; serial_speed = 250000
; silent_mode = 1
; single_extruder_multi_material = 0
; single_extruder_multi_material_priming = 0
; skirt_distance = 2
; skirt_height = 1
; skirts = 0
; slice_closing_radius = 0.049
; slowdown_below_layer_time = 0
; small_perimeter_speed = 25
; solid_fill_pattern = rectilineargapfill
; solid_infill_below_area = 0
; solid_infill_every_layers = 0
; solid_infill_extruder = 1
; solid_infill_extrusion_width = 0.7
; solid_infill_speed = 28
; spiral_vase = 1
; standby_temperature_delta = -5
; start_filament_gcode = "M900 K{if nozzle_diameter[0]>=0.6}0.05{else}0.12{endif} ; Filament gcode LA 1.5\n{if printer_notes=~/.*PRINTER_MODEL_MINI.*/};{elsif printer_notes=~/.*PRINTER_HAS_BOWDEN.*/}M900 K200{elsif nozzle_diameter[0]>=0.6}M900 K24{else}M900 K45{endif} ; Filament gcode LA 1.0"
; start_gcode = ; Cribbed from http://projects.ttlexceeded.com/3dprinting_prusaslicer_gcode.html\n; Last updated 20200215\nM300 S40 P10 ; chirp\nM862.3 P "[printer_model]" ; printer model check\n{if nozzle_diameter[0] == 0.25 or nozzle_diameter[0] == 0.4 or nozzle_diameter[0] == 0.6}M862.1 P[nozzle_diameter] ; nozzle diameter check{endif}\nM115 U3.9.0 ; tell printer latest fw version\nM117 Initializing\n; Set coordinate modes\nG90 ; use absolute coordinates\nM83 ; extruder relative mode\n; Reset speed and extrusion rates\nM200 D0 ; disable volumetric e\nM220 S100 ; reset speed\nM221 S{if layer_height<0.075}100{elsif layer_height>=0.32}90{else}95{endif} ; compensate for extreme layer heights\n; Set initial warmup temps\nM117 Nozzle preheat\nM104 S{min(160,(first_layer_temperature[0]-50))} ; set extruder no-ooze temp\nM140 S{min(first_layer_bed_temperature[0],80)}  ; set bed PINDA warmup temp\n; Nozzle warmup before home to avoid driving hardened ooze into PEI surface\nM109 S{min(160,first_layer_temperature[0]-50)} ; wait for extruder no-ooze warmup temp before mesh bed leveling, cool hot PINDA\nM300 S40 P10 ; chirp\n; Home\nM117 Homing\nG28 W ; home all without mesh bed level\n; Present bed for final cleaning\nG0 Z3; Raise nozzle before move\nG0 X125 Y180 F10200; Move nozzle to PINDA warming position\nG0 Z0.15 F10200; Lower nozzle to PINDA warming position\n; Wait for PINDA warmup\nM117 PINDA warmup\nM860 S35 ; wait for PINDA temp to stabilize\nM140 S[first_layer_bed_temperature] ; set target bed temp\nG0 Z3; Raise nozzle before move\nM300 S40 P10 ; chirp\n; Mesh bed leveling\nM117 Mesh bed leveling\nG80 N7 ; mesh bed leveling\nM117 Saving results\nG81 ; save mesh leveling results\n; Final warmup routine\nM117 Final warmup\nG0 Z5; Raise nozzle to avoid denting bed while nozzle heats\nM140 S[first_layer_bed_temperature] ; set bed final temp\nM104 S[first_layer_temperature] ; set extruder final temp\nM109 S[first_layer_temperature] ; wait for extruder final temp\nM190 S[first_layer_bed_temperature] ; wait for bed final temp\nM300 S40 P10 ; chirp\n; Prime line routine\nM117 Printing prime line\nG0 Z0.15 ; Restore nozzle position - (thanks tim.m30)\nM900 K0; Disable Linear Advance for prime line\nG92 E0.0 ; reset extrusion distance\nG1 Y-3.0 F1000.0 ; go outside print area\nG1 E2 F1000 ; de-retract and push ooze\nG1 X20.0 E{3.1416*nozzle_diameter[0]*nozzle_diameter[0]/4*8+6} F{3.1416*nozzle_diameter[0]*nozzle_diameter[0]/4*3918+508} ; fat 20mm intro line @ 0.30\nG1 X60.0 E{3.1416*nozzle_diameter[0]*nozzle_diameter[0]/4*8+2.2} F{3.1416*nozzle_diameter[0]*nozzle_diameter[0]/4*3918+508} ; thin +40mm intro line @ 0.08\nG1 X100.0 E{3.1416*nozzle_diameter[0]*nozzle_diameter[0]/4*8+7} F{3.1416*nozzle_diameter[0]*nozzle_diameter[0]/4*3918+508} ; fat +40mm intro line @ 0.15\nG1 E-0.8 F3000; retract to avoid stringing\nG1 X99.5 E0 F1000.0 ; -0.5mm wipe action to avoid string\nG1 X110.0 E0 F1000.0 ; +10mm intro line @ 0.00\nG1 E0.6 F1500; de-retract\nG92 E0.0 ; reset extrusion distance\n; Final print adjustments\nM117 Preparing to print\nM300 S40 P10 ; chirp\nM117 Print in progress\n; start of print
; support_material = 0
; support_material_angle = 0
; support_material_auto = 0
; support_material_buildplate_only = 0
; support_material_contact_distance_bottom = 0.1
; support_material_contact_distance_top = 0.1
; support_material_contact_distance_type = filament
; support_material_enforce_layers = 0
; support_material_extruder = 0
; support_material_extrusion_width = 0.35
; support_material_interface_contact_loops = 0
; support_material_interface_extruder = 0
; support_material_interface_layers = 2
; support_material_interface_pattern = rectilinear
; support_material_interface_spacing = 0.2
; support_material_interface_speed = 100%
; support_material_pattern = rectilinear
; support_material_solid_first_layer = 0
; support_material_spacing = 2
; support_material_speed = 50
; support_material_synchronize_layers = 0
; support_material_threshold = 50
; support_material_with_sheath = 0
; support_material_xy_spacing = 50%
; temperature = 240
; thin_perimeters = 0
; thin_walls = 1
; thin_walls_merge = 1
; thin_walls_min_width = 50%
; thin_walls_overlap = 50%
; thin_walls_speed = 28
; threads = 16
; thumbnails = 
; time_estimation_compensation = 100%
; toolchange_gcode = 
; top_fan_speed = 0
; top_fill_pattern = concentricgapfill
; top_infill_extrusion_width = 0.4
; top_solid_infill_speed = 28
; top_solid_layers = 0
; top_solid_min_thickness = 0.6
; travel_speed = 200
; use_firmware_retraction = 0
; use_relative_e_distances = 1
; use_volumetric_e = 0
; variable_layer_height = 1
; wipe = 1
; wipe_advanced = 0
; wipe_advanced_algo = linear
; wipe_advanced_multiplier = 60
; wipe_advanced_nozzle_melted_volume = 120
; wipe_extra_perimeter = 0
; wipe_into_infill = 0
; wipe_into_objects = 0
; wipe_tower = 0
; wipe_tower_bridging = 10
; wipe_tower_brim = 150%
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_width = 60
; wipe_tower_x = 170
; wipe_tower_y = 125
; wiping_volumes_extruders = 70,70
; wiping_volumes_matrix = 0
; xy_inner_size_compensation = 0
; xy_size_compensation = 0
; z_offset = 0
; z_step = 0.005
