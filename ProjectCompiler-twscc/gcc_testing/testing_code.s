    .globl  main         ## -- Begin function main
main:                    ## @main
    mov     $2, %rax   
	#RAX = 2
	#RCX =
	#PILA = []

    push    %rax 
	#RAX = 2
	#RCX =
	#PILA = [2]

    mov     $3, %rax 
	#RAX = 3
	#RCX =
	#PILA = [2]

    pop     %rcx 
	#RAX = 3
	#RCX = 2
	#PILA = []

    imul    %rcx, %rax
	#RAX = 6
	#RCX = 2
	#PILA = []

    push    %rax
	#RAX = 6
	#RCX = 2
	#PILA = [6]

    mov     $10, %rax
	#RAX = 10
	#RCX = 2
	#PILA = [6]

    pop     %rcx
	#RAX = 10
	#RCX = 6
	#PILA = []

    add    %rcx, %rax 
	#RAX = 16
	#RCX = 6
	#PILA = []
    ret
	#REGRESA LO DE RAX

