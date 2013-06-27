# Runs systemctl commands on the units in the SYSTEMD_UNITS_ENABLE,
# SYSTEMD_UNITS_DISABLE, and SYSTEMD_UNITS_MASK variables. This bbclass
# is intended to be inherited by image generation recipes.

SYSTEMD_UNITS_ENABLE ??= ""
SYSTEMD_UNITS_DISABLE ??= ""
SYSTEMD_UNITS_MASK ??= ""

run_systemctl_commands() {
if type systemctl >/dev/null 2>/dev/null; then
	for unit in ${SYSTEMD_UNITS_ENABLE}; do
		systemctl --root=${IMAGE_ROOTFS} enable ${unit} && continue
		echo "WARNING: Could not enable unit ${unit}"
	done
	for unit in ${SYSTEMD_UNITS_DISABLE}; do
		systemctl --root=${IMAGE_ROOTFS} disable ${unit} && continue
		echo "WARNING: Could not disable unit ${unit}"
	done
	for unit in ${SYSTEMD_UNITS_MASK}; do
		systemctl --root=${IMAGE_ROOTFS} mask ${unit} && continue
		echo "WARNING: Could not mask unit ${unit}"
	done
fi
}

ROOTFS_POSTPROCESS_COMMAND += "run_systemctl_commands; "
