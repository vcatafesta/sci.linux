SHELL=/bin/bash
DESTDIR=
BINDIR=${DESTDIR}/opt/sci
DOCDIR=${DESTDIR}/opt/doc
INFODIR=${DESTDIR}/usr/share/doc/sci
#MODE=775
MODE=664
DIRMODE=755

.PHONY: build

install:
	@echo "Macrosoft SCI for Linux"
	@echo "Aguarde, instalando software"
	@echo
#	@mkdir -p ${BINDIR}
	@mkdir -p ${DOCDIR}
	@install -d -m 1777 ${BINDIR}
	@install -m 4755 sci ${BINDIR}/sci
	@install -m ${MODE} sci.dbf ${BINDIR}/sci.dbf
	@install -m ${MODE} sci.cfg ${BINDIR}/sci.cfg
	@install -m ${MODE} sci.ini ${BINDIR}/sci.ini
	@mkdir -p ${INFODIR}
	@cp ChangeLog INSTALL LICENSE MAINTAINERS README.md ${DOCDIR}/
	@cp ChangeLog INSTALL LICENSE MAINTAINERS README.md ${INFODIR}/
	@echo "Macrosoft SCI was installed in ${BINDIR}"

uninstall:
	@rm ${BINDIR}/sci
	@rm ${BINDIR}/sci.dbf
	@rm ${BINDIR}/sci.cfg
	@rm ${BINDIR}/sci.ini
	@rm -fd ${BINDIR}
	@echo "Macrosoft SCI was removed."


