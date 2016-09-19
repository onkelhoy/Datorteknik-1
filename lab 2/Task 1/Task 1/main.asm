;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 1DT301, Computer Technology I
; Date: 2016-09-05
; Author: Henry Pap
; Student Henry Pap
; Student Ramus Skedinge
;
; Lab number: 2
; Title: How to use the PORTs. Digital input/output. Subroutine call.
;
; Hardware: STK600, CPU ATmega2560
;
; Function: ring counter, johnson counter and deley that checks for input value
;
; Output ports: PORTB
; Input port: PORTA
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


ldi r21, 0x00 ; switch value
ldi r20, 0x01
ldi r19, 0x00

rjmp _add

switch:
	in r16, PIND	; 1 cycle
	cpi r16, 0xff	; 1 cycle
	brne switch		; 1 cycle if not

	pop r16			; 2ycles
	
	com r21
	brne ring_counter

	ldi r20, 0x01
	ldi r19, 0x00



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





deley:				; 4MHz -> 4000000 cycles = 1s,  Cycles = 3a + 4ab + 10abc   ->  a(3 + b(4 + 10c)),  ((250 * 10 + 4) * 100 + 3) * 8 = 2 003 224 ~ 2 000 000
	ldi r16, 8		; -> a
deley_1:
	ldi r17, 100	; -> b
deley_2:
	ldi r18, 250	; -> c

deley_3:
	push r16		; 2cycles	 check if input
	in r16, PIND	; 1 cycle
	cpi r16, 0xff	; 1 cycle
	brne switch		; 1 cycle if not
	pop r16			; 2ycles

	dec r18
	brne deley_3	; 10c - 1		-> d

	dec r17
	nop
	brne deley_2	; 5b - 1 + bd	-> e = 5b - 1 + 10cb - b

	dec r16
	brne deley_1	; 5a - 1 + ae	-> f = 3a + 5ab + 10abc - ab
	ret				; f - 1


ring_counter:
	ldi r20, 0x01
	loop:
		out DDRB, r20
		rcall deley
		lsl r20
		cpi r20, 0x00
		breq ring_counter
	rjmp loop
