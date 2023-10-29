# Commander x16 development

## Videos and tutorials
* ChibiAkumas  [here](https://www.youtube.com/@ChibiAkumas)
* ChibiAkumas website [here](https://www.assemblytutorial.com/)
* TheRetroDesk [here](https://www.youtube.com/watch?v=gqwIzbT_WFU&ab_channel=TheRetroDesk)
* TheRetroDesk github files  [here](https://github.com/SlithyMatt/x16-assembly-tutorial)
* Commander X16 Assembly Project Setup [here](https://www.youtube.com/watch?v=V2vGiIqDXkA&ab_channel=JestinStoffel)

## Visual Studio Code extentions
 C64 [here](https://marketplace.visualstudio.com/items?itemName=gverduci.c64basicv2)

## Set up enviroment

### Commander x16
* refetence  manual [here](https://github.com/x16community/x16-docs)
* forum [here](https://www.commanderx16.com/forum)
* Commander x16 emulator [here](https://github.com/x16community/x16-emulator)

### Assemblers

* Acme cross assembler for windows [here](https://sourceforge.net/projects/acme-crossass/files/win32/acme0.97win.zip/download)

* cc65 compiler [here](https://cc65.github.io/)

* KickAssembler  [here](http://www.theweb.dk/KickAssembler/KickAssembler.zip)
*
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
VS Marketplace Link: https://marketplace.visualstudio.com/items?itemName=tlgkccampbell.code-ca65





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

* open file

    .vscode\tasks.json

under the heading

    acme: Compile and Link Current File

edit the path to acme.exe

    "command": "c://path//to//acme.exe  -o ${fileBasenameNoExtension}.prg ${file}",

tis will compile the current selected file
the -o is the output file located in the base



