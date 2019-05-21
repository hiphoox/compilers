.p2align        4, 0x90
    .globl  main         ## -- Begin function main
main:                    ## @main
    movl     $3, %eax
    neg     %eax
    cmpl     $0, %eax
    movl     $0, %eax
    sete     %al
    ret
