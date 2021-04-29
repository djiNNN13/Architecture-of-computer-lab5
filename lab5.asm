IDEAL
MODEL SMALL
STACK 512
;-------------------------------II.МАКРОСИ-------------------------------------
                    ; Макрос для ініціалізації
MACRO M_Init    ; Початок макросу 
    mov     ax,@data ;ax<@data
    mov     ds,ax   ; ds<ax
    mov     es,ax   ; es<ax
ENDM M_Init      ; Кінець макросу

;----------------------III.ПОЧАТОК СЕГМЕНТУ ДАНИХ------------------------------
DATASEG

; Подвійний масив 16х16

array2Db db 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h
       db 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h
       db 38h, 38h, 32h, 34h, 30h, 37h, 32h, 30h, 30h, 33h, 38h, 38h, 38h, 38h, 38h, 38h
       db 38h, 38h, 32h, 35h , 30h, 34h, 32h, 30h, 30h, 33h, 38h, 38h, 38h, 38h, 38h, 38h
       db 38h, 38h, 30h, 32h , 30h, 32h, 32h, 30h, 30h, 33h, 38h, 38h, 38h, 38h, 38h, 38h
       db 38h, 38h, 32h, 34h, 30h, 37h, 32h, 30h, 30h, 33h, 38h, 38h, 38h, 38h, 38h, 38h
       db 38h, 38h, 32h, 35h , 30h, 34h, 32h, 30h, 30h, 33h, 38h, 38h, 38h, 38h, 38h, 38h
       db 38h, 38h, 30h, 32h , 30h, 32h, 30h, 30h, 33h, 38h, 38h, 38h, 38h, 38h, 38h, 38h
       db 38h, 38h, 32h, 34h, 30h, 37h, 32h, 30h, 30h, 33h, 38h, 38h, 38h, 38h, 38h, 38h
       db 38h, 38h, 32h, 35h , 30h, 34h, 32h, 30h, 30h, 33h, 38h, 38h, 38h, 38h, 38h, 38h
       db 38h, 38h, 38h, 38h , 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h
       db 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h
       db 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h
       db 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h
       db 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h
       db 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h, 38h
 
count equ 255 ; len(array2D)-1
;-----------------------VI. ПОЧАТОК СЕГМЕНТУ КОДУ-------------------------------
CODESEG




Start:
    M_Init 	;Виклик макросу ініціалізації

mov dx, count
    iloop:
        mov cx, count		;Запиуємо кількість кроків циклу
        lea si, array2Db	;Записумо ефективний адрес

        jloop:
            mov al, [si]                 ;Записуємо  al<=[si]
            cmp al, [si+1]		 ;Порівнюємо дані al та [si+1]: if(al==[si+1]) then zf=1 else zf=0
            jl skip                      ;Якщо al<[si+1], то переходимо на мітку skip(пропускаємо 2 рядки команд)
            xchg al, [si+1]		 ;Міняємо місцями al та [si+1]
            mov [si], al                 ;Записуємо [si]<=al

            skip:			 ;Мітка skip
                INC si			 ;si++
                loop jloop		 ;Викликаємо цикл jloop

        dec dx				 ;dx--
        jnz iloop			 ;Викликаємо виконання jloop (Перепригуємо на мітку)
    mov ah,4ch				 ;Завершуємо програму	
    int 21h 

end Start