.p2align        4, 0x90
    .globl  main         ## -- Begin function main
main:                    ## @main
    mov     $5, %rax
    mov     $6, %rax
    mov     $1, %rax
    pop      %rcx
    imul      %rcx, %rax
    push   %rax
    pop      %rcx
    add      %rcx, %rax
    mov     $5, %rax
    mov     $222, %rax
    mov     $2, %rax
    pop      %rcx
    imul      %rcx, %rax
    push   %rax
    mov     $6, %rax
    pop      %rcx
    add      %rcx, %rax
    pop      %rcx
    add      %rcx, %rax
    pop      %rcx
    add      %rcx, %rax
    ret
