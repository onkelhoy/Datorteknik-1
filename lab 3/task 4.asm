;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 1DT301, Computer Technology I
; Date: 2016-09-05
; Author: Henry Pap, Rasmus Skedinger
; Student Henry Pap
; Student Ramus Skedinger
;
; Lab number: 3
; Title: Interrupts - car turn with break
;
; Hardware: STK600, CPU ATmega2560
;
; Function: mimics car lights when turning and also breaks. When interrupt is clicked a turn/break will be displayed and when realesed it will go back to normal.
;
; Output ports: PORTB
; Input port: PORTA
;
; Subroutines: If applicable.
; Included files: m2560def.inc
;
; Other information: interrupt address: 1, 2 and 3 (1: right, 2: break, 3: left).
;
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


.include "m2560def.inc"



.org 0x00
rjmp start

.org INT1addr
jmp interrupt0
.org INT2addr
jmp interrupt1
.org INT3addr
jmp interrupt2

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

ldi r16, 0b00001110		; int0 and int1 and (purhaps also int2) enabled
out EIMSK, r16

ldi r16, 0b01010100
sts EICRA, r16		; int1 falling edge, int0 rising edge

sei					; global interupt enable

ldi r23, 0x00	; left register
ldi r19, 0x00	; right register

ldi r20, 0x00
ldi r21, 0x00
ldi r22, 0x00

init:
	pop r17	; this value will changed
	sei


normal:
	ldi r17, 0b11000011


	cpi r21, 0xff
	breq breaklight
	ab:
	

	cpi r20, 0xff
	breq right
	ar:

	cpi r22, 0xff
	breq left
	al:
	
	out ddrb, r17

	rcall deley

	rjmp normal

left:	
	andi r17, 0b00001111 ; 'flush' led 5-8
	cpi r23, 0x00
	brne leftshift
	ldi r23, 0b00010000
	rjmp leftadd

	leftshift:
		lsl r23

	leftadd:
		add r17, r23
		
	rjmp al

right:	
	andi r17, 0b11110000 ; 'flush' led 0-4
	cpi r19, 0x00
	brne rightshift
	ldi r19, 0b00001000
	rjmp rightadd

	rightshift:
		lsr r19

	rightadd:
		add r17, r19

	rjmp ar
	

breaklight:
	ldi r17, 0xff
	rjmp ab
	


deley:				; 4MHz -> 4000000 cycles = 1s,  Cycles = 3a + 4ab + 10abc   ->  a(3 + b(4 + 10c)),  ((250 * 10 + 4) * 100 + 3) * 8 = 2 003 224 ~ 2 000 000
	ldi r16, 8		; -> a
deley_1:
	ldi r17, 100	; -> b
deley_2:
	ldi r18, 250	; -> c

deley_3:

	dec r18
	brne deley_3	; 10c - 1		-> d ( not 10 anymore... 3)

	dec r17
	nop
	brne deley_2	; 5b - 1 + bd	-> e = 5b - 1 + 10cb - b

	dec r16
	brne deley_1	; 5a - 1 + ae	-> f = 3a + 5ab + 10abc - ab
	ret				; f - 1







interrupt0:		; right
	com r20
	rjmp init
interrupt1:		; break
	com r21
	rjmp init
interrupt2:		; left
	com r22
	rjmp init
