.section .data

contentor:
    .long 1000000000
    .long 2000000000
    .long 1500000000
    .long 500000000
    .long 250000000
    .long 750000000
    .long 1200000000
    .long 800000000

tamanho:
    .long 8

resultado_baixo:
    .long 0
resultado_alto:
    .long 0

.section .text
.globl main
.type main, @function

main:
    xorl %eax, %eax           
    xorl %edx, %edx        

    leaq contentor(%rip), %rsi  
    movl tamanho(%rip), %ecx    

soma_loop:
    cmpl $0, %ecx
    je fim_soma

    addl (%rsi), %eax          
    adcl $0, %edx            

    addq $4, %rsi               
    decl %ecx
    jmp soma_loop

fim_soma:
    movl %eax, resultado_baixo(%rip)
    movl %edx, resultado_alto(%rip)

    movl $0, %eax              
    ret

.section .note.GNU-stack,"",@progbits
