Milestone 1 - O Contentor
Para compilar e executar: gcc milestone1_contentor.s -o contentor && ./contentor

Descricao
O programa tem um contentor em .data com 8 inteiros de 32 bits. Um ciclo percorre os 8 valores e calcula a soma total, que fica guardada em duas variaveis: resultado_baixo (parte baixa, EAX) e resultado_alto (parte alta, EDX).

Tamanho de dados
Escolhemos .long (32 bits). O enunciado pede inteiros de 32 bits e em GAS isso corresponde a .long, com 4 bytes por elemento (por isso o ponteiro avanca 4 bytes em cada iteracao). Os tipos .byte e .word seriam pequenos demais para valores na ordem dos milhares de milhoes.

Overflow
A soma de varios valores de 32 bits pode passar o limite de um registo de 32 bits, por isso o total e acumulado em 64 bits, em EDX:EAX. O addl soma o elemento a parte baixa e, se houver overflow, a flag CF fica a 1. O adcl $0 soma esse transporte a parte alta (EDX).

Caso de teste
Valores: 1000000000, 2000000000, 1500000000, 500000000, 250000000, 750000000, 1200000000, 800000000.
A soma esperada e 8000000000, ou seja resultado_alto = 1 e resultado_baixo = 3705032704. Confirmamos no gdb com um breakpoint em fim_soma. Estes valores forcam overflow de 32 bits, o que valida o uso do adc.

Notas
Neste milestone os valores sao tratados sem sinal. O resultado le-se como um inteiro sem sinal de 64 bits (EDX:EAX). Por isso, no gdb, resultado_baixo = 3705032704 (0xDCD65000) aparece como -589934592 com print/d ou x/wd, porque o bit mais alto esta a 1 e o gdb le o valor com sinal.

