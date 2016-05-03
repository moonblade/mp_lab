.model small
.stack
.data 
	list db 1,2,3,4,5,6,7,8
	sum dw ?
	fact dw ?
.code 
	
start:
	
	mov ax,4c00h
	int 21h
end start