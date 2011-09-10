# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgresql-base/postgresql-base-8.2.21-r3.ebuild,v 1.2 2011/09/09 20:40:07 chainsaw Exp $

EAPI="4"

WANT_AUTOMAKE="none"

inherit autotools eutils multilib prefix versionator

SLOT="$(get_version_component_range 1-2)"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~sh ~sparc ~x86"

DESCRIPTION="PostgreSQL libraries and clients"
HOMEPAGE="http://www.postgresql.org/"
SRC_URI="mirror://postgresql/source/v${PV}/postgresql-${PV}.tar.bz2
		 http://dev.gentoo.org/~titanofold/postgresql-patches-${SLOT}-r1.tbz2"
LICENSE="POSTGRESQL"

S="${WORKDIR}/postgresql-${PV}"

# No tests to be done for clients and libraries
RESTRICT="test"

LINGUAS="af cs de en es fa fr hr hu it ko nb pl pt_BR ro ru sk sl sv tr zh_CN zh_TW"
IUSE="doc kerberos ldap nls pam pg-intdatetime readline ssl threads zlib"

for lingua in ${LINGUAS} ; do
	IUSE+=" linguas_${lingua}"
done

wanted_languages() {
	local enable_langs

	for lingua in ${LINGUAS} ; do
		use linguas_${lingua} && enable_langs+="${lingua} "
	done

	echo -n ${enable_langs}
}

RDEPEND=">=app-admin/eselect-postgresql-1.0.10
		 virtual/libintl
		 !!dev-db/libpq
		 !!dev-db/postgresql
		 !!dev-db/postgresql-client
		 !!dev-db/postgresql-libs
		 kerberos? ( virtual/krb5 )
		 ldap? ( net-nds/openldap )
		 pam? ( virtual/pam )
		 readline? ( >=sys-libs/readline-4.1 )
		 ssl? ( >=dev-libs/openssl-0.9.6-r1 )
		 zlib? ( >=sys-libs/zlib-1.1.3 )"

DEPEND="${RDEPEND}
		>=sys-apps/sandbox-2.0
		>=sys-devel/bison-1.875
		sys-devel/flex
		nls? ( sys-devel/gettext )"

PDEPEND="doc? ( ~dev-db/postgresql-docs-${PV} )"

src_prepare() {
	epatch "${WORKDIR}/autoconf.patch" "${WORKDIR}/base.patch" \
		"${WORKDIR}/bool.patch" "${WORKDIR}/darwin.patch" \
		"${WORKDIR}/relax_ssl_perms.patch" "${WORKDIR}/SuperH.patch"

	eprefixify src/include/pg_config_manual.h

	# to avoid collision - it only should be installed by server
	rm "${S}/src/backend/nls.mk"

	# because psql/help.c includes the file
	ln -s "${S}/src/include/libpq/pqsignal.h" "${S}/src/bin/psql/" || die

	eautoconf
}

src_configure() {
	export LDFLAGS_SL="${LDFLAGS}"
	local PO="${EPREFIX%/}"
	econf --prefix="${PO}/usr/$(get_libdir)/postgresql-${SLOT}" \
		--datadir="${PO}/usr/share/postgresql-${SLOT}" \
		--includedir="${PO}/usr/include/postgresql-${SLOT}" \
		--mandir="${PO}/usr/share/postgresql-${SLOT}/man" \
		--sysconfdir="${PO}/etc/postgresql-${SLOT}" \
		--without-docdir \
		--without-perl \
		--without-python \
		--without-tcl \
		$(use_with kerberos krb5) \
		$(use_with ldap) \
		"$(use_enable nls nls "$(wanted_languages)")" \
		$(use_with pam) \
		$(use_enable pg-intdatetime integer-datetimes ) \
		$(use_with readline) \
		$(use_with ssl openssl) \
		$(use_enable threads thread-safety) \
		$(use_with zlib)
}

src_compile() {
	emake

	cd "${S}/contrib"
	emake
}

src_install() {
	emake DESTDIR="${D}" install
	insinto /usr/include/postgresql-${SLOT}/postmaster
	doins "${S}"/src/include/postmaster/*.h

	rm "${ED}"/usr/share/postgresql-${SLOT}/man/man1/{initdb,ipcclean,pg_{controldata,ctl,resetxlog},post{gres,master}}.1
	docompress /usr/share/postgresql-${SLOT}/man/man{1,7}
	dodoc README HISTORY doc/{README.*,TODO,bug.template}

	cd "${S}/contrib"
	emake DESTDIR="${D}" install
	cd "${S}"

	dodir /etc/eselect/postgresql/slots/${SLOT}

	echo "postgres_ebuilds=\"\${postgres_ebuilds} ${PF}\"" \
		> "${ED}/etc/eselect/postgresql/slots/${SLOT}/base"

	keepdir /etc/postgresql-${SLOT}
}

pkg_postinst() {
	postgresql-config update

	elog "If you need a global psqlrc-file, you can place it in:"
	elog "    ${EROOT%/}/etc/postgresql-${SLOT}/"
}

pkg_postrm() {
	postgresql-config update
}
