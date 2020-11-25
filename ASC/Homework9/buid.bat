nasm -f obj CheckDecimal.asm
nasm -f obj main.asm
alink CheckDecimal.obj main.obj
pause