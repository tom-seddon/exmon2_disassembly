ifeq ($(OS),Windows_NT)
TASS?=bin\64tass.exe
PYTHON?=py -3
else
TASS?=64tass
PYTHON?=python3
endif

##########################################################################
##########################################################################

TASS:=$(TASS) --m65xx --nostart -Wall -Wno-implied-reg -q
#--long-branch

PWD:=$(shell $(PYTHON) submodules/shellcmd.py/shellcmd.py realpath .)
SHELLCMD:=$(PYTHON) "$(PWD)/submodules/shellcmd.py/shellcmd.py"

DEST:=$(PWD)/.build

##########################################################################
##########################################################################

_V:=$(if $(VERBOSE),,@)

##########################################################################
##########################################################################

.PHONY:build
build:
	$(_V)$(SHELLCMD) mkdir "$(DEST)"

	$(_V)$(MAKE) _assemble STEM=exmon2 BUILD_TYPE=0

	$(_V)$(SHELLCMD) blank-line
	$(_V)$(SHELLCMD) stat "$(DEST)/exmon2.rom"
	$(_V)$(SHELLCMD) sha1 "$(DEST)/exmon2.rom"
	$(_V)$(SHELLCMD) blank-line

.PHONY:_assemble
_assemble:
	$(_V)$(TASS) -D BUILD_TYPE=$(BUILD_TYPE) exmon2.s65 "-L$(DEST)/$(STEM).lst" "-o$(DEST)/$(STEM).lst" "-l$(DEST)/$(STEM).sym" "-o$(DEST)/$(STEM).rom"

##########################################################################
##########################################################################

.PHONY:clean
clean:
	$(_V)$(SHELLCMD) rm-tree "$(DEST)"

##########################################################################
##########################################################################
