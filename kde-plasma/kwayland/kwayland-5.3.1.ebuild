# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-plasma/kwayland/kwayland-5.3.1.ebuild,v 1.1 2015/05/31 22:06:16 johu Exp $

EAPI=5

KDE_TEST="true"
inherit kde5

DESCRIPTION="Qt-style client and server library wrapper for Wayland libraries"
HOMEPAGE="https://projects.kde.org/projects/kde/workspace/kwayland"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-libs/wayland-1.3.0
	dev-qt/qtgui:5
	media-libs/mesa[egl]
"
RDEPEND="${DEPEND}
	!kde-base/kwayland
"

# All failing, i guess we need a virtual wayland server
RESTRICT="test"
