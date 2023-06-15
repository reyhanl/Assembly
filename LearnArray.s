.global _main
.align 2

_main:
    LDR x1, =arr1
    MOV x3, #(2 * 4)
    LDR w2, [x1, x3]


arr1:
.fill 10,4,0