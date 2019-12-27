; PRINT_COLOR_CHANGE
; M600
; INSERT MAGNETS
G1 X10.000 Y200.000 E0; parking position
M17;                    turn on steppers (lock bed)
M104 S0;                set temp to 0
M300 S2500 P1000;       beep
M1 PAUSED;              user stop and write message
M109 S210;              set and wait for temp  SET CORRECT TEMP
G28 X Y;                re-home X and Y axes



; ... this is supposed to work, but as at 2019-12-25 is reported to be buggy
; INSERT MAGNETS
M300; play beep sound
M601; pause print
M602; resume print
