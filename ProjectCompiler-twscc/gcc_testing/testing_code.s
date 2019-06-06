    .globl  main         ## -- Begin function main
main:                    ## @main
    mov     $6, %rax
    push    %rax
    mov     $9, %rax
    pop      %rcx
    add      %rcx, %rax
    push     %rax
    mov     $1, %rax
    push    %rax
    mov     $555, %rax
    pop      %rcx
    add      %rcx, %rax
    pop      %rcx
    add      %rcx, %rax
    ret

