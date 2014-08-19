PERL6=perl6-m

TARGET=mbc
EXT=moarvm

SOURCES= \
    ./lib/Bio/Root/Root.pm6 \
    ./lib/Bio/Grammar/Fasta.pm6 \
    ./lib/Bio/Role/Range.pm6 \
    ./lib/Bio/Role/Describe.pm6 \
    ./lib/Bio/Role/Identify.pm6 \
    ./lib/Bio/Tools/IUPAC.pm6 \
    ./lib/Bio/Tools/CodonTable.pm6 \
    ./lib/Bio/Type/Sequence.pm6 \
    ./lib/Bio/PrimarySeq.pm6 

TARGETS=$(SOURCES:.pm6=.pm6.${EXT})

all: $(TARGETS)

%.pm6.moarvm: %.pm6
	$(PERL6) --target=${TARGET} --output=$@ $<

clean:
	rm -f $(TARGETS)

test: all
	prove -e '$(PERL6)' -r --nocolor t/
