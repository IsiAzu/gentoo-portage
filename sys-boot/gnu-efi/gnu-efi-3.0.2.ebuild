# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/gnu-efi/gnu-efi-3.0.2.ebuild,v 1.1 2015/04/13 05:50:47 vapier Exp $

EAPI=5

inherit multilib

DESCRIPTION="Library for build EFI Applications"
HOMEPAGE="http://developer.intel.com/technology/efi"
SRC_URI="mirror://sourceforge/gnu-efi/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~arm64 ~ia64 ~x86"
IUSE=""

DEPEND="sys-apps/pciutils"
RDEPEND=""

# These objects get run early boot (i.e. not inside of Linux),
# so doing these QA checks on them doesn't make sense.
QA_EXECSTACK="usr/*/lib*efi.a:* usr/*/crt*.o"

_emake() {
	emake \
		prefix=${CHOST}- \
		ARCH=${iarch} \
		PREFIX="${EPREFIX}/usr" \
		LIBDIR='$(PREFIX)/'"$(get_libdir)" \
		"$@"
}

src_compile() {
	case ${ARCH} in
		ia64)  iarch=ia64 ;;
		x86)   iarch=ia32 ;;
		amd64) iarch=x86_64 ;;
		*)     die "unknown architecture: $ARCH" ;;
	esac
	# The lib subdir uses unsafe archive targets, and
	# the apps subdir needs gnuefi subdir
	_emake -j1
}

src_install() {
	_emake install PREFIX=/usr INSTALLROOT="${D}"
	dodoc README* ChangeLog
}
