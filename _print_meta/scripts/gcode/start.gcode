M862.3 P "[printer_model]" ; printer model check
{if nozzle_diameter[0] == 0.25 or nozzle_diameter[0] == 0.4 or nozzle_diameter[0] == 0.6}M862.1 P[nozzle_diameter] ; nozzle diameter check{endif}
M115 U3.8.1 ; tell printer latest fw version
G90 ; use absolute coordinates
M83 ; extruder relative mode
M104 S[first_layer_temperature] ; set extruder temp
M140 S[first_layer_bed_temperature] ; set bed temp
M190 S[first_layer_bed_temperature] ; wait for bed temp
M109 S[first_layer_temperature] ; wait for extruder temp
G28 W ; home all without mesh bed level
G80 ; mesh bed leveling
G1 Y-3.0 F1000.0 ; go outside print area
G92 E0.0
G1 X60.0 E9.0 F1000.0 ; intro line
G1 X100.0 E12.5 F1000.0 ; intro line
G92 E0.0
M221 S{if layer_height<0.075}100{else}95{endif}
; start of print
