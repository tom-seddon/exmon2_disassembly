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
BEEB_DEST:=$(PWD)/beeb/exmon2_build/z

##########################################################################
##########################################################################

_V:=$(if $(VERBOSE),,@)

##########################################################################
##########################################################################

.PHONY:build
build:
	$(_V)$(SHELLCMD) mkdir "$(DEST)"
	$(_V)$(SHELLCMD) mkdir "$(BEEB_DEST)"

	$(_V)$(MAKE) _assemble STEM=exmon2 BUILD_TYPE=0 ELECTRON=0
	$(_V)$(MAKE) _assemble STEM=exmon2e BUILD_TYPE=0 ELECTRON=1

	$(_V)$(SHELLCMD) blank-line
	$(_V)$(SHELLCMD) stat "$(DEST)/exmon2.rom"
	$(_V)$(SHELLCMD) stat "$(DEST)/exmon2e.rom"
	$(_V)$(SHELLCMD) sha1 "$(DEST)/exmon2.rom"
	$(_V)$(SHELLCMD) sha1 "$(DEST)/exmon2e.rom"
	$(_V)$(SHELLCMD) blank-line
	$(_V)$(SHELLCMD) copy-file "$(DEST)/exmon2.rom" "$(BEEB_DEST)/R.EXMON2"
	$(_V)$(SHELLCMD) copy-file "$(DEST)/exmon2e.rom" "$(BEEB_DEST)/R.EXMON2E"

.PHONY:_assemble
_assemble:
	$(_V)$(TASS) -D BUILD_TYPE=$(BUILD_TYPE) -D ELECTRON=$(ELECTRON) exmon2.s65 "-L$(DEST)/$(STEM).lst" "-o$(DEST)/$(STEM).lst" "-l$(DEST)/$(STEM).sym" "-o$(DEST)/$(STEM).rom"

##########################################################################
##########################################################################

.PHONY:clean
clean:
	$(_V)$(SHELLCMD) rm-tree "$(DEST)"

##########################################################################
##########################################################################
