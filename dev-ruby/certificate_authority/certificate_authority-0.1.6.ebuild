# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/certificate_authority/certificate_authority-0.1.6.ebuild,v 1.2 2015/06/01 05:59:54 jer Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Managing the core functions outlined in RFC-3280 for PKI"
HOMEPAGE="https://github.com/cchandler/certificate_authority"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/activemodel-3.0.6:*"

all_ruby_prepare() {
	# Avoid dependency on dev-libs/engine_pkcs11 that will be hard to
	# make work on different arches due to hardwired load paths in
	# specs.
	rm -f spec/units/pkcs11_key_material_spec.rb || die
}
