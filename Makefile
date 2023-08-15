ifeq ($(OS),Windows_NT)
TASS?=bin\64tass.exe
PYTHON?=py -3
else
TASS?=64tass
PYTHON?=python3
endif

##########################################################################
##########################################################################

TASS:=$(TASS) --m65xx --nostart -Wall --quiet --case-sensitive
#--long-branch

PWD:=$(shell $(PYTHON) submodules/shellcmd.py/shellcmd.py realpath .)
SHELLCMD:=$(PYTHON) "$(PWD)/submodules/shellcmd.py/shellcmd.py"

DEST:=$(PWD)/.build
BEEB_DEST:=$(PWD)/beeb/exmon2_build/z

VERSION:=2.04

##########################################################################
##########################################################################

_V:=$(if $(VERBOSE),,@)

##########################################################################
##########################################################################

.PHONY:build
build:
	$(_V)$(SHELLCMD) mkdir "$(DEST)"
	$(_V)$(SHELLCMD) mkdir "$(BEEB_DEST)"

	$(_V)$(MAKE) _assemble STEM=exmon2 ELECTRON=false
	$(_V)$(MAKE) _assemble STEM=exmon2e ELECTRON=true

	$(_V)$(SHELLCMD) blank-line
	$(_V)$(SHELLCMD) stat "$(DEST)/exmon2.rom"
	$(_V)$(SHELLCMD) stat "$(DEST)/exmon2e.rom"
	$(_V)$(SHELLCMD) sha1 "$(DEST)/exmon2.rom"
	$(_V)$(SHELLCMD) sha1 "$(DEST)/exmon2e.rom"
	$(_V)$(SHELLCMD) blank-line
	$(_V)$(SHELLCMD) copy-file "$(DEST)/exmon2.rom" "$(BEEB_DEST)/R.EXMON2"
	$(_V)$(SHELLCMD) copy-file "$(DEST)/exmon2e.rom" "$(BEEB_DEST)/R.EXMON2E"

##########################################################################
##########################################################################

.PHONY:_assemble
_assemble:
	$(_V)$(TASS) -D ELECTRON=$(ELECTRON) -D VERSION=\"$(VERSION)\" exmon2.s65 -L "$(DEST)/$(STEM).lst" "-l$(DEST)/$(STEM).sym" "-o$(DEST)/$(STEM).rom"

##########################################################################
##########################################################################

.PHONY:clean
clean:
	$(_V)$(SHELLCMD) rm-tree "$(DEST)"

##########################################################################
##########################################################################

.PHONY:lkg
lkg:
	$(_V)$(SHELLCMD) copy-file "$(DEST)/exmon2.rom" "$(DEST)/lkg.exmon2.rom"
	$(_V)$(SHELLCMD) copy-file "$(DEST)/exmon2e.rom" "$(DEST)/lkg.exmon2e.rom"

##########################################################################
##########################################################################

.PHONY:release
release: ZIP:=$(PWD)/releases/exmon2-$(VERSION).zip
release:
	$(_V)$(MAKE) build
	$(_V)$(PYTHON) submodules/beeb/bin/ssd_create.py -o "$(DEST)/exmon2.ssd" "$(BEEB_DEST)/R.EXMON2" "$(BEEB_DEST)/R.EXMON2E"
	$(_V)zip -9 -j "$(ZIP)" "$(DEST)/exmon2.ssd" "$(DEST)/exmon2.rom" "$(DEST)/exmon2e.rom"
