.model small
.data
		matrix1 db 01h,02h,03h,04h,05h,06h,07h,08h,09h
		matrix2 db 04h,05h,06h,07h,08h,09h,01h,02h,03h
		result db 09h dup(0)
		row db 03h
		column db 03h
		offst db 00
		isprime db 00
		tocheck db ?
.stack
.code
		main proc
		mov ax, @data
		mov ds, ax
		lea si, matrix1
		xor bx,bx
		mov bl,00h ;i
		outer:
				xor cx,cx
				mov ch,00 ;j
				inner:
						mov al,bl
						mul column
						add al,ch
						mov offst,al
						push bx
						xor bx,bx
						mov bl,al	   
						mov dl,[si+bx]
						pop bx
						mov tocheck,dl
						call prime
						mov dh,isprime
						cmp dh,00
						je noprint
						add dl,30h
						mov ah,02h
						int 21h
						noprint:
								inc ch
						call space
						cmp ch,column
						jl inner
				inc bl
				call entr
				cmp bl,row
				jl outer
		call entr
		call entr
		lea di, matrix2
		xor bx,bx
		mov bl,00h ;i
		outer2:
				xor cx,cx
				mov ch,00 ;j
				inner2:
						mov al,bl
						mul column
						add al,ch
						mov offst,al
						push bx
						xor bx,bx
						mov bl,al	   
						mov dl,[di+bx]
						pop bx
						add dl,30h
						mov ah,02h
						int 21h
								inc ch
						call space
						cmp ch,column
						jl inner2
				inc bl
				call entr
				cmp bl,row
				jl outer2

		call entr
		call entr
		lea di, matrix2
		lea si, matrix1
		xor bx,bx
		mov bl,00h ;i
		outer3:
				xor cx,cx
				mov ch,00 ;j
				inner3:
						cmp ch,bl
						jne dontprint
						mov al,bl
						mul column
						add al,ch
						mov offst,al
						push bx
						xor bx,bx
						mov bl,al	   
						mov dl,[di+bx]
						add dl,[si+bx]
						pop bx
						add dl,30h
						cmp dl,39h
						jle skip
						add dl,07
						skip:
						mov ah,02h
						int 21h
						dontprint:
								inc ch
						call space
						cmp ch,column
						jl inner3
				inc bl
				call entr
				cmp bl,row
				jl outer3

		mov ax,4c00h
		int 21h
		main endp

		print proc
		push ax
		push dx
		mov dl,al
		add dl,30h
		mov ah,02
		int 21h
		pop dx
		pop ax
		ret
		print endp

		space proc
		push ax
		push dx
		mov dl,' '
		mov ah,02
		int 21h
		pop dx
		pop ax
		ret
		space endp

		entr proc
		push ax
		push dx
		mov dl,13
		mov ah,02h
		int 21h
		mov dl,10
		int 21h
		pop dx
		pop ax
		ret
		entr endp

		prime proc
		push ax
		push bx
		push cx
		push dx
		mov ah,00
		mov isprime,ah
		mov al,tocheck
		mov cl,02h
		cmp al,01
		jz is_not_prime
		check_prime:
			mov al,tocheck
			cmp cl,al
			jz is_prime
			xor ah,ah
			div cl

			cmp ah,00
			jz is_not_prime
			inc cl
			jmp check_prime
		is_prime:
			mov al,01
			mov isprime,al
			jmp nextpart
		is_not_prime:
			mov al,00
			mov isprime,al
		nextpart:
		pop dx
		pop cx
		pop bx
		pop ax
		ret
		prime endp
end main