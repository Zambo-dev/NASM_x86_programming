
; ################################
;				BSS
; ################################
section .bss
	; Big number struct (size, number pointer)
	struc big_number
		size:		resb 32
		num:		resb 32
	endstruc


; ################################
;				TEXT
; ################################
section .text
global bn_init

bn_init:
	; Get program break point
	mov		eax, 45			; sys_brk
	mov		ebx, 0			; mov size into rdi
	int		80h

	mov		dword[bn+num], eax
	mov		ebx, dword[esp+8]
	mov		dword[bn+size], ebx

	; Set new system break point
	mov		ebx, eax			; move old break into ebx
	add		ebx, dword[esp+8]	; add needed size from function params
	mov		eax, 45				; sys_brk
	int		80h

	mov		eax, dword[esp+4]
	xor		ebx, ebx

	mov		ecx, dword[esp+8]		; Counter
	push	esi
	xor		esi, esi				; SUm

	loop:
		mov		byte bl, byte [eax]

		call 	char_to_num
		
		push	eax			; Push eax
		dec		ecx			; eax -= 1

		call	ten_pow		

		mul		ebx			; eax *= ebx
		add		esi, eax	; edx += eax

		pop 	eax			; Pop eax

		xor		ebx, ebx	; ebx = 0
		inc 	eax			; Increment pointer value

		cmp		ecx, 0
		jg		loop

	; Store data in bn.num
	mov		ebx, dword[bn+num]
	mov		dword[ebx], esi

 	pop 	esi

	ret

; TO DO: bn_add


; Parameters: ecx = exponential 
; Return: edx, eax
ten_pow:
	mov		eax, 1

	cmp		ecx, 0
	je 		end

	; Calculate pow 
	push	ebx			; Push ecx
	push	ecx			; Push edx

	mov		ebx, 10
	pow:
		mul		ebx		; eax *= edx
		dec		ecx
		
		cmp 	ecx, 0
		jg		pow

	pop		ecx			; Pop edx
	pop		ebx			; Pop ecx

	end:

	ret

; Parameters: bl(ebx) = char
; Return: bl(ebx)
char_to_num:
	push	ecx
	push	edx

	; Number check 97 <= ebx <= 122
	mov		ecx, 97			; Bottom value
	mov		edx, 122		; Top value
	cmp		ebx, ecx
	jge		check_top

	; Number check 65 <= ebx <= 90
	mov		ecx, 65			; Bottom value
	mov		edx, 90			; Top value
	cmp		ebx, ecx
	jge		check_top

	; Number check 48 <= ebx <= 57
	mov		ecx, 48			; Bottom value
	mov		edx, 57			; Top value
	cmp		ebx, ecx
	jge		check_top

	check_top:
		cmp		ebx, edx
		jle		conv

		mov		ecx, ebx
		inc		ecx

	conv:
		sub		ebx, ecx

	pop	edx
	pop	ecx

	ret


; ################################
;				DATA
; ################################
section .data
	bn:
		istruc big_number
			at size,	db 0
			at num,		db 0
		iend