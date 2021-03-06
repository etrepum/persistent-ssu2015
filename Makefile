# Install pandoc globally or run "cabal sandbox init; cabal install pandoc hobbes"
PANDOC ?= $(shell which ./.cabal-sandbox/bin/pandoc 2>/dev/null || echo pandoc)
HOBBES ?= $(shell which ./.cabal-sandbox/bin/hobbes 2>/dev/null || echo hobbes)

.PHONY: all live

all: index.html

reveal.js/.gitignore:
	git submodule init
	git submodule update

live:
	$(HOBBES) | grep -v '/\.' --line-buffered | while read filename; do echo $$filename; make; done

index.html: slides.md header.html default.revealjs Makefile | reveal.js/.gitignore
	$(PANDOC) -s \
	  --mathjax \
	  --include-in-header="header.html" \
	  -t revealjs \
	  --variable=transition:none \
	  --variable=css:reveal.js/css/theme/white.css \
	  --variable=css:vendor/font-awesome-4.3.0/css/font-awesome.css \
	  --from=markdown+definition_lists \
	  --template default.revealjs \
	  -o $@ \
	  $<
