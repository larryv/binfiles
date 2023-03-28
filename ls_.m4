changequote([, ])dnl
divert(1)dnl
dnl
dnl
dnl ls_.m4
dnl ------
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

# ls_ - Run ls(1) with default options
# ------------------------------------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2023 by Lawrence Velazquez <vq@larryv.me>.
#
undivert(1)dnl

dnl Determine which desired options are available.  Use -d to avoid
dnl wasting time listing directory contents.  (It's safe to assume -a
dnl and -d, which have been present since literally Version 1 Unix.)
ifdef([__LS__], [], [define([__LS__], [ls])])dnl
define([opts],
syscmd(defn([__LS__])[ -Ad >/dev/null 2>&1])ifelse(sysval, 0, [[A]], [[a]])dnl
syscmd(defn([__LS__])[ -Fd >/dev/null 2>&1])ifelse(sysval, 0, [[F]])dnl
syscmd(defn([__LS__])[ -hd >/dev/null 2>&1])ifelse(sysval, 0, [[h]])dnl
)dnl
ifelse(index(defn([opts]), [h]), -1, [],
# -------------------------------------
# Assumes GNU/BSD behavior for `ls -h`.
# -------------------------------------
)dnl

# Prevent ancient shells from inheriting a problematic IFS.
lf='
'
sp=' '
tab='	'
IFS=$sp$tab$lf

# Work around undesirable "$@" behavior in ancient shells.
case $# in
    0) exec defn([__LS__]) -defn([opts]) ;;
    *) exec defn([__LS__]) -defn([opts]) "$@" ;;
esac
