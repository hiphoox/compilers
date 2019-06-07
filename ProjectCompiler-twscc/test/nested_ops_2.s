.p2align        4, 0x90
    .globl  main         ## -- Begin function main
main:                    ## @main
    mov     $0, %rax
    not     %rax
    push    %rax
    neg     %rax
    ret
