; Krutik Amin
; 10/27/2015
; This programme sorts the array into lower to higher numbers
; CONDITION - The array has to have more than one elements for the programme to work

INCLUDE Irvine32.inc

.data
	array		BYTE	20, 10, 60, 5, 120, 90, 100
	lowest		BYTE	?

.code
main proc
	mov		esi, 0					;set ESI to the first element in array to be used for outer(sorted) array
	mov		edi, 1					;set EDI to the second element in array to be used for inner(unsorted) array
	mov		ecx, LENGTHOF array		;set ECX equal to the length of the array as an outerloop counter
	mov		ebx, ecx				;set EBX equal to the number of elements of array

OUTER_LOOP:
	push	ecx						;save outer loop counter to stack
	mov		ah, array[esi]			;assign AH to the ESI-th element of array and
	mov		lowest, ah				;save that as a variable lowest to compare later
	mov		ecx, LENGTHOF array		;}	start setting up ECX for inner loop
	sub		ecx, esi				;>	subtract elements already sorted and
	dec		ecx						;}	decrement again to equal the number of comparisons

INNER_LOOP:
	mov		al, array[edi]			;assign AL to the next element of unsorted portion of array
	cmp		al, lowest				;compare AL to the lowest value
	jb		ADJUST_VALUES			;if al < lowest value, jump to ADJUST_VALUE
	jae		CONTINUE_INNER_LOOP		;else jump directly to CONTINUE_INNER_LOOP

ADJUST_VALUES:
	mov		lowest, al				;set lowest to the value of AL
	xchg	array[esi], al			;exchange the value of AL to ESI-th element of array and
	mov		array[edi], al			;move value of al to the sorted part of array

CONTINUE_INNER_LOOP:
	inc		edi						;increment EDI to point to the next element of array
	loop	INNER_LOOP				;if ECX > 0, continue the inner loop

;end of INNER_LOOP

	pop		ecx						;else pop the outer loop's counter from stack
	inc		esi						;increment ESI to point to the first element of an unsorted array
	xor		edi, edi				;zero out the inner counter
	add		edi, esi				;point EDI to the start of an unsorted array
	inc		edi						;point EDI to the next element of the array to be sorted
	cmp		edi, ebx				;compare EDI with EBX (length of array) and
	je		STOP					;if EDI = EBX, jump to STOP, else
	loop	OUTER_LOOP				;continue outer loop

STOP:
	xor		ecx, ecx				;zero out the outer loop counter to prevent any more loop, just in case

;end of OUTER_LOOP

	mov		esi, OFFSET array		;}	setup ESI, ECX and EBX
	mov		ecx, LENGTHOF array		;>	registers to display the
	mov		ebx, TYPE array			;}	array contents

	call	DumpMem                 ;display memory dump
	call	WaitMsg					;display wait message

	exit
main endp
end main

	