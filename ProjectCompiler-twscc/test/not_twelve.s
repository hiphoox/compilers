.p2align        4, 0x90
    .globl  main         ## -- Begin function main
main:                    ## @main
    mov     $12, %rax
    push    %rax
    cmp     $0, %rax
    mov     $0, %rax
    sete    %al
    ret
