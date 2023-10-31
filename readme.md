# Commander x16 development

## Videos and tutorials

* ChibiAkumas  [here](https://www.youtube.com/@ChibiAkumas)
* ChibiAkumas website [here](https://www.assemblytutorial.com/)
* TheRetroDesk [here](https://www.youtube.com/watch?v=gqwIzbT_WFU&ab_channel=TheRetroDesk)
* TheRetroDesk github files  [here](https://github.com/SlithyMatt/x16-assembly-tutorial)
* Commander X16 Assembly Project Setup [here](https://www.youtube.com/watch?v=V2vGiIqDXkA&ab_channel=JestinStoffel)
* Commander X16 6502 Assembly Language Dev Setup [here](https://www.youtube.com/watch?v=oz3E6pGU2KE&ab_channel=Spriteworx)

## Visual Studio Code extentions

 C64 [here](https://marketplace.visualstudio.com/items?itemName=gverduci.c64basicv2)
 kick-assembler [here](https://marketplace.visualstudio.com/items?itemName=paulhocker.kick-assembler-vscode-ext)

## CMD references

setx commands  [here](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc755104(v=ws.10)?redirectedfrom=MSDN)

environment-variable-ref  [here](https://stackoverflow.com/questions/9546324/adding-a-directory-to-the-path-environment-variable-in-windows)

## Set up enviroment

### Commander x16

* refetence  manual [here](https://github.com/x16community/x16-docs)
* forum [here](https://www.commanderx16.com/forum)
* Commander x16 emulator [here](https://github.com/x16community/x16-emulator)

## C64 References

from [here](https://github.com/X16Community/x16-docs/issues/83)
cbmdocs [here](https://sta.c64.org/cbmdocs.html)

cbm64krnfunc  [here](http://sta.c64.org/cbm64krnfunc.html)
c64kernalrom  [here](https://c64os.com/post/c64kernalrom) pretty good writeup with explanations
c64ref  [here](https://www.pagetable.com/c64ref/kernal/)

Here's some more, courtesy of @JimmyDansbo :
 c64-kernal-routines [here](https://www1.cx16.dk/c64-kernal-routines/)
 c128-kernal-routines [here](https://www1.cx16.dk/c128-kernal-routines/)

 6502opcodes [here](http://6502.org/tutorials/6502opcodes.html)
 65c02opcodes [here](http://www.6502.org/tutorials/65c02opcodes.html)

Maybe less useful on the x16:
s [here](https://www.pagetable.com/c64ref/c64disasm/)
s [here](https://project64.c64.org/Software/mapc6411.txt)

### Assemblers

* Acme cross assembler for windows [here](https://sourceforge.net/projects/acme-crossass/files/win32/acme0.97win.zip/download)

* cc65 compiler [here](https://cc65.github.io/)
* KickAssembler [here]( http://theweb.dk/KickAssembler/Main.html#frontpage)

* KickAssembler  [here](http://www.theweb.dk/KickAssembler/KickAssembler.zip)

### Emulators

* SNES emulator (fceux) [here](https://fceux.com/web/home.html)
* BizHawk is a multi-platform emulator  [here](https://tasvideos.org/Bizhawk)

### ca65 Macro Assembler Language Support

Add this extension to VSCode

In VSCode goto extensions
search for ca65
select: ca65 Macro Assembler

Name: ca65 Macro Assembler Language Support (6502/65816)
Id: tlgkccampbell.code-ca65
Description: Provides language support for the ca65 macro assembler.
Version: 1.2.4
Publisher: Cole Campbell
VS Marketplace Link: [here](https://marketplace.visualstudio.com/items?itemName=tlgkccampbell.code-ca65)

select test.asm ffile
press control+shift+p
type
    configure default build task

then enter
select
    ca65: compile and link selected file

this opens a task.json file

to run type

    run default build task

then enter

## Using Acme

select test.asm ffile
press control+shift+p
type
    configure default build task

then press enter
select
     acme: Compile and Link Current File

this opens a task.json file

to run type

    run default build task
or
    ctrl+shift+b

then press enter

* or open the following file:

    .vscode\tasks.json

under the heading

    acme: Compile and Link Current File

edit the path to acme.exe

    "command": "c://path//to//acme.exe  -o ${fileBasenameNoExtension}.prg ${file}"

* this will compile the current selected file
* the -o is the output file located in the base
