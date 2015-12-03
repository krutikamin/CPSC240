; Krutik Amin
; 11/17/2015
; This programme follows sieve of Eratosthenes to 
; find prime numbers upto MAX

INCLUDE Irvine32.inc

.data
	MAX			EQU		100
	array		BYTE	MAX		DUP(?)
	comma		BYTE	", ", 0
	myString	BYTE	"Prime numbers found -", 0dh, 0ah, 0
	seperator	BYTE	"---------------------------------------------", 0dh, 0ah, 0

.code
main proc
	mov		ecx, MAX

	call	GenerateArrayProc
;CONTINUE_LOOP:
;	mov		array[ecx - 1], cl
;	cmp		ecx, 0
;	je		STOP_LOOP
;	loop	CONTINUE_LOOP

;STOP_LOOP:
;	xor		edi, edi
;	mov		array[edi], 0

NEXT_ITERATION:
	inc		edi
	movzx	eax, array[edi]
	mul		eax
	cmp		eax, MAX
	ja		END_ITERATIONS
	cmp		array[edi], 0
	jz		NEXT_ITERATION

	mov		eax, 2
KEEP_CROSSING:
	mov		ebx, eax
	mul		array[edi]
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
	loop	NEXT_ITERATION

END_ITERATIONS:
	mov		esi, 0
	xor		ebx, ebx
	mov		edx, OFFSET myString
	call	WriteString
	mov		edx, OFFSET seperator
	call	WriteString

FINAL_LOOP:
	cmp		array[esi], 0
	jz		NEXT
	mov		al, array[esi]
	call	WriteDec
	inc		ebx
	cmp		ebx, 5
	jle		SKIP_NEWLINE
	call	Crlf
	xor		ebx, ebx
SKIP_NEWLINE:
	mov		edx, OFFSET comma
	call	WriteString
NEXT:
	inc		esi
	cmp		esi, MAX
	jae		EXIT_LOOP
	loop	FINAL_LOOP
EXIT_LOOP:
	call	WaitMsg

	exit
main endp
;end main


GenerateArrayProc PROC
	CONTINUE_LOOP:
	mov		array[ecx - 1], cl
	cmp		ecx, 0
	je		STOP_LOOP
	loop	CONTINUE_LOOP
	STOP_LOOP:
	xor		edi, edi
	mov		array[edi], 0
	ret
GenerateArrayProc ENDP

end main