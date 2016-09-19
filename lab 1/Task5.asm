;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 1DT301, Computer Technology I
; Date: 2016-09-05
; Author: Henry Pap
; Student Rasmus Skedinger
; Student Henry Pap
;
; Lab number: 1
; Title: Johnson counter
;
; Hardware: STK600, CPU ATmega2560
;
; Function: this program emulates a johnsson counter a light that shifts one step
; to the left utill it is all the way and then restarts.
;
; Input ports: none
;
; Output ports: PORTB as leds .
;
; Subroutines: a delay function to keep the processor busy for a time frame that a 
; human can nitice what happens  
; Included files: m2560def.inc
;
; Other information: none
;
; Changes in program: (Description and date)
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

.include "m2560def.inc"

; Initialize SP, Stack Pointer
ldi r19, high(ramend)
out sph, r19
ldi r19, low(ramend)
out spl, r19

init:
	ldi r19, 0x01

loop:
	rcall deley
	out DDRB, r19
	
	lsl r19
	cpi r19, 0x00
	breq init
rjmp loop


deley:				; 4MHz -> 4000000 cycles = 1s,  Cycles = 3a + 4ab + 3abc   ->  a(3 + b(4 + 3c))
	ldi r16, 11		; -> a
deley_1:
	ldi r17, 237	; -> b
deley_2:
	ldi r18, 255	; -> c  (a,b,c ~> 0.5s)

deley_3:
	dec r18
	brne deley_3	; 3c - 1		-> d = 3c - 1

	dec r17
	nop
	brne deley_2	; 5b - 1 + bd	-> e = 5b - 1 + 3cb - b

	dec r16
	brne deley_1	; 5a - 1 + ae	-> f = 3a + 5ab + 3abc - ab
	ret				; f - 1