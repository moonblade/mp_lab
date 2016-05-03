.model small
.stack
.data
	a1 db 0000
	a2 db 0000
	b1 db 0000
	b2 db 0000
	res1 db 0000
	res2 db 0000
	carry db 0000
	msg1 db 13,10,"Enter first number : $"
	msg2 db 13,10,"Enter second number : $"
	msgres db 13,10,"Result: $"
.code

	print macro msg
		push ax
		push dx
		lea dx,msg
		mov ah,09h
		int 21h
		pop dx
		pop ax
	endm 

	readno proc 
		mov ah,01h
		int 21h
		sub al,'0'
		mov cl,04h
		shl al,cl
		mov bh,al
		mov ah,01h
		int 21h
		sub al,'0'
		mov bl,al
		add bl,bh
		ret
	readno endp

	printno proc
		ret
	endp printno


	printres proc
		ret
	endp printres

	main proc
		mov ax,@data
		mov ds,ax

		print msg1
		; call readno
		; mov bh,bl
		; call readno
		; push bx

		; print msg2
		; call readno
		; mov bh,bl
		; call readno

		; pop cx
		; add cx,bx
		; adc ah,00h
		; mov carry,ah

		; call printres
		mov ax,4c00h
		int 21h

	endp main
end