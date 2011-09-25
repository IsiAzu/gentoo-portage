# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/unoconv/unoconv-20110923.ebuild,v 1.1 2011/09/23 13:24:55 scarabeus Exp $

EAPI=3

PYTHON_DEPEND="2"
EGIT_REPO_URI="https://github.com/dagwieers/unoconv.git"
[[ ${PV} == 9999* ]] && SCM_ECLASS="git-2"
inherit eutils python ${SCM_ECLASS}
unset SCM_ECLASS

DESCRIPTION="Convert between document formats supported by Libreoffice"
HOMEPAGE="http://dag.wieers.com/home-made/unoconv/"
[[ ${PV} == 9999* ]] || SRC_URI="http://dev.gentooexperimental.org/~scarabeus/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
[[ ${PV} == 9999* ]] || KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${DEPEND}
	virtual/ooo
"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}/timeout.patch"
	python_convert_shebangs -r 2 .
}

src_compile() { :; }

src_install() {
	emake docs-install install install-links DESTDIR="${D}" || die
}
