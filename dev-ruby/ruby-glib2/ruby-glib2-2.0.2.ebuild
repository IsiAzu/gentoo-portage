# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-glib2/ruby-glib2-2.0.2.ebuild,v 1.1 2013/12/05 10:18:29 naota Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby Glib2 bindings"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
RDEPEND="${RDEPEND} >=dev-libs/glib-2"
DEPEND="${DEPEND}
	>=dev-libs/glib-2"

each_ruby_configure() {
	${RUBY} extconf.rb || die "extconf.rb failed"
}
