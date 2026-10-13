# ============================================================
# Milestone 1 - O Contentor
# Motor de Processamento de Dados Simbolicos (GAS, AT&T)
# Compilar: gcc milestone1_contentor.s -o contentor
# ============================================================

.section .data

# Contentor: 8 inteiros de 32 bits COM SINAL (.long).
# Os valores foram escolhidos para a soma ultrapassar o limite
# de 32 bits (overflow) e incluem negativos (usados no Milestone 2).
contentor:
    .long  2000000000
    .long  2000000000
    .long  1500000000
    .long  -500000000
    .long  1000000000
    .long  -250000000
    .long  2100000000
    .long  1750000000

tamanho:
    .long 8                     # numero de elementos do contentor

# Resultado da soma total: 64 bits guardados em duas variaveis de 32 bits
resultado_baixo:
    .long 0                     # 32 bits menos significativos (EAX)
resultado_alto:
    .long 0                     # 32 bits mais significativos  (EDX)

.section .text
.globl main
.type main, @function

main:
    pushq %rbp
    movq  %rsp, %rbp
    pushq %rbx                  # EBX e' callee-saved: preservar

    # Soma total em EDX:EAX (64 bits, com sinal)
    xorl  %eax, %eax            # parte baixa da soma = 0
    xorl  %edx, %edx            # parte alta da soma  = 0

    leaq  contentor(%rip), %rsi # RSI -> primeiro elemento
    movl  tamanho(%rip), %ecx   # ECX = contador de elementos

soma_loop:
    cmpl  $0, %ecx              # ja processou todos?
    je    fim_soma

    movl  (%rsi), %edi          # EDI = elemento atual
    movl  %edi, %ebx
    sarl  $31, %ebx             # EBX = extensao de sinal (0 ou -1)

    addl  %edi, %eax            # soma parte baixa; CF = transporte
    adcl  %ebx, %edx            # soma extensao de sinal + transporte

    addq  $4, %rsi              # proximo elemento (4 bytes)
    decl  %ecx
    jmp   soma_loop

fim_soma:
    movl  %eax, resultado_baixo(%rip)
    movl  %edx, resultado_alto(%rip)

    popq  %rbx
    movl  $0, %eax              # codigo de retorno 0
    popq  %rbp
    ret

# Evita o aviso do linker (pilha nao executavel)
.section .note.GNU-stack,"",@progbits
