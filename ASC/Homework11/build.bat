nasm checkPositive.asm -fwin32 -o checkPositive.obj
cd C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build
call vcvars32.bat
cd C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Tools\MSVC\14.16.27023\bin\Hostx86\x86
cl C:\Users\popvl\asm_tools\Homework11\main.c /link C:\Users\popvl\asm_tools\Homework11\checkPositive.obj
pause..