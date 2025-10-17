
use <thread_profile.scad>
include <THREAD_TABLE.scad>

function thread_specs(designator, table = THREAD_TABLE) =
  /* Returns thread specs of thread-type 'designator' as a vector of
       [pitch, Rrotation, Dsupport, section_profile] */

  // first lookup designator in table inside a let() statement:
  let (
    specs = table[search(
      [designator], table, num_returns_per_match=1,
      index_col_num=0
    )[0]][1]
  )
  // verify that we found something and return it:
  assert(!is_undef(specs), str("Designator: '", designator, "' not found")) specs;

module thread(designator, turns, higbee_arc = 20, fn = 120, table = THREAD_TABLE) {
  specs = thread_specs(designator, table=table);
  P = specs[0];
  Rrotation = specs[1];
  section_profile = specs[3];
  straight_thread(
    section_profile=section_profile,
    higbee_arc=higbee_arc,
    r=Rrotation,
    turns=turns,
    fn=fn,
    pitch=P
  );
}
