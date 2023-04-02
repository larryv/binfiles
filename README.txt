binfiles
========

These are some utilities that are too tiny to have their own home.

grep_
    Runs `grep --color=auto`, passing along any given arguments.

ls_
    Runs `ls -AFh`, passing along any given arguments.  If `-A` is not
    recognized, then `-a` is used instead; other unrecognized options
    are omitted without replacement.  (Option support is tested at build
    time.)


Requirements
------------

-   A Bourne [1] or POSIX(-ish) [2] shell.  The shells I have at hand
    are bash [3], dash [4], ksh93 [5], mksh [6], yash [7], and zsh [8];
    other shells are supported on a best-effort basis.  (NB: zsh must be
    used in ksh or sh compatibility mode [9].)

-   A typical Unix(-like) toolset, including:

    -   grep(1) with `--color=auto`

    -   m4(1) [10] (for build only)

    -   make(1) [11] (for build only)

-   ShellCheck [12] (for `make check` only)


Installation and uninstallation
-------------------------------

Run these commands from the directory containing the makefile [13].
(Using `make -C` is fine.)  If necessary, acquire privileges with
sudo(1) [14], doas(1) [15], etc.

-   To install under `/usr/local` (the default) or some other path:

        make install

        make prefix=/some/other/path install

-   To uninstall from `/usr/local` (the default) or some other path:

        make uninstall

        make prefix=/some/other/path uninstall

-   To run basic tests:

        make check

-   To clean up:

        make clean

The following make(1) macros are available for modifying the build
process (as demonstrated above with `prefix`).  Refer to the makefile
for their default values.

-   `bindir` [16], `DESTDIR` [17], `exec_prefix` [16], and `prefix` [16]
    are installation directories.

-   `GREP` is the grep(1) command hard-coded into grep_.

-   `LS` is the ls(1) command hard-coded into ls_.

-   `SHELL` is the shell invoked by make(1) and hard-coded into the
    shebangs of shell scripts.

-   `INSTALL` [18], `INSTALL_PROGRAM` [18], `M4` (with `M4FLAGS`) and
    `SHELLCHECK` (with `SHELLCHECKFLAGS`) are commands invoked by the
    build process.


Legal
-----

Unless otherwise noted, this work is published from the United States of
America using the CC0 1.0 Universal Public Domain Dedication [19].


References
----------

 1. https://www.in-ulm.de/~mascheck/bourne
 2. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html
 3. https://www.gnu.org/software/bash
 4. http://gondor.apana.org.au/~herbert/dash
 5. http://www.kornshell.org
 6. http://mirbsd.de/mksh
 7. https://yash.osdn.jp
 8. https://zsh.sourceforge.io
 9. https://zsh.sourceforge.io/Doc/Release/Invocation.html#Compatibility
10. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/m4.html
11. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/make.html
12. https://www.shellcheck.net
13. https://github.com/larryv/binfiles/blob/main/Makefile
14. https://www.sudo.ws
15. https://man.openbsd.org/doas
16. https://www.gnu.org/software/make/manual/html_node/Directory-Variables.html
17. https://www.gnu.org/software/make/manual/html_node/DESTDIR.html
18. https://www.gnu.org/software/make/manual/html_node/Command-Variables.html
19. https://creativecommons.org/publicdomain/zero/1.0


SPDX-License-Identifier: CC0-1.0

Written in 2023 by Lawrence Velazquez <vq@larryv.me>.
