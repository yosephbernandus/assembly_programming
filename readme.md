# Assembly Programming

```
nasm -f elf64 factorial.asm -o factorial.o
ld factorial.o -o factorial
./factorial

nasm -f elf64 stack_push_and_pop.asm -o stack_push_and_pop.o
ld stack_push_and_pop.o -o stack_push_and_pop
./stack_push_and_pop


- C: clang -o hello hello.c
```
