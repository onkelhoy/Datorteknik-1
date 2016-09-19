;
; Task 2.asm
;
; Created: 2016-09-18 22:45:01
; Author : henry
;


; Replace with your application code
init:
	ldi r16, 0		; random output value
	rjmp start


loop:
	in r17, PINA
	cpi r17, 0xff
	brne loop

start:
	inc r16
	cpi r16, 7
	breq init
	
	in r17, PINA
	cpi r17, 0xff
	brne output
	rjmp start		; start over


output:
	cpi r16, 1
	breq dis_1

	cpi r16, 2
	breq dis_2

	cpi r16, 3
	breq dis_3

	cpi r16, 4
	breq dis_4

	cpi r16, 5
	breq dis_5

	cpi r16, 6
	breq dis_6

	ldi r16, 0x00
	out DDRB, r16
	rjmp loop

dis_1:
	ldi r16, 0b00010000
	out DDRB, r16
	rjmp loop
dis_2:
	ldi r16, 0b01000100
	out DDRB, r16
	rjmp loop
dis_3:
	ldi r16, 0b01010100
	out DDRB, r16
	rjmp loop
dis_4:
	ldi r16, 0b11000110
	out DDRB, r16
	rjmp loop
dis_5:
	ldi r16, 0b11010110
	out DDRB, r16
	rjmp loop
dis_6:
	ldi r16, 0b11101110
	out DDRB, r16
	rjmp loop