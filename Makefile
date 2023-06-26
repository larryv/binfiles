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

# NOTE: Update the READMEs after adding new macros here.

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
SHELLCHECKFLAGS = --norc

bindir = $(exec_prefix)/bin
exec_prefix = $(prefix)
prefix = /usr/local


# ----------------
# "PRIVATE" MACROS

# Clear CDPATH to preclude unexpected cd(1) behavior [1].
do_cd = CDPATH= cd
do_cleanup = { rc=$$?; rm -f $@ && exit "$$rc"; }
# Insert M4FLAGS first to allow the use of System V options that must
# precede -D [2].
do_m4 = $(M4) \
	$(M4FLAGS) \
	-D __GREP__=$(GREP) \
	-D __LS__=$(LS) \
	-D __SHELL__=$(SHELL)
bin_SCRIPTS = grep_ ls_


# --------------
# "PUBLIC" RULES

all: FORCE $(bin_SCRIPTS)

check: FORCE $(bin_SCRIPTS)
	$(SHELLCHECK) $(SHELLCHECKFLAGS) $(bin_SCRIPTS)

clean: FORCE
	rm -f $(bin_SCRIPTS)

# If BAR/FOO is a directory or a symbolic link to one, then the behavior
# of "install FOO BAR" varies *significantly* among implementations.
# Ensures consistency by detecting this situation early and bailing out.
install: FORCE all installdirs
	@for f in $(bin_SCRIPTS); \
do \
    p=$(DESTDIR)$(bindir)/$$f; \
    if test -d "$$p"; \
    then \
        printf 'will not overwrite directory: %s\n' "$$p" >&2; \
        exit 1; \
    fi; \
done
	$(INSTALL_PROGRAM) $(bin_SCRIPTS) $(DESTDIR)$(bindir)

# Intentionally does not depend on the "install" target, so a casual
# "make installcheck" won't overwrite an existing installation.
installcheck: FORCE
	$(do_cd) $(DESTDIR)$(bindir) \
    && $(SHELLCHECK) $(SHELLCHECKFLAGS) $(bin_SCRIPTS)

installdirs: FORCE
	$(INSTALL) -d $(DESTDIR)$(bindir)

uninstall: FORCE
	$(do_cd) $(DESTDIR)$(bindir) && rm -f $(bin_SCRIPTS)


# ---------------
# "PRIVATE" RULES

# Imitate .PHONY portably [3].
FORCE:

# Portably imitate .DELETE_ON_ERROR [4] because m4(1) may fail after the
# shell creates/truncates the target.
.m4:
	$(do_m4) $< >$@ || $(do_cleanup)
	-chmod +x $@


# ----------
# REFERENCES
#
#  1. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/cd.html
#  2. https://docs.oracle.com/cd/E88353_01/html/E37839/m4-1.html
#  3. https://www.gnu.org/software/make/manual/html_node/Force-Targets
#  4. https://www.gnu.org/software/make/manual/html_node/Errors.html
