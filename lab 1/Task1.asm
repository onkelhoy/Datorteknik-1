;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 1DT301, Computer Technology I
; Date: 2016-09-05
; Author:
; Student Rasmus Skedinger
; Student Henry Pap
;
; Lab number: 1
; Title: Task 1
;
; Hardware: STK600, CPU ATmega2560
;
; Function: Turning on led 2
;
; Output ports: B
;
; Subroutines: none
; Included files: m2560def.inc
;
; Other information: none
;
; Changes in program: (done: 2016-09-06 13:49)
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

.include "m2560def.inc"

 ldi r16, 0b00000100
 out DDRB, r16