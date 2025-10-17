// Test script for DIN 168K glass knuckle threads
// Tests both external and internal threads with various sizes

include <../threadlib.scad>

// Test parameters
$fn = 64;

// Test small thread: GL8
translate([0, 0, 0]) {
  echo("Testing GL8 external thread...");
  thread("GL8-ext", turns=3, higbee_arc=45);
}

translate([20, 0, 0]) {
  echo("Testing GL8 internal thread...");
  thread("GL8-int", turns=3, higbee_arc=45);
}

// Test medium thread: GL25
translate([0, 30, 0]) {
  echo("Testing GL25 external thread...");
  thread("GL25-ext", turns=2, higbee_arc=45);
}

translate([30, 30, 0]) {
  echo("Testing GL25 internal thread...");
  thread("GL25-int", turns=2, higbee_arc=45);
}

// Test large thread: GL100
translate([0, 100, 0]) {
  echo("Testing GL100 external thread...");
  thread("GL100-ext", turns=1.5, higbee_arc=45);
}

translate([120, 100, 0]) {
  echo("Testing GL100 internal thread...");
  thread("GL100-int", turns=1.5, higbee_arc=45);
}

// Test bolt and nut combination with GL18
translate([0, -40, 0]) {
  echo("Testing GL18 bolt...");
  bolt("GL18", turns=3, higbee_arc=45);
}

translate([25, -40, 0]) {
  echo("Testing GL18 nut...");
  nut("GL18", turns=3, Douter=25);
}

// Test bolt and nut combination with GL18
translate([80, 30, 0]) {
  echo("Testing GL45 bolt...");
  bolt("GL45", turns=3, higbee_arc=45);
}

translate([80, -30, 0]) {
  echo("Testing GL45 nut...");
  nut("GL45", turns=3, Douter=50, higbee_arc=45);
}
