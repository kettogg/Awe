PREFIX = /usr
DESTDIR ?= /home/re1san/.themes/Kizu
INSTALL_DIR ?= $(DESTDIR)

all:
	npm install && npm run build

install:
	@install -v -d "$(INSTALL_DIR)"
	@install -m 0644 -v index.theme "$(INSTALL_DIR)"
	@cp -rv assets gtk-3.0 "$(INSTALL_DIR)"

uninstall:
	@rm -vrf "$(INSTALL_DIR)"

.PHONY: all install uninstall
