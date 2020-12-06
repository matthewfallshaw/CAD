; Cribbed from http://projects.ttlexceeded.com/3dprinting_prusaslicer_gcode.html
; Last updated 20200215
M300 S40 P10 ; chirp
M862.3 P "[printer_model]" ; printer model check
{if nozzle_diameter[0] == 0.25 or nozzle_diameter[0] == 0.4 or nozzle_diameter[0] == 0.6}M862.1 P[nozzle_diameter] ; nozzle diameter check{endif}
M115 U3.9.0 ; tell printer latest fw version
M117 Initializing
; Set coordinate modes
G90 ; use absolute coordinates
M83 ; extruder relative mode
; Reset speed and extrusion rates
M200 D0 ; disable volumetric e
M220 S100 ; reset speed
M221 S{if layer_height<0.075}100{elsif layer_height>=0.32}90{else}95{endif} ; compensate for extreme layer heights
; Set initial warmup temps
M117 Nozzle preheat
M104 S{min(160,(first_layer_temperature[0]-50))} ; set extruder no-ooze temp
M140 S{min(first_layer_bed_temperature[0],80)}  ; set bed PINDA warmup temp
; Nozzle warmup before home to avoid driving hardened ooze into PEI surface
M109 S{min(160,first_layer_temperature[0]-50)} ; wait for extruder no-ooze warmup temp before mesh bed leveling, cool hot PINDA
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
M140 S[first_layer_bed_temperature] ; set target bed temp
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
M140 S[first_layer_bed_temperature] ; set bed final temp
M104 S[first_layer_temperature] ; set extruder final temp
M109 S[first_layer_temperature] ; wait for extruder final temp
M190 S[first_layer_bed_temperature] ; wait for bed final temp
M300 S40 P10 ; chirp
; Prime line routine
M117 Printing prime line
G0 Z0.15 ; Restore nozzle position - (thanks tim.m30)
M900 K0; Disable Linear Advance for prime line
G92 E0.0 ; reset extrusion distance
G1 Y-3.0 F1000.0 ; go outside print area
G1 E2 F1000 ; de-retract and push ooze
G1 X20.0 E{3.1416*nozzle_diameter[0]*nozzle_diameter[0]/4*8+6} F{3.1416*nozzle_diameter[0]*nozzle_diameter[0]/4*3918+508} ; fat 20mm intro line @ 0.30
G1 X60.0 E{3.1416*nozzle_diameter[0]*nozzle_diameter[0]/4*8+2.2} F{3.1416*nozzle_diameter[0]*nozzle_diameter[0]/4*3918+508} ; thin +40mm intro line @ 0.08
G1 X100.0 E{3.1416*nozzle_diameter[0]*nozzle_diameter[0]/4*8+7} F{3.1416*nozzle_diameter[0]*nozzle_diameter[0]/4*3918+508} ; fat +40mm intro line @ 0.15
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
