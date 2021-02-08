DEST:=.build
TASS:=64tass --m65xx --nostart -Wall -Wno-implied-reg -q
#--long-branch

##########################################################################
##########################################################################

.PHONY:build
build:
	mkdir -p "$(DEST)"

	@$(MAKE) _assemble BUILD_TYPE=0 STEM=exmon2-2.02
	@$(MAKE) _assemble BUILD_TYPE=1 STEM=exmon2-2.02-alt
	@$(MAKE) _assemble BUILD_TYPE=2 STEM=exmon2-2.01

	@echo

	@ls -l "$(DEST)/exmon2-2.02.rom"
	@sha1sum orig/exmon2-2.02.rom "$(DEST)/exmon2-2.02.rom"
	@echo

	@ls -l "$(DEST)/exmon2-2.02-alt.rom"
	@sha1sum orig/exmon2-2.02-alt.rom "$(DEST)/exmon2-2.02-alt.rom"
	@echo

	@ls -l "$(DEST)/exmon2-2.01.rom"
	@sha1sum orig/exmon2-2.01.rom "$(DEST)/exmon2-2.01.rom"
	@echo

.PHONY:_assemble
_assemble:
	$(TASS) -D BUILD_TYPE=$(BUILD_TYPE) exmon2.s65 "-L$(DEST)/$(STEM).lst" "-o$(DEST)/$(STEM).lst" "-l$(DEST)/$(STEM).sym" "-o$(DEST)/$(STEM).rom"

##########################################################################
##########################################################################

.PHONY:diff201
diff201:
	vbindiff "$(DEST)/exmon2-2.01.rom" exmon2-2.01.rom

.PHONY:diff202
diff202:
	vbindiff "$(DEST)/exmon2-2.02.rom" exmon-2.02.rom

##########################################################################
##########################################################################

.PHONY:clean
clean:
	rm -Rf "$(DEST)"
