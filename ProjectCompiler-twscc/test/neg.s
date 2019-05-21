.p2align        4, 0x90
    .globl  main         ## -- Begin function main
main:                    ## @main
    movl     $5, %eax
    neg     %eax
    ret
