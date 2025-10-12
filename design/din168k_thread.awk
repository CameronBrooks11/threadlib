# DIN 168K (Glass Knuckle Threads)
# External flank angle: 60°
# Internal flank angle: 30°
# 4-point profile (11 params): P,Rrot,Dsupport,r0,z0,r1,z1,r2,z2,r3,z3

function tan(x) { return (sin(x) / cos(x)) }

function parse_fields() {
	# Determine whether designator is split ("GL 8") or merged ("GL8")
	base = 2
	if ($2 == "GL" && $3 ~ /^[0-9]+$/) {
		Designator = $2 $3
		idx = 4
	} else {
		Designator = $2
		idx = 3
	}

	Size      = $1
	P         = $(idx + 0)
	DMajorExt = $(idx + 1)
	DMinorExt = $(idx + 2)
	DMajorInt = $(idx + 3)
	DMinorInt = $(idx + 4)
}

function calculateThreadlibSpecs() {
	# Thread flank angles
	phi_ext = 60 * deg
	phi_int = 30 * deg

	# Heights of theoretical thread triangles
	H_ext = (P / 2) / tan(phi_ext / 2)
	H_int = (P / 2) / tan(phi_int / 2)

	# External thread geometry
	DPitchExt   = (DMajorExt + DMinorExt) / 2
	RrotExt     = DPitchExt / 2
	DSupportExt = DMajorExt
	ZCrestExt   = H_ext / 8
	DrCrestExt  = (DMajorExt - DMinorExt) / 2

	# Internal thread geometry
	DPitchInt   = (DMajorInt + DMinorInt) / 2
	RrotInt     = -DPitchInt / 2
	DSupportInt = DMajorInt
	ZCrestInt   = H_int / 8
	DrCrestInt  = (DMajorInt - DMinorInt) / 2
}

function printExternalThreadSpecs() {
	printf "%.4f,%.4f,%.4f,", P, RrotExt, DSupportExt
	printf "0,%.4f,", -P/2
	printf "0,%.4f,",  P/2
	printf "%.4f,%.4f,", DrCrestExt,  ZCrestExt
	printf "%.4f,%.4f\n", DrCrestExt, -ZCrestExt
}

function printInternalThreadSpecs() {
	printf "%.4f,%.4f,%.4f,", P, RrotInt, DSupportInt
	printf "0,%.4f,", -P/2
	printf "0,%.4f,",  P/2
	printf "%.4f,%.4f,", -DrCrestInt,  ZCrestInt
	printf "%.4f,%.4f\n", -DrCrestInt, -ZCrestInt
}

BEGIN {
	# Support commas, spaces, or tabs
	FS  = "[, \t]+"
	pi  = atan2(0, -1)
	deg = pi / 180
}

# Ignore comments, headers, blanks
/^#/ { next }
$1 !~ /^[0-9]/ { next }

{
	parse_fields()

	# Ensure we have enough fields for whichever layout
	if (Designator == "" || P == "" || DMajorExt == "" || DMinorExt == "" || DMajorInt == "" || DMinorInt == "")
		next

	calculateThreadlibSpecs()

	printf "%s-ext,", Designator
	printExternalThreadSpecs()

	printf "%s-int,", Designator
	printInternalThreadSpecs()
}
