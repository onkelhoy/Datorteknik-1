;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 1DT301, Computer Technology I
; Date: 2016-09-05
; Author:
; Student Rasmus Skedinger
; Student Henry Pap
;
; Lab number: 1
; Title: When button 5 is pushed and lights led 0x01.
;
; Hardware: STK600, CPU ATmega2560
;
; Function: When button 5 is pushed and lights led 0x01. It scan's for the input
; signature of 0x20 and puts it out to led 0x01 and resets it when done.
;
; Input ports: Port D button input
;
; Output ports: Port B acts as led output.
;
; Subroutines: The check funktion scan's for input.
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

	cpi r16, 0x20
	breq check
	
	ldi r16, 0x00
	out DDRB, r16
rjmp loop

 check:
	ldi r16, 0x01

	out DDRB, r16
rjmp loop
