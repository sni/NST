VERSION=$(shell grep em:version install.rdf | sed -e 's/.*>\(.*\)<.*/\1/')

dist:
	zip -r -9 ../NST-$(VERSION).ko.xpi . -x .git/\* -x *.xpi -x *.pdf
	@echo ""
	@echo "created:"
	@mv ../NST-$(VERSION).ko.xpi .
	@ls -la NST-$(VERSION).ko.xpi

clean:
	rm -f *.xpi

mrproper:
	git clean -xfd

version:
	newversion=$$(dialog --stdout --inputbox "New Version:" 0 0 "$(VERSION)") ; \
	if [ -n "$$newversion" ] && [ "$$newversion" != "$(VERSION)" ]; then \
		sed -ri "s/$(VERSION)/$$newversion/" content/NST.js install.rdf; \
	fi ;
