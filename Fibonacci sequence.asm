ASSUME cs:code, ds:data
data segment
s db 4,?,4 dup (?)
numar dw ?
newline db 10,13,'$'
zecew dw 10
primul_numar dw ?
al_doilea_numar dw ?
aux dw ?
suma dw 0
nr dw ?


data ends

code segment

afisare_numar proc
mov cx, 0
repetastiva:
	mov dx,0
	div zecew
	push dx
	inc cx
	cmp ax,0
	JNE repetastiva
	
repetaafisare:
	pop dx
	add dl,'0'
	mov ah, 02h
	int 21h
loop repetaafisare
ret
afisare_numar endp

start:
mov ax, data
mov ds, ax

mov ah,0ah
mov dx, offset s
int 21h

mov cl, byte ptr s[1]
mov ch,0
mov si,2
mov ax,0
repeta:
	mul zecew
	mov bl,byte ptr s[si]
	sub bl,'0'
	mov bh,0
	inc si
	add ax,bx
loop repeta

mov numar, ax
mov ax,0
	call afisare_numar
	mov dl,','
	mov ah,02h
	int 21h

mov cx, numar
sub cx,1
sub numar,1
cmp cx,0
	JE myendif
	JNE maideparte

maideparte:
mov ax,1
call afisare_numar
mov dl,','
mov ah,02h
int 21h

mov cx,numar
sub cx,1
mov aux, cx
mov primul_numar,0
mov al_doilea_numar,1
cmp cx,0
	JNE merge
	JE myendif
merge:
repetaa:	
	mov suma,0
	mov bx, primul_numar
	add suma, bx
	mov bx, al_doilea_numar
	add suma, bx
	mov ax, suma
	call afisare_numar
	mov dl,','
	mov ah, 02h
	int 21h
	mov cx,aux
	sub aux,1
	mov primul_numar, bx
	mov bx,suma
	mov al_doilea_numar, bx
loop repetaa

myendif:


mov ax, 4C00h
int 21h
code ends
end start