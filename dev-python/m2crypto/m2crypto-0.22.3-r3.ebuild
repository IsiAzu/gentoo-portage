# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/m2crypto/m2crypto-0.22.3-r3.ebuild,v 1.4 2015/05/25 17:41:50 floppym Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

MY_PN="M2Crypto"

DESCRIPTION="M2Crypto: A Python crypto and SSL toolkit"
HOMEPAGE="https://github.com/martinpaljak/M2Crypto http://pypi.python.org/pypi/M2Crypto"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

# swig-3.0.5 results in broken constants, #538920
RDEPEND=">=dev-libs/openssl-0.9.8:0="
DEPEND="${RDEPEND}
	<dev-lang/swig-3.0.5
	>=dev-lang/swig-1.3.28:0
	dev-python/setuptools[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${MY_PN}-${PV}"

# Tests access network, and fail randomly. Bug #431458.
RESTRICT=test

python_prepare_all() {
	epatch "${FILESDIR}"/${P}-cross-compile.patch

	# use pre-swigged sources
	sed -i -e '/sources/s:\.i:_wrap.c:' setup.py || die

	distutils-r1_python_prepare_all
}

python_configure_all() {
	set -- swig -python -includeall -I"${EPREFIX}"/usr/include \
		-o SWIG/_m2crypto_wrap.c SWIG/_m2crypto.i

	echo "${@}"
	"${@}" || die 'swig failed'
}

python_test() {
	esetup.py test
}
