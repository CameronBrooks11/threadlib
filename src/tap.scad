use <thread.scad>;

module tap(designator, turns, higbee_arc = 20, fn = 120, table = THREAD_TABLE) {
  difference() {
    specs = thread_specs(str(designator, "-int"), table=table);
    P = specs[0];
    Dsupport = specs[2];
    H = (turns + 1) * P;

    translate([0, 0, -P / 2]) {
      cylinder(h=H, d=Dsupport, $fn=fn);
    }
    ;

    thread(str(designator, "-int"), turns=turns, higbee_arc=higbee_arc, fn=fn, table=table);
  }
  ;
}
