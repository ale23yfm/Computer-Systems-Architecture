<b>First step:</b>
Ensure that you are in the right directory

```dir```

<b>Second step:</b>
Build nasm (see .obj after the command)

```nasm modulAsm.asm -fwin32 -o modulAsm.obj```

<b>Third step:</b>
Compile c function and link it to asm (see the out like main.exe, moduleASM.obj, main.obj)

```cl main.c /link moduleAsm.obj```

<b>to see the files:</b>
```dir```

<b>Last step:</b>
Run the program:

```main.exe```
