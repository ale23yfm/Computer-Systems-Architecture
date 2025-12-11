<b>First step:</b>

Ensure that nasm, alink and ollydbg are in your folder

<b>Secod step:</b>

Ensure that you are in the right directory

```dir```

<b>Assembling</b>

```.\nasm -f obj module.asm```

```.\nasm -f obj project.asm```

<b>Linking</b>

```.\alink project.obj module.obj -oPE -subsys console -entry start```

<b>Run the program</b>

```.\project.exe```

<b>Debugger</b>

```.\OLLYDBG.EXE project.exe```
