;
; Task 3.asm
;
; Created: 2016-09-18 23:02:20
; Author : henry
;


; Replace with your application code
ldi r17, 0x00
rjmp start

switch:
	inc r17		; pushed
	loop:
		in r16, PINA
		cpi r16, 0x00	; sw0 (..and all the others) is realesed!
		brne loop
	inc r17		; realesed

	out DDRB, r17


start:
	in r16, PINA
	cpi r16, 0x01		; sw0 is pushed
	breq switch


    rjmp start
