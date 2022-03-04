	section .text
	global sum

sum:
	; Push ebp into the stack
	push 	ebp
	; Move esp -> ebp, so ebp point to the pushed ebp
	mov 	ebp, esp
	
	; Push some preserved regiesters
	push 	ebx
	push 	esi
	push	edi
	
	; Edit pointer value
	mov	ecx, [ebp+16]		; Get number size from stack
	mov 	eax, [ebp+12]		; Get val2 address from stack
	mov	ebx, [ebp+8]		; Get val1 address from stack
	
	; Move the pointers to the last byte
	add	eax, ecx
	dec	eax
	add	ebx, ecx
	dec	ebx
	
	; Make space in the stack for pushing ecx and for the carrys	
	sub 	esi, 12

	; Set carrys to 0
	mov	dword [ebp-20], 0
	mov	dword [ebp-24], 0

	loop:
		; Push ecx into the stack
		push	ecx		

		; Clear ecx and edx
		xor	ecx, ecx
		xor 	edx, edx
		
		; Add bytes
		mov	dl, byte [ebx]
		mov	cl, byte [eax]
		add	edx, ecx	
	
		; Store result
		mov	byte [ebx], dl	
		; Set tmp_carry
		mov	byte [ebp-20], dh	; Move the new carry in tmp_carry				
			
		; Clear ecx and edx
		xor	ecx, ecx
		xor	edx, edx

		; Add byte with carry
		mov	dl, byte [ebx]
		mov	cl, byte [ebp-24]
		add	edx, ecx
	
		; Store result	
		mov	byte [ebx], dl
		
		; Set carry
		mov	cl, byte [ebp-20]
		add	cl, dh
		mov	byte [ebp-24], cl 
			
		; Pop ecx from the stack
		pop	ecx
		
		dec	ecx		; Sub 1 from ecx
		dec	eax		; Dec address of val 2
		dec	ebx		; Dec address of val 1
		
		cmp	ecx, 0
		jne	loop
	
	skip:
	add	esi, 12			; Delete space of tmp_carry and carry
	
	; Pop the preserved registers
	pop 	edi
	pop 	esi
	pop	ebx
	
	; Restore esp
	mov 	esp, ebp
	; Pop ebp
	pop 	ebp

	ret





