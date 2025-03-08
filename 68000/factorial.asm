ORG $1000

Num: DC.W 5 ; num = 5;
Res: DC.W 1 ; res = 1

FACTORIAL:
    MOVE Num, D0
    Move Res, D1
LOOP:
    CMP #1, D0 ; Compare D0==1
    BEQ END
    MULS D0, D1  ; res = res * num
    SUB #1, D0  ; n--
    JMP LOOP
END:
    MOVE D1, Res
