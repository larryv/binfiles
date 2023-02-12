# Makefile
# --------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2023 by Lawrence Velazquez <vq@larryv.me>.
#
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide.  This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software.  If not, see
# <https://creativecommons.org/publicdomain/zero/1.0/>.


.POSIX:
.SUFFIXES:
.SUFFIXES: .m4
SHELL = /bin/sh

INSTALL = ./install-sh
INSTALL_PROGRAM = $(INSTALL)
M4 = m4

bindir = $(exec_prefix)/bin
exec_prefix = $(prefix)
prefix = $(HOME)

progs =

all: FORCE $(progs)

clean: FORCE
	rm -f $(progs)

install: FORCE $(progs) installdirs
	$(INSTALL_PROGRAM) $(progs) $(DESTDIR)$(bindir)

installdirs: FORCE
	$(INSTALL) -d $(DESTDIR)$(bindir)

uninstall: FORCE
	CDPATH= cd $(DESTDIR)$(bindir) && rm -f $(progs)

.m4:
	$(M4) -D __SHELL__=$(SHELL) $< >$@

FORCE:
