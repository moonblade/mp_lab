.model small
.stack
.data
	entr db 13,10,"$"
	ent db 13,10, "enter string : $"
	revis db 13,10, "Reverse Is : $"
	yesString db 13,10, "String is Palindrome $"
	noString db 13,10, "String is not Palindrome $"
	string db 100,100 dup("$")
	rev db 100,100 dup("$")
.code
read macro msg
	push ax
	push dx
	mov ah,0ah
	lea dx,msg
	int 21h
	pop dx
	pop ax
endm

print macro msg
	push ax
	push dx
	mov ah,09h
	lea dx,msg
	int 21h
	pop dx
	pop ax
endm

start:
	mov ax,@data
	mov ds,ax
	mov es,ax

	print ent
	read string
	print entr

	mov cl,string+1
	xor ch,ch
	lea si,string+1 	;before start
	add si,cx		;at end
	lea di,rev+2
till:
	mov al,[si]
	mov [di],al
	inc di
	dec si
	loop till
	print revis
	print rev+2
	print entr

	lea si,string+2
	lea di,rev+2
	mov cl,string+1
	xor ch,ch
	rep cmpsb
	jnz notEqual
equal:
	print yesString
	jmp over
notEqual:
	print noString
over:	

	mov ax,4c00h
	int 21h
end start