;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 1DT301, Computer Technology I
; Date: 2016-09-05
; Author:
; Student Rasmus Skedinger
; Student Henry Pap
;
; Lab number: 1
; Title: Task 2.
;
; Hardware: STK600, CPU ATmega2560
;
; Function: takes an input botton and turns corresponding light on
; Input ports: input : port D takes input with buttons
;
; Output ports: Port B shows the input in corresponding lights
;
; Subroutines: none
; Included files: m2560def.inc
;
; Other information: none
;
; Changes in program: (Description and date)
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

.include "m2560def.inc"

 ldi r16, 0x00

 loop:

 in r16, PIND
 com r16
 out DDRB, r16

 rjmp loop