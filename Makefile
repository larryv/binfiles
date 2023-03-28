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


# ------------------
# USER-FACING MACROS

# Hard-coded into the shebangs of shell scripts.
SHELL = /bin/sh

# Hard-coded into grep_.
GREP = grep
# Reduce the number of shells in play by invoking install-sh with
# the same shell that make(1) uses.  Use "./install-sh" instead of
# "install-sh" to preclude inadvertent PATH searches [1][2].
INSTALL = $(SHELL) ./install-sh
INSTALL_PROGRAM = $(INSTALL)
# Hard-coded into ls_.
LS = ls
M4 = m4

bindir = $(exec_prefix)/bin
exec_prefix = $(prefix)
prefix = /usr/local


# ---------------
# INTERNAL MACROS

all_m4flags = \
    -D __GREP__=$(GREP) \
    -D __LS__=$(LS) \
    -D __SHELL__=$(SHELL) \

cleanup = { rc=$$?; rm -f $@ && exit "$$rc"; }
progs = grep_ ls_


# -------
# TARGETS

all: FORCE $(progs)
clean: FORCE
	rm -f $(progs)
install: FORCE $(progs) installdirs
	$(INSTALL_PROGRAM) $(progs) $(DESTDIR)$(bindir)
installdirs: FORCE
	$(INSTALL) -d $(DESTDIR)$(bindir)
# Clear CDPATH to preclude unexpected cd(1) behavior [3].
uninstall: FORCE
	CDPATH= cd $(DESTDIR)$(bindir) && rm -f $(progs)

# Portably imitate .DELETE_ON_ERROR [4] because m4(1) may fail after the
# shell creates/truncates the target.
.m4:
	$(M4) $(all_m4flags) $< >$@ || $(cleanup)

# Imitate .PHONY portably [5].
FORCE:


# ----------
# REFERENCES
#
#  1. https://www.gnu.org/software/autoconf/manual/autoconf-2.71/html_node/Invoking-the-Shell.html
#  2. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sh.html
#  3. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/cd.html
#  4. https://www.gnu.org/software/make/manual/html_node/Errors.html
#  5. https://www.gnu.org/software/make/manual/html_node/Force-Targets
