.model small
.stack
.data
	ent1 db 10,13,"Enter First String : $"
	ent2 db 10,13,"Enter Second String : $"
	entr db 13,10,"$"
	str1 db 100,0,100 dup("$")
	str2 db 100,0,100 dup("$")
	yesString db 10,13,"Substring$"
	noString db 10,13,"Not Substring$"
.code

print macro msg
lea dx,msg
mov ah,09h
int 21h
endm

read macro msg
lea dx,msg
mov ah,0ah
int 21h
endm

main proc
	mov ax, @data
	mov ds, ax
	mov es, ax

	print ent1
	read str1

	print ent2
	read str2
	
	mov cl,str1+1
	cmp cl,str2+1
	jl notSubstring
	mov bx,0
incbx:
	lea si,str1[bx]+2
	mov cl,str1+1
	sub cl,bl
	cmp cl,str2+1
	jl notSubstring
	lea di,str2+2
	mov cl,str2+1
	mov ch,00
	rep cmpsb
	jnz next
	print yesString
	jmp skip
next:
	inc bx;
	jmp incbx
notSubstring:
	print noString
skip:
	mov ax, 4c00h
	int 21h
main endp
end main