;
; Task 4.asm
;
; Created: 2016-09-19 09:07:02
; Author : henry
;


; Replace with your application code

ldi r25, high(5000)	
ldi	r24, low(5000)	; 5s

movw r25:r24, r27:r26


loop:
	deley
	sbiw r27:r26, 1
	brne loop		; while not 0 
	
	movw r25:r24, r27:r26	; copy back values


	inc r19
	out ddrb, r19
	rjmp loop


deley:				; 4MHz -> 4000000 cycles = 1s,  Cycles = 3a + 4ab + 3abc   ->  a(3 + b(4 + 3c)) = (3*82 + 4) = (250)*16 + 3 * 1
	ldi r16, 1		; -> a
deley_1:
	ldi r17, 16		; -> b
deley_2:
	ldi r18, 82		; -> c  (a,b,c ~> 0.5s)

deley_3:
	dec r18
	brne deley_3	; 3c - 1		-> d = 3c - 1

	dec r17
	nop
	brne deley_2	; 5b - 1 + bd	-> e = 5b - 1 + 3cb - b

	dec r16
	brne deley_1	; 5a - 1 + ae	-> f = 3a + 5ab + 3abc - ab
	ret				; f - 1
