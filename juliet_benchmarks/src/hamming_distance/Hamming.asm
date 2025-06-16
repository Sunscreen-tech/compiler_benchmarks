econst t0, 0
pubread t1
move t2, 0
__L1_MAIN__:
cmpl v1, t2, t1
move t3, v1
beq t3, zero, __L2_MAIN__
secread t3
secread t4
exor v1, t3, t4
move t5, v1
move t6, 0
__L3_MAIN__:
cmpl v1, t6, 8
move t7, v1
beq t7, zero, __L4_MAIN__
eslr v1, t5, t6
move t7, v1
econst t8, 1
eand v1, t7, t8
move t7, v1
eadd v1, t0, t7
move t7, v1
move t0, t7
add v1, t6, 1
move t6, v1
j __L3_MAIN__
__L4_MAIN__:
add v1, t2, 1
move t2, v1
j __L1_MAIN__
__L2_MAIN__:
answer t0

