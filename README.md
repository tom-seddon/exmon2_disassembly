# EXMON II

(C) 1990 Beebug

An updated version of EXMON II, with updates and code comments from
https://github.com/mincebert and https://github.com/tom-seddon. Based
on BBC Micro EXMON II version 2.02.

Additional features:

- doesn't print `EXMON II` when you press BREAK

- now includes a properly Electron-compatible version

More to come. Watch this space!

# Instructions

See `EXMONIImanual.pdf` in the repo.

# Electron-specific instructions

The manual refers to an Electron version of EXMON II, but there don't
seem to be any copies available. Perhaps it was planned, then never
released; perhaps it's simply been lost to time.

The manual's Electron notes do largely apply to this version. Please
also note the following:

- the ROM reports itself as `EXMON IIe` rather than `EXMON II`

- when using the editor, press FUNC+SHIFT+up/down to scroll to the
  next half page
  
- use `;` to toggle between hex view and disassembly

- the dual screen commands have been removed - but much of the code
  remains, so problems are possible...

# Building

## Prerequisites

### Windows

- Python 3.x

Additional dependencies are provided as pre-built EXEs in the repo.

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

The output ROM images are in the `.build` folder in the working copy:

- `exmon2.rom` is for the BBC B/B+/Master
- `exmon2e.rom` is for the Electron

## Using the ROMs on your BBC or emulator

The .rom files are ordinary 16 KB ROM images. Transfer them to your
BBC, use them to program a PROM, load them into an emulator.

If you use [BeebLink](https://github.com/tom-seddon/beeblink/), add
`beeb` in the working copy to your BeebLink search path. You'll get a
volume called `exmon2_build` containing `:Z.R.EXMON2` (BBC B/B+/Master
version) and `:Z.R.EXMON2E` (Electron version).

# Building an original copy

Check out any of the following tags to build the corresponding
version. You'll need a POSIX-type system with the usual POSIX-type
stuff installed, along with
[64tass](https://sourceforge.net/projects/tass64/) on the path.
(Building these on Windows is an exercise for the reader. Sorry!)

The resulting ROM in each case is `.build/exmon2.rom`.

These ROMs are not Electron-compatible, though some stuff will work to
an extent.

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


