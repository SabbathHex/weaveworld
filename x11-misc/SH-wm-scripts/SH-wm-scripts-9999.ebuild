# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="This is a collection of scripts to be used with tmux, i3-gaps and i3blocks."
HOMEPAGE="https://github.com/SabbathHex/wm-scripts"
SRC_URI=""
EGIT_REPO_URI="https://github.com/SabbathHex/wm-scripts"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="libvirt sensors pulsemixer pavucontrol headsetcontrol j4 maim shortcuts"

# It is not strictly necessary to use i3blocks with this package, so it's not in the DEPEND
DEPEND="
libvirt? ( app-emulation/libvirt )
sensors? ( sys-apps/lm-sensors )
pulsemixer? ( media-sound/pulsemixer )
pavucontrol? ( media-sound/pavucontrol )
headsetcontrol? ( app-misc/headsetcontrol )
j4? ( x11-misc/j4-dmenu-desktop )
maim? ( media-gfx/maim )
shortcuts? ( x11-misc/xvkbd )
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install () {
	base_dir="usr/libexec/SH-wm-scripts"
	dodir "${base_dir}"
	for _dir in "i3blocks" "i3-helpers" "tmux"; do
		dodir "${base_dir}/${_dir}"
		exeinto "${base_dir}/${_dir}"
		for file in $(ls ${_dir}/); do
			doexe "${_dir}/$file"
		done
	done
}

pkg_postinst () {
	einfo "If using with i3blocks, the scripts are available at /usr/libexec/SH-wm-scripts/i3blocks"
	einfo "You can provide the path to these scripts by setting "
	einfo "command=/usr/libexec/SH-wm-scripts/i3blocks/\$BLOCK_NAME"
}