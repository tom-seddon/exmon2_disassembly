# Exmon II

(C) 1990 Beebug

WIP commented disassembly of Exmon II, a machine code monitor for the
BBC Micro.

I've got some plans for extensions, but for now this does no more than
build an exact copy of one of the following three versions of Exmon
II.

## 2.02

Looks to be the newest version I've found so far. Probably
recommended.

## 2.02-alt

Lacks support for BBC B/B+ with a 65c02.

## 2.01

Lacks support for BASIC 4r32.

A few code changes that I haven't looked at very closely - looks like
there may be some issues with running code in other ROMs.

# Building

Mandatory prerequisites:

- [64tass](https://sourceforge.net/projects/tass64/)
- a Unix-type system with the usual Unix-type stuff (on Windows, you
  should be good with WSL, cygwin, Git Bash, etc.)
  
Optional prerequisites:

- [vbindiff](https://www.cjmweb.net/vbindiff/)

To build, type `make`, producing 3 output files:

- `.build/exmon2-2.02.rom`
- `.build/exmon2-2.02-alt.rom`
- `.build/exmon2-2.01.rom`

