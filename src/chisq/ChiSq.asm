secread t0
secread t1
secread t2
econst t3, 4
emult v1, t0, t2
move t4, v1
emult v1, t3, t4
move t3, v1
emult v1, t1, t1
move t4, v1
esub v1, t3, t4
move t3, v1
econst t4, 2
emult v1, t4, t0
move t0, v1
eadd v1, t0, t1
move t0, v1
econst t4, 2
emult v1, t4, t2
move t2, v1
eadd v1, t2, t1
move t1, v1
emult v1, t3, t3
move t2, v1
econst t2, 2
emult v1, t0, t0
move t3, v1
emult v1, t2, t3
move t2, v1
emult v1, t0, t1
move t0, v1
econst t0, 2
emult v1, t1, t1
move t1, v1
emult v1, t0, t1
move t0, v1
answer t0

