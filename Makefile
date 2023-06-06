# Makefile
# --------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2023 by Lawrence Velazquez <vq@larryv.me>.
#
# To the extent possible under law, the author has dedicated all
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


# ---------------
# "PUBLIC" MACROS

# Remember to update the READMEs after adding new macros here.

# Hard-coded into the shebangs of shell scripts.
SHELL = /bin/sh

# Hard-coded into grep_.
GREP = grep
INSTALL = ./install-sh
INSTALL_PROGRAM = $(INSTALL)
# Hard-coded into ls_.
LS = ls
M4 = m4
SHELLCHECK = shellcheck

bindir = $(exec_prefix)/bin
exec_prefix = $(prefix)
prefix = /usr/local


# ----------------
# "PRIVATE" MACROS

all_m4flags = \
    -D __GREP__=$(GREP) \
    -D __LS__=$(LS) \
    -D __SHELL__=$(SHELL) \
    $(M4FLAGS)
do_cleanup = { rc=$$?; rm -f $@ && exit "$$rc"; }
bin_SCRIPTS = grep_ ls_


# --------------
# "PUBLIC" RULES

all: FORCE $(bin_SCRIPTS)

check: FORCE $(bin_SCRIPTS)
	$(SHELLCHECK) $(SHELLCHECKFLAGS) $(bin_SCRIPTS)

clean: FORCE
	rm -f $(bin_SCRIPTS)

install: FORCE $(progs) installdirs
	$(INSTALL_PROGRAM) $(bin_SCRIPTS) $(DESTDIR)$(bindir)

installdirs: FORCE
	$(INSTALL) -d $(DESTDIR)$(bindir)

# Clear CDPATH to preclude unexpected cd(1) behavior [1].
uninstall: FORCE
	CDPATH= cd $(DESTDIR)$(bindir) && rm -f $(bin_SCRIPTS)


# ---------------
# "PRIVATE" RULES

# Imitate .PHONY portably [2].
FORCE:

# Portably imitate .DELETE_ON_ERROR [3] because m4(1) may fail after the
# shell creates/truncates the target.
.m4:
	$(M4) $(all_m4flags) $< >$@ || $(do_cleanup)
	-chmod +x $@


# ----------
# REFERENCES
#
#  1. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/cd.html
#  2. https://www.gnu.org/software/make/manual/html_node/Force-Targets
#  3. https://www.gnu.org/software/make/manual/html_node/Errors.html
