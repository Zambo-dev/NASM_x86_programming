; This function is based on big-endian numbers, so it start computing using the first byte
; from the right

	section .text
	global sum

sum:
	; Push ebp into the stack
	push 	ebp
	; Move esp -> ebp, so ebp point to the pushed ebp
	mov 	ebp, esp
	
	; Push some preserved regiesters into the stack
	push 	ebx
	push 	esi
	push	edi
	
	; Store function parameters into registers
	mov	ecx, [ebp+16]		; Get number size from stack
	mov 	eax, [ebp+12]		; Get val2 address from stack
	mov	ebx, [ebp+8]		; Get val1 address from stack
	
	; Move the pointers to the last byte
	add	eax, ecx
	dec	eax
	add	ebx, ecx
	dec	ebx
	
	; Make space in the stack for ecx and for the two carry variables
	sub 	esi, 12

	; Set carry variables to 0
	mov	dword [ebp-20], 0	; ebp-20 is the tmp_carry, the carry for the next byte
	mov	dword [ebp-24], 0	; ebp-24 si the carry for the actual byte

	loop:
		; Push ecx into the stack
		push	ecx		

		; Clear ecx and edx
		xor	ecx, ecx
		xor 	edx, edx
		
		; Store the least byte from memory into the least byte into registers
		mov	dl, byte [ebx]
		mov	cl, byte [eax]
		add	edx, ecx	
	
		; Store the least byte as a result
		mov	byte [ebx], dl	
		; Store the second-least byte as tmp_carry
		mov	byte [ebp-20], dh				
			
		; Clear ecx and edx
		xor	ecx, ecx
		xor	edx, edx

		; Store the least byte from memory into the least byte into registers
		mov	dl, byte [ebx]
		mov	cl, byte [ebp-24]
		add	edx, ecx
	
		; Store the least byte as a result
		mov	byte [ebx], dl
		
		; Store the second least byte into cl
		mov	cl, byte [ebp-20]
		; Add the carry in dh into cl
		add	cl, dh
		; Store the carry for the next byte
		mov	byte [ebp-24], cl 
			
		; Pop ecx from the stack
		pop	ecx
		
		; Decrement the size
		dec	ecx		; Sub 1 from ecx
		; Point to the next byte
		dec	eax		; Dec address of val 2
		dec	ebx		; Dec address of val 1
		
		; Check if the sum is at the end
		cmp	ecx, 0
		jne	loop
	
	
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





