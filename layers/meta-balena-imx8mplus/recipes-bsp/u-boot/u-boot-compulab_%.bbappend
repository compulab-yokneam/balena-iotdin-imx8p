FILESEXTRAPATHS:prepend := "${THISDIR}/patches:"

UBOOT_KCONFIG_SUPPORT = "1"
inherit resin-u-boot
DEPENDS += "bison-native gnutls-native"

BALENA_DEVICE_FDT_ADDR_VAR ?= "balena_fdt_addr_r"

# BALENA_STAGE2 = "balena_stage2"
# UBOOT_VARS += "BALENA_STAGE2"

SRC_URI:append = " \
	file://balena.cfg \
	file://20000-balena-Use-pylibfdt-setup.py-from-2021.04.patch \
	file://20002-balena-Disable-BINMAN.patch \
	file://30000-compulab-config-Add-Balena-boot-environment.patch \
	file://50000-env-mmc-Fix-build-issue.patch \
	file://50001-configs-compulab-imx8m-plus-Add-BALENA-resin-enviro.patch \
"

# To use do_configure() provided by poky/meta/recipes-bsp/u-boot/u-boot-configure.inc
# just make the merge_config.sh issue w/out the full path
do_configure:prepend () {
    export PATH=${PATH}:${S}/scripts/kconfig/
}

do_unpack[nostamp]="1"
do_patch[nostamp]="1"
do_configure[nostamp] = "1"
do_compile[nostamp] = "1"
