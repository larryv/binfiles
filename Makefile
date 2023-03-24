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

# Reduce the number of shells in play by invoking install-sh with
# the same shell that make(1) uses.  Use "./install-sh" instead of
# "install-sh" to preclude inadvertent PATH searches [1][2].
INSTALL = $(SHELL) ./install-sh
INSTALL_PROGRAM = $(INSTALL)
M4 = m4

bindir = $(exec_prefix)/bin
exec_prefix = $(prefix)
prefix = /usr/local

progs = grep_ ls_

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


# ----------
# REFERENCES
#
#  1. https://www.gnu.org/software/autoconf/manual/autoconf-2.71/html_node/Invoking-the-Shell.html
#  2. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sh.html
