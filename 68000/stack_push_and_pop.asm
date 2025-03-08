ORG $1000

; Evaluate: 2 + 4 * 3 - 6

START:
    ; Write here your code
    MOVE #2, D0
    MOVE #4, D1
    MOVE #3, D2
    MOVE #6, D3
    MULS D1, D2   ; D2 := 12
    ADD D0, D2    ; D2 := 14
    SUB D3, D2    ; D2 := 8

    ; Push the result that is in D2 to the stack
    MOVE D2, -(SP)
    MOVE (SP)+, D7
END: ; Jump here to end the program
