use <thread.scad>;

module nut(designator, turns, Douter, higbee_arc = 20, fn = 120, table = THREAD_TABLE, nut_sides = 0) {
  nut_sides = nut_sides == 0 ? fn : nut_sides;
  union() {
    specs = thread_specs(str(designator, "-int"), table=table);
    P = specs[0];
    Dsupport = specs[2];
    H = (turns + 1) * P;
    thread(str(designator, "-int"), turns=turns, higbee_arc=higbee_arc, fn=fn, table=table);

    translate([0, 0, -P / 2])
      difference() {
        cylinder(h=H, d=Douter, $fn=nut_sides);
        translate([0, 0, -0.1])
          cylinder(h=H + 0.2, d=Dsupport, $fn=fn);
      }
    ;
  }
  ;
}
;
