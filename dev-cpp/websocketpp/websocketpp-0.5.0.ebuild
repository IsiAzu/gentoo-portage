# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/websocketpp/websocketpp-0.5.0.ebuild,v 1.1 2015/02/17 20:09:11 johu Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="C++/Boost Asio based websocket client/server library"
HOMEPAGE="http://www.zaphoyd.com/websocketpp"
SRC_URI="https://github.com/zaphoyd/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="BSD"
SLOT="0"
IUSE="boost test"

DEPEMD=""
RDEPEND="${DEPEND}
	boost? ( dev-libs/boost )
"

# tests no-op
RESTRICT="test"

src_configure() {
	# Disable EXAMPLES as compilation is broken upstream
	local mycmakeargs=(
		-DEXAMPLES=OFF
		$(cmake-utils_use_enable !boost CPP11)
		$(cmake-utils_use_enable test TESTS)
	)

	cmake-utils_src_configure
}
