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
{if layer_z < max_print_height}G0 Z{z_offset+min(layer_z+60, max_print_height)}{endif} ; Move print head up
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
