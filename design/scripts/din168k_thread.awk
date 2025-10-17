
# DIN 168K (Glass Knuckle Threads)
# External flank angle: 60°
# Internal flank angle: 30°
# Output: 4-point profile (11 params)
# Format: P,Rrot,Dsupport,r0,z0,r1,z1,r2,z2,r3,z3

function tan(x) { return (sin(x) / cos(x)) }

function parse_fields() {
	# CSV columns:
	# 1: NominalDiameter (e.g. "GL 8")
	# 2: Bolt_Major_max_mm
	# 3: Bolt_Major_min_mm
	# 4: Bolt_Minor_max_mm
	# 5: Bolt_Minor_min_mm
	# 6: Nut_Major_min_mm
	# 7: Nut_Major_max_mm
	# 8: Nut_Minor_min_mm
	# 9: Nut_Minor_max_mm
	# 10: Pitch_mm

	# Normalize "GL 8" → "GL8"
	gsub(/[^A-Za-z0-9]/, "", $1)
	Designator = $1

	P         = $10  # Pitch_mm
	DMajorExt = $2   # Bolt major (external crest)
	DMinorExt = $4   # Bolt minor (external root)
	DMajorInt = $7   # Nut major (internal crest)
	DMinorInt = $9   # Nut minor (internal root)
}

function calculateThreadlibSpecs() {
	# Angles
	phi_ext = 60 * deg
	phi_int = 30 * deg

	# Theoretical thread height (triangle model)
	H_ext = (P / 2) / tan(phi_ext / 2)
	H_int = (P / 2) / tan(phi_int / 2)

	# External thread
	DPitchExt   = (DMajorExt + DMinorExt) / 2
	RrotExt     =  DPitchExt / 2
	DSupportExt =  DMajorExt
	DrCrestExt  = (DMajorExt - DMinorExt) / 2
	ZCrestExt   =  H_ext / 8    # Slight crest rounding offset

	# Internal thread
	DPitchInt   = (DMajorInt + DMinorInt) / 2
	RrotInt     = -DPitchInt / 2   # Negative = inward (toward axis)
	DSupportInt =  DMajorInt
	DrCrestInt  = (DMajorInt - DMinorInt) / 2
	ZCrestInt   =  H_int / 8
}

function printExternalThreadSpecs() {
	printf "%.4f,%.4f,%.4f,", P, RrotExt, DSupportExt
	# Simple symmetric 4-point profile
	printf "0,%.4f,", -P/2        # r0,z0
	printf "0,%.4f,",  P/2        # r1,z1
	printf "%.4f,%.4f,", DrCrestExt,  ZCrestExt  # r2,z2
	printf "%.4f,%.4f\n", DrCrestExt, -ZCrestExt # r3,z3
}

function printInternalThreadSpecs() {
	printf "%.4f,%.4f,%.4f,", P, RrotInt, DSupportInt
	# Internal threads need positive radial coordinates to point inward
	printf "%.4f,%.4f,", DrCrestInt,  ZCrestInt   # r0,z0 (inward)
	printf "%.4f,%.4f,", DrCrestInt, -ZCrestInt   # r1,z1
	printf "0,%.4f,", -P/2                        # r2,z2
	printf "0,%.4f\n",  P/2                       # r3,z3
}

BEGIN {
	FS  = ","
	pi  = atan2(0, -1)
	deg = pi / 180
}

# Skip comment lines
/^#/ { next }

# Skip blank lines
/^$/ { next }

{
	parse_fields()

	if (Designator == "" || P == "" || DMajorExt == "" || DMinorExt == "" || DMajorInt == "" || DMinorInt == "")
		next

	calculateThreadlibSpecs()

	printf "%s-ext,", Designator
	printExternalThreadSpecs()

	printf "%s-int,", Designator
	printInternalThreadSpecs()
}

