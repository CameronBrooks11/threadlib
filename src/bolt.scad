use <thread.scad>;

module bolt(designator, turns, higbee_arc = 20, fn = 120, table = THREAD_TABLE) {
  union() {
    specs = thread_specs(str(designator, "-ext"), table=table);
    P = specs[0];
    Dsupport = specs[2];
    H = (turns + 1) * P;
    thread(str(designator, "-ext"), turns=turns, higbee_arc=higbee_arc, fn=fn, table=table);
    translate([0, 0, -P / 2])
      cylinder(h=H, d=Dsupport, $fn=fn);
  }
  ;
}
;
