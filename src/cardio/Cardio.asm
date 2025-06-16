secread t0
secread s2
secread s1
secread s0
secread t4
secread t5
secread t6
secread t7
secread t8
secread t9
econst t3, 50
ecmpl v1, t3, t4
move t3, v1
eand v1, t0, t3
move t3, v1
econst t2, 1
esub v1, t2, t0
move t2, v1
econst t1, 60
ecmpl v1, t1, t4
move t1, v1
eand v1, t2, t1
move t1, v1
econst t2, 40
ecmpl v1, t5, t2
move t2, v1
econst t4, 90
esub v1, t7, t4
move t4, v1
ecmpl v1, t4, t6
move t4, v1
econst t5, 30
ecmpl v1, t8, t5
move t5, v1
econst t6, 3
ecmpl v1, t6, t9
move t6, v1
eand v1, t0, t6
move t6, v1
econst t7, 1
esub v1, t7, t0
move t0, v1
econst t7, 2
ecmpl v1, t7, t9
move t7, v1
eand v1, t0, t7
move t0, v1
eadd v1, t3, t1
move t1, v1
eadd v1, t1, s2
move t1, v1
eadd v1, t1, s1
move t1, v1
eadd v1, t1, s0
move t1, v1
eadd v1, t1, t2
move t1, v1
eadd v1, t1, t4
move t1, v1
eadd v1, t1, t5
move t1, v1
eadd v1, t1, t6
move t1, v1
eadd v1, t1, t0
move t0, v1
answer t0

