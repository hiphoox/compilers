.p2align        4, 0x90
    .globl  main         ## -- Begin function main
main:                    ## @main
    mov     $2, %rax
    not     %rax
    push    %rax
    mov     $3, %rax
    pop     %rcx
    add     %rcx, %rax
    ret
