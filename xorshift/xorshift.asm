
	section	.text
	global	xorshift

xorshift:
	; Setup stack pointer
	push	ebp
	mov 	ebp, esp
	
	push	esi
	push	edi
	
	mov 	eax, dword[ebp+8]
	mov	cl, byte[ebp+20]
	shl	eax, cl
	mov	cl, byte[ebp+16]
	shr	eax, cl
	mov	cl, byte[ebp+12]
	shl	eax, cl

	pop	edi
	pop 	esi
	pop 	ebp	

	ret
	
