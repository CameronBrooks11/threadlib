# DIN 168 Glass Knuckle Threads (GL Series)

## Overview

DIN 168 specifies glass knuckle threads used for laboratory glassware connections. These threads feature an asymmetric profile optimized for glass equipment manufacturing and cleaning requirements.

## Thread Characteristics

- **Standard**: DIN 168 (German Industrial Standard)
- **Application**: Laboratory glassware, chemical apparatus
- **Material**: Primarily borosilicate glass
- **Thread Profile**: Asymmetric angles
  - **External thread**: 60° angle (standard metric profile)
  - **Internal thread**: 30° angle (shallow for easy cleaning)

## Technical Specifications

### Thread Angles

- **External (male)**: 60° included angle
- **Internal (female)**: 30° included angle
- **Asymmetric design**: Facilitates glass manufacturing and cleaning

### Size Range

- **Smallest**: GL 8 (8mm nominal diameter, 2.0mm pitch)
- **Largest**: GL 125 (125mm nominal diameter, 5.0mm pitch)
- **Total sizes**: 23 standard sizes

### Pitch Progression

- **GL 8-12**: 2.0mm pitch
- **GL 14-16**: 2.5mm pitch
- **GL 18-28**: 3.0mm pitch
- **GL 32-56**: 4.0mm pitch
- **GL 63-125**: 5.0mm pitch

## Designator Format

Thread designators follow the pattern: `GL {size}-{type}`

**Examples:**

- `GL 14-ext` - External GL 14 thread (male)
- `GL 25-int` - Internal GL 25 thread (female)

## Usage in threadlib

```openscad
use <threadlib/threadlib.scad>

// Create GL 14 external thread (male glass fitting)
thread("GL 14-ext", turns=8);

// Create GL 25 internal thread (female glass joint)
thread("GL 25-int", turns=6);

// Complete glass joint assembly
bolt("GL 18", turns=10);           // External with support
nut("GL 18", turns=8, Douter=22);  // Internal with housing

// Threaded hole for glass apparatus
difference() {
    cube([30, 30, 15]);
    translate([15, 15, 0])
        tap("GL 14", turns=12);
}
```

## Design Considerations

### Manufacturing

- **Glass-friendly**: Shallow internal threads reduce stress concentration
- **Cleaning**: 30° internal angle allows thorough cleaning of residues
- **Sealing**: Often used with O-rings or gaskets for vacuum applications

### Tolerances

- **Tighter than metal threads**: Glass requires precise fit
- **Temperature stability**: Borosilicate glass has low thermal expansion
- **Chemical resistance**: Compatible with most laboratory solvents

## Applications

- **Laboratory glassware**: Reaction vessels, condensers, distillation apparatus
- **Chemical processing**: Glass-lined equipment connections
- **Vacuum systems**: High-vacuum glass manifolds
- **Analytical instruments**: Glass sample holders and cells

## Compatibility

DIN 168 threads are **not interchangeable** with:

- ISO metric threads (different angles and tolerances)
- NPT or BSP pipe threads
- Other laboratory thread standards

Always verify thread compatibility before assembly to prevent damage to expensive glassware.

## Standards References

- **DIN 168**: Glasschliffe - Konische Schliffe und Kugel- und Zapfenschliffe
- **ISO 4797**: Laboratory glassware - Borosilicate glass tubing
- Related: DIN 12242 (Glass ground joints)

---

Added to threadlib v0.6 - Glass laboratory thread support
