TITLE Program Multiple_Byte_Key_Encryption			(Multiple_Byte_Key_Encryption.asm)

; Program:     Multiple_Byte_Key_Encryption.asm
; Description: This program creates ciphere text from the given string
; Student:     Krutik Amin
; Date:        03/26/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

.data
	BUFMAX = 125

	prompt1    BYTE	"Enter the plain text	 : ",0
	prompt2    BYTE	"Enter the encryption key : ",0
	sEncrypt   BYTE	"Cipher text		 : ",0
	sDecrypt   BYTE	"Decrypted		 : ",0

	keyStr		BYTE    BUFMAX + 1 DUP(0)
	keySize		DWORD   ?
	buffer		BYTE    BUFMAX + 1 DUP(0)
	bufSize		DWORD   ?

.code
main PROC
    mov		edx, OFFSET prompt1		; display buffer prompt
    call    WriteString
    mov		edx, OFFSET buffer		; point to the buffer
    call	InputTheString
    mov		bufSize, eax			; save the buffer length

    mov		edx, OFFSET prompt2		; display key prompt
    call	WriteString
    mov		edx, OFFSET keyStr		; point to the key
    call	InputTheString
    mov		keySize, eax			; save the key length

    call	TranslateBuffer			; encrypt

    mov		edx, OFFSET sEncrypt	; display sEncrypt
    call	WriteString
    mov		edx, OFFSET buffer		; display ciphred string
    call	WriteString

    call	TranslateBuffer			; decrypt
    call	crlf
    mov		edx, OFFSET sDecrypt    ; display sEncrypt string
    call	WriteString
    mov		edx, OFFSET buffer		; display deciphered string
    call	WriteString
    call	crlf
    ;call	WaitMsg					; display wait message
    ;This is a string.
main ENDP

;-------------------------------------------------------------------
InputTheString PROC
;-------------------------------------------------------------------

    mov		ecx, BUFMAX				; read maximum of BUFMAX character long string
    call    ReadString				; read the string from the user

    ret

InputTheString ENDP

;-------------------------------------------------------------------
TranslateBuffer PROC
;-------------------------------------------------------------------

    mov		ecx, bufSize		    ; loop until end of the string
    mov		esi, 0					; starting index 0 for buffer
    mov		edi, 0					; starting index 0 for keyString

L1:
    mov		al, keyStr[edi]			; store the first keyString letter in dl and
    xor		buffer[esi], al			; XOR with the buffer's first letter and store it in buffer
    inc		esi						; increment buffer's index
    inc		edi						; increment keyStr's index
    cmp		edi, keySize		    ; compare EDI & keySize
    jl		continue_loop		    ; jump if less than keyStr
    mov		edi, 0					; otherwise reset the keyString index
    continue_loop:
    loop	L1					    ; and continue loop

    ret

TranslateBuffer ENDP

END main