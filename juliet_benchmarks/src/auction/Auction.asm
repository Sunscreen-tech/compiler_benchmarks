pubread t0
secread t1
move t2, t1
move t3, 1
__L1_MAIN__:
cmpl v1, t3, t0
move t4, v1
beq t4, zero, __L2_MAIN__
secread t4
ecmpl v1, t2, t4
move t5, v1
mux t5, t5, t4, t2
move t2, t5
ecmpl v1, t5, t4
move t5, v1
mux t5, t5, t4, t1
move t1, t5
add v1, t3, 1
move t3, v1
j __L1_MAIN__
__L2_MAIN__:
answer t2

