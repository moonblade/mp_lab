.model small
.stack
.data
till db ?
now db 2
last db 1
.code
read macro 
	mov ah,01h
	int 21h
	sub al,30h
	mov till,al
endm
print macro msg
	local noadd,hextodec,printing
	push ax
	push dx
	push bx
	mov bl,10
	mov bh,0
	mov al,msg
hextodec:
	xor ah,ah
	div bl
	mov cl,ah
	xor ch,ch
	push cx
	inc bh
	cmp al,0
	jg hextodec
	mov cl,bh
	xor ch,ch
printing:
	pop dx
	add dl,30h
	mov ah,02h
	int 21h
	loop printing
	mov dl,' '
	int 21h
	pop bx
	pop dx
	pop ax
endm
main proc
	mov ax,@data
	mov ds,ax

	read
	print last
	print now
next:
	mov al,till
	cmp now,al
	jge done
	mov al,now
	mov bl,al
	add al,last
	mov now,al
	mov last,bl
	print now
	jmp next
done:
	mov ax,4c00h
	int 21h
main endp
end main