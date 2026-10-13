Milestone 1 - O Contentor
Para compilar e executar: gcc milestone1_contentor.s -o contentor && ./contentor
Descricao

O programa tem um contentor em .data com 8 inteiros de 32 bits com sinal. Um ciclo percorre os 8 valores e calcula a soma total, que fica guardada em duas variaveis: resultado_baixo (parte baixa, EAX) e resultado_alto (parte alta, EDX).

Tamanho de dados
Escolhemos .long (32 bits). O enunciado pede inteiros de 32 bits e em GAS isso corresponde a .long, com 4 bytes por elemento (por isso o ponteiro avanca 4 bytes em cada iteracao). Os tipos .byte e .word seriam pequenos demais para valores na ordem dos milhares de milhoes.
Overflow

A soma de varios valores de 32 bits pode passar o limite de um registo de 32 bits, por isso o total e acumulado em 64 bits, em EDX:EAX. O addl soma a parte baixa e o transporte fica na flag CF. O adcl soma esse transporte a parte alta, juntamente com a extensao de sinal do elemento (sarl $31 da 0 para positivos e -1 para negativos).

Assim os valores negativos tambem sao somados corretamente, o que vai ser preciso no Milestone 2.

Caso de teste

Valores: 2000000000, 2000000000, 1500000000, -500000000, 1000000000, -250000000, 2100000000, 1750000000.
A soma esperada e 9600000000, ou seja resultado_alto = 2 e resultado_baixo = 1010065408. Confirmamos no gdb com um breakpoint em fim_soma. Estes valores forcam overflow de 32 bits, o que valida o uso do adc.

