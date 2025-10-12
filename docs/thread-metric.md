# Metric Threads (ISO 262)

![Metric thread specifications](https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/ISO_and_UTS_Thread_Dimensions.svg/2560px-ISO_and_UTS_Thread_Dimensions.svg.png)

This document explains how threadlib handles metric thread specifications according to ISO 262.

## Implementation Details

The `metric_thread.csv` file provides thread dimensions directly from the ISO standard. The `metric_thread.awk` script calculates the threadlib-specific parameters from these standard dimensions.

### Parameter Selection

- **Designator**: Uses simplified notation (e.g., `M8x1.25-ext`)
- **Pitch diameters**: Center of tolerance range for optimal fit
- **Support diameters**: Center of tolerance range  
- **Valley diameter**: Border of tolerance range to ensure proper overlap with support
- **Crest diameters**: Center of tolerance range

## Specialties

For some internal threads, we get a valley diameter that is on the corner or even outside the fundamental triangle. This would lead to one turn of the thread overlapping with the next turn which we need to avoid. Therefore, we have a built-in check to limit the valley diameter to a safe range.
