# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-IniFiles/Config-IniFiles-2.860.0.ebuild,v 1.1 2015/05/01 20:22:44 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=SHLOMIF
MODULE_VERSION=2.86
inherit perl-module

DESCRIPTION="A module for reading .ini-style configuration files"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND="
	virtual/perl-Carp
	virtual/perl-File-Temp
	>=dev-perl/List-MoreUtils-0.330.0
"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.360.0
	virtual/perl-Scalar-List-Utils
	test? (
		virtual/perl-Test-Simple
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST="do"
