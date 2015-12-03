; Krutik Amin
; 11/17/2015
; This programme follows sieve of Eratosthenes to 
; find prime numbers upto MAX

INCLUDE Irvine32.inc

.data
	MAX			EQU		100
	array		BYTE	MAX		DUP(?)
	mDisplayArray	MACRO	
						mov		esi, OFFSET array
						mov		ecx, LENGTHOF array
						mov		ebx, TYPE array
						call	DumpMem
					ENDM
.code
main proc
	mov		ecx, MAX

CONTINUE_LOOP:
	mov		array[ecx - 1], cl
	cmp		ecx, 0
	je		STOP_LOOP
	loop	CONTINUE_LOOP

STOP_LOOP:
	xor		edi, edi
	mov		array[edi], 0

NEXT_ITERATION:
	inc		edi
	movzx	eax, array[edi]
	mul		eax
	cmp		eax, MAX
	ja		END_ITERATIONS
	cmp		array[edi], 0
	jz		NEXT_ITERATION

	push	eax
	mov		eax, 2
KEEP_CROSSING:
	mov		ebx, eax
	mul		array[edi]
	;mov		edx, eax
	cmp		eax, MAX
	ja		OUT_OF_LOOP
	cmp		array[eax - 1], 0
	jz		MOVE_ON
	mov		array[eax - 1], 0
MOVE_ON:
	mov		eax, ebx
	inc		eax
	loop	KEEP_CROSSING
OUT_OF_LOOP:
	pop		eax
	
	loop	NEXT_ITERATION

END_ITERATIONS:
	;mDisplayArray

	mov		esi, 0

FINAL_LOOP:
	movzx	eax, array[esi]
	cmp		eax, 0
	jz		NEXT
	call	WriteDec
NEXT:
	inc		esi
	cmp		esi, MAX
	jae		EXIT_LOOP
	loop	FINAL_LOOP
EXIT_LOOP:
	call	WaitMsg

	exit
main endp
end main