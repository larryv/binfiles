changequote([, ])dnl
divert(1)dnl
dnl
dnl
dnl grep_.m4
dnl --------
dnl
dnl SPDX-License-Identifier: CC0-1.0
dnl
dnl Written in 2023 by Lawrence Velazquez <vq@larryv.me>.
dnl
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide.  This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software.  If not, see
# <https://creativecommons.org/publicdomain/zero/1.0/>.
dnl
dnl
divert[]dnl
[#]!ifdef([__SHELL__], [defn([__SHELL__])], [[/bin/sh]]) -

# grep_ - Run grep(1) with color output
# -------------------------------------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2023 by Lawrence Velazquez <vq@larryv.me>.
#
undivert(1)dnl

# -------------------------------------------------------------------
# Requires a grep(1) implementation that recognizes "--color=auto",
# obviously.  I previously used the GREP_OPTIONS environment variable
# for this, but GNU grep 3.6 stopped supporting it, and I don't think
# BSD grep ever did (although Mac OS's modified version does).
# -------------------------------------------------------------------

# Prevent ancient shells from inheriting a problematic IFS.
lf='
'
sp=' '
tab='	'
IFS=$sp$tab$lf

# Work around undesirable "$@" behavior in ancient shells.
case $# in
    0) exec grep --color=auto ;;
    *) exec grep --color=auto "$@" ;;
esac
