DEST:=.build
TASS:=64tass --m65xx --nostart -Wall -Wno-implied-reg -q
#--long-branch

##########################################################################
##########################################################################

.PHONY:build
build:
	mkdir -p "$(DEST)"

	@$(MAKE) _assemble STEM=exmon2

	@echo

	@ls -l "$(DEST)/exmon2.rom"
	@sha1sum "$(DEST)/exmon2.rom"
	@echo

.PHONY:_assemble
_assemble:
	$(TASS) -D BUILD_TYPE=$(BUILD_TYPE) exmon2.s65 "-L$(DEST)/$(STEM).lst" "-o$(DEST)/$(STEM).lst" "-l$(DEST)/$(STEM).sym" "-o$(DEST)/$(STEM).rom"

##########################################################################
##########################################################################

.PHONY:clean
clean:
	rm -Rf "$(DEST)"
