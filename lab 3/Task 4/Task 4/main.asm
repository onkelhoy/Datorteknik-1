;
; Task 2.asm
;
; Created: 2016-09-26 10:27:51
; Author : henry
;


.include "m2560def.inc"



.org 0x00
rjmp start

.org INT0addr
jmp right
.org INT1addr
jmp _break
.org INT2addr
jmp left

.org 0x72
start:
;initialize SP, stack pointer
ldi r20, high(ramend)
out sph, r20
ldi r20, low(ramend)
out spl, r20		

ldi r16, 0x00		
out ddrd, r16		; port a - output

ldi r16, 0xff		; set pull-up resistors on d input pin
out ddrb, r16		; port b - output

ldi r16, 0x07		; int0 and int1 and (purhaps also int2) enabled
out EIMSK, r16

ldi r16, 0x08
sts EICRA, r16		; int1 falling edge, int0 rising edge

sei					; global interupt enable


normal:
	ldi r17, 0xc3
	out ddrb, r17
	rjmp normal

right:
	ldi r16, 0x08
	loopr:
		mov r17, r16
		ldi r18, 0xc0
		add r17, r18 

		out ddrb, r17
		rcall deley

		lsr r16
		brne loopr
	rjmp normal

left:
	ldi r16, 0x10
	loopl:
		mov r17, r16
		ldi r18, 0x03
		add r17, r18 

		out ddrb, r17
		rcall deley

		lsl r16
		brne loopl
	rjmp normal
	
_break:
	ldi r18, 0x03
	add r18, r16
	cp r18, r17
	breq l

	ldi r18, 0xc0
	add r18, r16
	cp r18, r17
	breq r


r: 
	ldi r18, 0xc0
	add r17, r18
	out ddrb, r17

r: 
	ldi r18, 0xc0
	add r17, r18
	out ddrb, r17


deley:				; 4MHz -> 4000000 cycles = 1s,  Cycles = 3a + 4ab + 10abc   ->  a(3 + b(4 + 10c)),  ((250 * 10 + 4) * 100 + 3) * 8 = 2 003 224 ~ 2 000 000
	ldi r16, 8		; -> a
deley_1:
	ldi r17, 100	; -> b
deley_2:
	ldi r18, 250	; -> c

deley_3:

	nop
	nop
	nop
	nop
	nop
	nop
	nop

	dec r18
	brne deley_3	; 10c - 1		-> d

	dec r17
	nop
	brne deley_2	; 5b - 1 + bd	-> e = 5b - 1 + 10cb - b

	dec r16
	brne deley_1	; 5a - 1 + ae	-> f = 3a + 5ab + 10abc - ab
	ret				; f - 1
