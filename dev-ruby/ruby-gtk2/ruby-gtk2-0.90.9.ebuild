# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtk2/ruby-gtk2-0.90.9.ebuild,v 1.1 2011/09/17 09:36:15 naota Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby Gtk2 bindings"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${DEPEND} x11-libs/gtk+:2"
RDEPEND="${RDEPEND} x11-libs/gtk+:2"

ruby_add_rdepend "dev-ruby/ruby-gdkpixbuf2
	>=dev-ruby/ruby-gio2-${PV}
	>=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-pango-${PV}
	>=dev-ruby/ruby-atk-${PV}"
