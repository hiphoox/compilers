.p2align        4, 0x90
    .globl  main         ## -- Begin function main
main:                    ## @main
    movl     $12, %eax
    cmpl     $0, %eax
    movl     $0, %eax
    sete     %al
    ret
