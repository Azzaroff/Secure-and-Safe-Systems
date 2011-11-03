#
# Normally, you don't need this Makefile to build tg.
# Simply type gnatmake tg, and that should be it.  This Makefile
# helps reconstructing the tg scanner from the aflex source.
# But since the aflex output files already come with the distribution,
# you normally don't need this.
#
# $Id$

AFLEX_OPTIONS = -is

all : tg
.PHONY : all

tg : force
	gnatmake tg

scanner : test_script_scanner.ads test_script_scanner.adb test_script_scanner_io.ads test_script_scanner_io.adb test_script_scanner_dfa.ads test_script_scanner_dfa.adb

%.a %_io.a %_dfa.a: %.l
	aflex $(AFLEX_OPTIONS) $<

%.adb %.ads: %.a
	gnatchop -w $<

clean : 
	rm -f *.o *.ali
	rm -f tg
	rm -f test_script_scanner.a  test_script_scanner_dfa.a \
              test_script_scanner_io.a aflex.error
	rm -f *~ #*#

realclean : clean
	rm -f test_script_scanner.ad* test_script_scanner_dfa.ad* \
	      test_script_scanner_io.ad*

.PHONY : clean force
