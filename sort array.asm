; Krutik Amin
; 10/27/2015
; This programme sorts the array into lower to higher numbers

INCLUDE Irvine32.inc

.data
;	array		BYTE	20, 10, 60, 5, 120, 90, 100
	array		BYTE	20h, 10h, 60h, 5h, 12h, 90h, 10h, 23h, 34h, 2h, 1h, 44h
	tempArray	BYTE	?
	lowest		BYTE	?

setupESI		TEXTEQU	<mov esi, OFFSET array>
setupECX		TEXTEQU	<mov ecx, LENGTHOF array>
setupEBX		TEXTEQU <mov ebx, TYPE array>
setupRegisters	MACRO
					setupESI
					setupECX
					setupEBX
				ENDM	

displayArray	MACRO
					setupRegisters
					call DumpMem
				ENDM

.code
main proc
	
	displayArray
	mov		esi, 0
	mov		edi, 1
	mov		ecx, LENGTHOF array				;outerloop counter
	inc		ecx

OUTER_LOOP:
	push	ecx
	xor		eax, eax
	mov		ah, array[esi]					; AH = 20
	mov		lowest, ah						; lowest = 20
	setupECX								; for inner loop
	sub		ecx, esi					
	dec		ecx

INNER_LOOP:
	mov		al, array[edi]					; al = 10
	cmp		al, lowest
	jb		ADJUST_VALUES
	jae		CONTINUE_INNER_LOOP

ADJUST_VALUES:
	mov		lowest, al						; lowest = 10
	xchg	array[esi], al
	mov		array[edi], al

CONTINUE_INNER_LOOP:
	inc		edi								; edi = 2
	loop	INNER_LOOP

	pop		ecx
	push	edx
	mov		dl, lowest
	mov		tempArray[esi], dl
;	pop		edx
	inc		esi
	
;	push	esi
;	push	ecx
;	push	ebx
;	displayArray
;	pop		ebx
;	pop		ecx
;	pop		esi
	mov		edx, LENGTHOF array
	xor		edi, edi
	add		edi, esi
	inc		edi
	cmp		edi, edx
	je		STOP							;CONTINUE_OUTER_LOOP
	pop		edx
	loop	OUTER_LOOP
	;cmp		edi, 
	;jnz		CONTINUE_OUTER_LOOP

STOP:
	pop		edx
	xor		ecx, ecx

;CONTINUE_OUTER_LOOP:
;	loop	OUTER_LOOP

	displayArray
	;mov		esi, OFFSET tempArray
	;mov		ecx, LENGTHOF tempArray
	;mov		ebx, TYPE tempArray
	;call	DumpMem
	call	WaitMsg

	exit
main endp
end main

	;mov	esi, OFFSET array
    ;mov	ecx, LENGTHOF array
	;mov	ebx, TYPE array

	;call    DumpMem                 ; display array