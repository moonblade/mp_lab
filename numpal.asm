.model small
.stack
.data
	entr db 13,10,"$"
	ent db 13,10, "Enter Number : $"
	numbin db 13,10, "Number In Binary is : $"
	revis db 13,10, "Reverse Is : $"
	yesString db 13,10, "Number is Palindrome $"
	noString db 13,10, "Number is not Palindrome $"
	num db ?
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

read4 macro
	local nothex
	mov ah,01h
	int 21h
	sub al,30h
	cmp al,09
	jle nothex
	sub al,07
nothex:
endm
read8 macro num
	push ax
	push bx
	read4
	mov bl,al
	shl bl,04
	read4
	add bl,al
	mov num,bl
	pop bx
	pop ax
endm

hextobin macro num,string
	local repeat,pushing,nothexi
	push ax
	push bx
	push cx
	push dx
	mov al,num
	mov bl,2
	xor cx,cx
repeat:
	xor ah,ah
	div bl
	mov dl,ah
	xor dh,dh
	push dx
	inc cx
	cmp al,0
	jnz repeat
	lea si,string+2
	xor bx,bx
	mov [si-1],cl
pushing:
	pop ax
	add al,30h
	cmp al,39h
	jle nothexi
	add al,07
nothexi:
	mov [si+bx],al
	inc bx
	loop pushing
	pop dx
	pop cx
	pop bx
	pop ax
endm
start:
	mov ax,@data
	mov ds,ax
	mov es,ax

	
	print ent
	read8 num
	hextobin num,string
	print numbin
	print string+2
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