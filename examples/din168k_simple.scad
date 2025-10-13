// Test script for DIN 168K glass knuckle threads
// Tests both external and internal threads with various sizes

include <../threadlib.scad>

// Test parameters
$fn = 64;


// Test bolt and nut combination with GL18
translate([0, 0, 0]) {
    echo("Testing GL45 bolt...");
    bolt("GL45", turns=3, higbee_arc=45);
}

translate([60, 0, 0]) {
    echo("Testing GL45 nut...");
    nut("GL45", turns=3, Douter=50, higbee_arc=45);
}
