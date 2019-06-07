.p2align        4, 0x90
    .globl  main         ## -- Begin function main
main:                    ## @main
    mov     $1, %rax
    push    %rax
    mov     $2, %rax
    pop     %rcx
    add     %rcx, %rax
    ret
