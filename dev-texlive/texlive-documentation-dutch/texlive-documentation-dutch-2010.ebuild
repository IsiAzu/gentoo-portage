# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-dutch/texlive-documentation-dutch-2010.ebuild,v 1.2 2011/08/09 20:54:44 hwoarang Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="lshort-dutch collection-documentation-dutch
"
TEXLIVE_MODULE_DOC_CONTENTS="lshort-dutch.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Dutch documentation"

LICENSE="GPL-2 GPL-1 "
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2010
"
RDEPEND="${DEPEND} "
