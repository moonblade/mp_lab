.model small
data segment
	msg db "hi$"
data ends
my_stack segment stack "stack"
	; Data goes here ...
my_stack ends
.code
	assume ds: data, ss: my_stack

	; Code goes here...
	main proc far
		mov ax, data
		mov ds, ax
		mov ax, my_stack
		mov ss, ax
	
		; Code goes here...
		lea dx,msg
		mov ah,09
		int 21h
		mov ax, 4c00h
		int 21h
	main endp
end main