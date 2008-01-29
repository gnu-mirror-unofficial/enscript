#
# Automakefile for the library files.
# Copyright (c) 1995-1998 Markku Rossi
#
# Author: Markku Rossi <mtr@iki.fi>
#

#
# This file is part of GNU enscript.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; see the file COPYING.  If not, write to
# the Free Software Foundation, 51 Franklin Street, Fifth Floor,
# Boston, MA 02110-1301, USA.
#

pkgdata_DATA = ascii.enc asciifise.enc asciidkno.enc hp8.enc ibmpc.enc	\
koi8.enc 88591.enc 88592.enc 88593.enc 88594.enc 88595.enc 88597.enc	\
88599.enc 885910.enc mac.enc ps.enc pslatin1.enc vms.enc a2ps.hdr	\
edd.hdr emacs.hdr enscript.hdr enscript-color.hdr frame.hdr mp.hdr	\
simple.hdr squeeze.hdr enscript.pro

EXTRA_DIST = enscript.cfg.in $(pkgdata_DATA) Makefile-encodings \
make-encoding.pl

CLEANFILES = enscript.cfg

all-local: enscript.cfg

install-data-local: enscript.cfg
	$(top_srcdir)/mkinstalldirs $(DESTDIR)$(sysconfdir)
	if test -r $(DESTDIR)$(sysconfdir)/enscript.cfg; then \
	  cp $(DESTDIR)$(sysconfdir)/enscript.cfg \
	     $(DESTDIR)$(sysconfdir)/enscript.cfg.old; \
	else :; \
	fi
	$(INSTALL_DATA) enscript.cfg $(DESTDIR)$(sysconfdir)/enscript.cfg

uninstall-local:
	rm -f $(DESTDIR)$(sysconfdir)/enscript.cfg

enscript.cfg: $(srcdir)/enscript.cfg.in Makefile
	sed 's%@DATADIR@%$(datadir)%g; s%@media@%@MEDIA@%g; s%@BINDIR@%$(bindir)%g; s%@spooler@%@SPOOLER@%g; s%@pslevel@%@PSLEVEL@%g' \
	$(srcdir)/enscript.cfg.in >enscript.cfg
