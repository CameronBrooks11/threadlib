# Getting Started with threadlib

This guide will get you up and running with threadlib in minutes.

## What is threadlib?

threadlib is an OpenSCAD library that makes creating accurate threads simple. Instead of manually calculating thread specifications, you just specify the thread designation (like "M8x1.25") and threadlib handles all the complex geometry.

## Installation

### Step 1: Install Prerequisites

threadlib requires two additional OpenSCAD libraries. Download and place these in your OpenSCAD library folder:

1. **[scad-utils](https://github.com/openscad/scad-utils)** - Utility functions
2. **[list-comprehension](https://github.com/openscad/list-comprehension-demos)** - List processing

### Step 2: Find Your Library Folder

OpenSCAD library locations by operating system:

- **Linux**: `~/.local/share/OpenSCAD/libraries/`
- **macOS**: `~/Documents/OpenSCAD/libraries/`
- **Windows**: `%USERPROFILE%\Documents\OpenSCAD\libraries\`

You can also check in OpenSCAD: **Help** → **Library Info**

### Step 3: Install threadlib

Clone or download threadlib into a `threadlib` folder in your libraries directory:

```bash
cd /path/to/your/libraries/folder
git clone https://github.com/adrianschlatter/threadlib.git
```

Or download the ZIP and extract it to your libraries folder.

### Step 4: Verify Installation

Your libraries folder should look like this:

```text
libraries/
├── list-comprehension-demos/
├── scad-utils/
├── thread_profile.scad
└── threadlib/
    ├── threadlib.scad
    ├── THREAD_TABLE.scad
    └── docs/
```

## Your First Thread

Create a new OpenSCAD file and try this:

```openscad
use <threadlib/threadlib.scad>

// Create a simple M8 external thread
thread("M8x1.25-ext", turns=10);
```

Press F5 to preview. You should see a beautiful threaded rod!

## Understanding Thread Designators

threadlib uses standard thread designations:

### Metric Threads

- Format: `M{diameter}x{pitch}-{type}`
- Examples: `M8x1.25-ext`, `M12x1.75-int`
- Common sizes: M3, M4, M5, M6, M8, M10, M12, M16, M20

### Imperial/Unified Threads

- Format: `#{size}-{TPI}` or `{diameter}-{TPI}`
- Examples: `#4-40`, `#6-32`, `1/4-20`, `1/2-13`
- TPI = Threads Per Inch

### BSP Pipe Threads

- Format: `G{size}-{type}`
- Examples: `G1/4-ext`, `G1/2-int`, `G3/4-ext`

### Thread Types

- `-ext`: External threads (male, screws, bolts)
- `-int`: Internal threads (female, nuts, tapped holes)

## Basic Functions

### `thread()` - Pure Thread Geometry

Creates just the thread profile without support structure:

```openscad
use <threadlib/threadlib.scad>

// External thread
thread("M8x1.25-ext", turns=8);

// Internal thread
thread("M8x1.25-int", turns=8);
```

### `bolt()` - Complete Bolt

Creates an external thread with cylindrical support:

```openscad
use <threadlib/threadlib.scad>

bolt("M8x1.25", turns=12, higbee_arc=30);
```

### `nut()` - Complete Nut

Creates an internal thread with hexagonal or round outer body:

```openscad
use <threadlib/threadlib.scad>

// Round nut
nut("M8x1.25", turns=8, Douter=13);

// Hex nut (6 sides)
nut("M8x1.25", turns=8, Douter=13, nut_sides=6);
```

### `tap()` - Threaded Hole Cutter

Creates a tool for cutting threaded holes via `difference()`:

```openscad
use <threadlib/threadlib.scad>

difference() {
    cube([20, 20, 10]);
    translate([10, 10, 0])
        tap("M6x1", turns=8);
}
```

## Key Parameters

### `turns`

Number of complete thread rotations:

```openscad
thread("M8x1.25-ext", turns=5);   // Short thread
thread("M8x1.25-ext", turns=15);  // Long thread
```

### `higbee_arc`

Lead-in/lead-out taper angle in degrees (0-90):

```openscad
thread("M8x1.25-ext", turns=8, higbee_arc=0);   // No taper
thread("M8x1.25-ext", turns=8, higbee_arc=30);  // Moderate taper
thread("M8x1.25-ext", turns=8, higbee_arc=45);  // Steep taper
```

### `fn`

Thread resolution (facets per revolution):

```openscad
thread("M8x1.25-ext", turns=8, fn=60);   // Coarse (faster)
thread("M8x1.25-ext", turns=8, fn=120);  // Standard
thread("M8x1.25-ext", turns=8, fn=180);  // Fine (slower)
```

## Common Patterns

### Matching Male/Female Threads

```openscad
use <threadlib/threadlib.scad>

// Male part
translate([0, 0, 0])
    bolt("M8x1.25", turns=8);

// Female part
translate([20, 0, 0])
    nut("M8x1.25", turns=8, Douter=15, nut_sides=6);
```

### Threaded Assembly

```openscad
use <threadlib/threadlib.scad>

module threaded_coupling() {
    difference() {
        union() {
            // Main body
            cylinder(h=20, d=25);

            // External threads on one end
            translate([0, 0, 15])
                thread("M16x2-ext", turns=3);
        }

        // Internal threads on other end
        translate([0, 0, -1])
            tap("M12x1.75", turns=8);
    }
}

threaded_coupling();
```

### Custom Thread Specifications

You can get thread specifications and use them for custom designs:

```openscad
use <threadlib/threadlib.scad>

// Get thread specs
specs = thread_specs("M8x1.25-ext");
pitch = specs[0];
radius = specs[1];
support_diameter = specs[2];
profile = specs[3];

echo("M8x1.25 pitch:", pitch);
echo("Support diameter:", support_diameter);

// Use in custom geometry
cylinder(h=pitch * 10, d=support_diameter);
```

## Tips for Success

### 1. Units Matter

threadlib works in **millimeters**. Scale your output if using different units:

```openscad
scale([25.4, 25.4, 25.4])  // Convert to inches
    bolt("M8x1.25", turns=8);
```

### 2. Printing Considerations

For 3D printing, consider these settings:

```openscad
// Slightly looser fit for printing
thread("M8x1.25-ext", turns=8, higbee_arc=30, fn=120);

// For internal threads, you might need to scale slightly
scale([1.02, 1.02, 1.0])  // 2% larger for clearance
    thread("M8x1.25-int", turns=8);
```

### 3. Performance

Higher `fn` values create smoother threads but take longer to render:

- `fn=60`: Fast preview
- `fn=120`: Good quality (default)
- `fn=180`: High quality for final renders

### 4. Lead-in Tapers

Always use lead-in tapers (`higbee_arc`) for real-world threads:

```openscad
// Good: Easy to start threading
bolt("M8x1.25", turns=8, higbee_arc=30);

// Avoid: Hard to start, may cross-thread
bolt("M8x1.25", turns=8, higbee_arc=0);
```

## Troubleshooting

### "Designator not found" Error

Check that your thread designation is supported and properly formatted:

```openscad
// Correct format
specs = thread_specs("M8x1.25-ext");

// Common mistakes
// specs = thread_specs("M8x1.25");      // Missing -ext or -int  
// specs = thread_specs("M8-ext");       // Missing pitch
// specs = thread_specs("m8x1.25-ext");  // Wrong case
```

For supported threads, check the THREAD_TABLE.scad file or the threadlib documentation.

### Threads Don't Fit

1. Check that you're using matching male (`-ext`) and female (`-int`) threads
2. For 3D printing, internal threads may need slight scaling
3. Verify your printer's dimensional accuracy

### Poor Thread Quality

1. Increase `fn` parameter: `thread("M8x1.25-ext", turns=8, fn=180)`
2. Check your 3D printer's resolution capabilities
3. Consider post-processing (tapping, threading)

### Performance Issues

Large or complex threads can be slow to render:

1. Lower `fn` for preview: `fn=60`
2. Reduce `turns` count during development  
3. Use `bolt()` instead of `thread()` + `cylinder()` for better performance
4. Consider using `$preview` to adjust quality automatically

## Getting Help

For questions and issues:

- **[GitHub Issues](https://github.com/adrianschlatter/threadlib/issues)** - Bug reports and feature requests
- **[OpenSCAD Forum](https://forum.openscad.org/)** - Community support and discussions

Welcome to the threadlib community! 🧵
