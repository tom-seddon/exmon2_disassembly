# Exmon II

(C) 1990 Beebug

An updated version of Exmon II, a machine code monitor for the BBC
Micro, with updates and code comments from
https://github.com/mincebert and https://github.com/tom-seddon.

Based on Exmon II version 2.02.

Additional features:

- doesn't print `EXMON II` when you press BREAK

More to come. Watch this space!

# Building

## Prerequisites

### Windows

- Python 3.x

Additional dependencies are provided as pre-build EXEs in the repo.

### POSIX-type

- GNU Make (`make`)
- Python 3.x (`/usr/bin/python3`)
- [64tass](https://sourceforge.net/projects/tass64/) (`64tass`) -
  version 2974 works

## Clone the repo

The repo has submodules. Clone it with `--recursive`:

    git clone --recursive https://github.com/tom-seddon/exmon2_disassembly
	
Alternatively, if you already cloned it non-recursively, you can do
the following from inside the working copy:

    git submodule init
	git submodule update

## Build the code

Run `make` in the root of the working copy. (A `make.bat` is supplied
for Windows, which will run the supplied copy of GNU Make.)

The output ROM image is `.build/exmon2.rom` in the working copy.

If you use [BeebLink](https://github.com/tom-seddon/beeblink/), add
`beeb` in the working copy to your BeebLink search path. You'll get a
volume called `exmon2_build` containing `:Z.R.EXMON2`.

# Building an original copy

Check out any of the following tags to build the corresponding
version. You'll need a POSIX-type system with the usual POSIX-type
stuff installed, along with
[64tass](https://sourceforge.net/projects/tass64/) on the path.

The resulting ROM in each case is `.build/exmon2.rom`.

## v2.02

Looks to be the newest version I've found so far. Probably
recommended.

## v2.02-alt

Doesn't properly support BBC B/B+ with a 65c02. It will assume your
BBC has an ordinary non-CMOS 6502.

## v2.01

All the problems of v2.02, and it doesn't support BASIC 4r32 either.

(Also a few code differences that I haven't looked at very closely -
looks like there may be some issues with running code in other ROMs.)


