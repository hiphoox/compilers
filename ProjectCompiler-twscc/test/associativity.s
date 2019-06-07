.p2align        4, 0x90
    .globl  main         ## -- Begin function main
main:                    ## @main
    mov     $1, %rax
    push    %rax
    mov     $2, %rax
    push    %rax
    pop     %rcx
    sub     %rcx, %rax
    mov     $3, %rax
    push    %rax
    pop     %rcx
    sub     %rcx, %rax
    ret
