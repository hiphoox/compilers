.p2align        4, 0x90
    .globl  main         ## -- Begin function main
main:                    ## @main
    mov     $2, %rax
    push    %rax
    mov     $1, %rax
    neg     %rax
    pop     %rcx
    sub     %rax, %rcx
    mov     %rcx, %rax
    ret
