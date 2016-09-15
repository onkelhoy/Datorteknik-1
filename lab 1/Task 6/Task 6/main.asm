;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 1DT301, Computer Technology I
; Date: 2016-09-05
; Author: Henry Pap
; Student Henry Pap
; Student Ramus Skedinge
;
; Lab number: 1
; Title: How to use the PORTs. Digital input/output. Subroutine call.
;
; Hardware: STK600, CPU ATmega2560
;
; Function: adds and subtracts 
;
; Output ports: on-board LEDs connected to PORTB.
;
; Subroutines: If applicable.
; Included files: m2560def.inc
;
; Other information: Johnson Counter in an infinite loop
;
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

.include "m2560def.inc"

ldi r16, high(ramend)
out sph, r16
ldi r20, low(ramend)
out spl, r16

ldi r19, 0x00
ldi r20, 0x01


_add:
	rcall deley
	out DDRB, r19
	add r19, r20
	lsl r20
	
	cpi r19, 0xff
	brne _add

_sub:
	rcall deley
	out DDRB, r19
	lsr r19

	cpi r19, 0x00
	brne _sub
	ldi r20, 0x01
	rjmp _add






deley:			; 4MHz -> 4000000 cycles = 1s,  Cycles = 3a + 4ab + 3abc   ->  a(3 + b(4 + 3c))
	ldi r16, 11	; -> a
deley_1:
	ldi r17, 237	; -> b
deley_2:
	ldi r18, 255	; -> c

deley_3:
	dec r18
	brne deley_3	; 3c - 1		-> d = 3c - 1

	dec r17
	nop
	brne deley_2	; 5b - 1 + bd	-> e = 5b - 1 + 3cb - b

	dec r16
	brne deley_1	; 5a - 1 + ae	-> f = 3a + 5ab + 3abc - ab
	ret				; f - 1
