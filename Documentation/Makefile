# makefile for documentation for pbuilder.

#required packages:
# docbook-xsl
# ldp-docbook-xsl
# xsltproc
# po4a
# dblatex

# the main XML file which is source to all documents
MASTERXML=pbuilder-doc.xml
MASTERPOT=pbuilder-doc.po
HTMLDOCS= pbuilder-doc.html pbuilder-doc.ja.html pbuilder-doc.fr.html pbuilder-doc.de.html
ALIOTH_FILEHOSTING:=alioth.debian.org

all: $(MASTERPOT) $(HTMLDOCS)

%.html: %.xml pbuilder-doc.xsl
	xsltproc pbuilder-doc.xsl $< > $@.tmp
	mv $@.tmp $@

pbuilder-doc.%.xml: pbuilder-doc.%.po
	po4a-translate -f docbook -m $(MASTERXML) -p $< -l $@ -k 1

pbuilder-doc.%.po: $(MASTERXML)
	po4a-updatepo -f docbook -m $< -p $@ 

%.pdf: %.xml
	# requires dblatex package.
	dblatex --tmpdir=docbuild $<

install: $(HTMLDOCS) pbuilder-doc.pdf
	install -d -m 755 -o root -g root $(DESTDIR)/usr/share/doc/pbuilder/
	install -m 644 -o root -g root $(HTMLDOCS) $(DESTDIR)/usr/share/doc/pbuilder/
	install -m 644 -o root -g root pbuilder-doc.pdf $(DESTDIR)/usr/share/doc/pbuilder/

$(MASTERPOT):
	po4a-gettextize -f docbook -m $(MASTERXML) -p $(MASTERPOT)

preview: pbuilder-doc.html
	mozilla-firefox -remote "openfile($(PWD)/$<)"

release: pbuilder-doc.html pbuilder-doc.xml pbuilder-doc.css pbuilder-doc.xsl pbuilder-doc.pdf
	scp $^ ${ALIOTH_FILEHOSTING}:/home/groups/pbuilder/htdocs/ 

clean:
	rm -fv \
		pbuilder-doc.de.po~ \
		pbuilder-doc.fr.po~ \
		pbuilder-doc.ja.po~ \
		pbuilder-doc.pdf \
		pbuilder-doc.glo \
		pbuilder-doc.idx \
		pbuilder-doc.log \
		pbuilder-doc.out \
		pbuilder-doc.aux \
		pbuilder-doc.html \
		pbuilder-doc.de.html \
		pbuilder-doc.fr.html \
		pbuilder-doc.ja.html \
		pbuilder-doc.html.tmp
	$(MAKE) -C debconf7 $@

.PHONY: preview release-netfort release clean
