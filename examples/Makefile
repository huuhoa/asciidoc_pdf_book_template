PDF = asciidoctor-pdf
TEMPLATE_DIR=../asciidoc_template

PFLAGS = -d book -a pdf-themesdir=$(TEMPLATE_DIR)/themes -a pdf-theme=note -a pdf-fontsdir=$(TEMPLATE_DIR)/fonts,GEM_FONTS_DIR -r $(TEMPLATE_DIR)/src/note-extension.rb

all:
	@$(PDF) $(PFLAGS) sample.asciidoc -o sample.pdf
	@open sample.pdf
