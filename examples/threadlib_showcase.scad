use <../threadlib.scad>

module place(n, m, dim = 30) {
  translate([dim * n, dim * m, 0])
    children();
}

place(0, 0)
  thread("G1/2-ext", turns=10);

place(1, 0)
  bolt("M4", turns=5, higbee_arc=30);

place(2, 0)
  nut("M12x0.5", turns=10, Douter=16);

place(0, 1)
  tap("G1/2", turns=5);

place(1, 1)
  difference() {
    part_to_be_tapped_here();
    tap("G1/2", turns=5);
  }

module part_to_be_tapped_here() {
  translate([0, 0, 9 / 2])
    cube([30, 30, 9], center=true);
}

place(2, 1)
  thread("G1/2-ext", turns=5);

specs = thread_specs("G1/2-ext");
P = specs[0];
Rrot = specs[1];
Dsupport = specs[2];
section_profile = specs[3];
H = (5 + 1) * P;

place(0, 2){
  translate([0, 0, -P / 2])
    cylinder(h=H, d=Dsupport, $fn=120);
    thread( "G1/2-ext", turns=5);
    }

/*
MY_THREAD_TABLE = [
                   ["special", [pitch, Rrot, Dsupport,
                   [[r0, z0], [r1, z1], ..., [rn, zn]]]]
                   ];

thread("special", turns=15, table=MY_THREAD_TABLE);
*/

MY_THREAD_TABLE = [
  [
    "custom1",
    [
      2,
      10,
      22,
      [
        [0, 0],
        [1.5, 0.75],
        [1.5, 1.5],
        [0, 2]
      ],
    ],
  ],
  [
    "custom2",
    [
      3,
      12,
      26,
      [
        [1, 0],
        [2, 0.5],
        [2, 1.5],
        [1.5, 2],
        [1, 3]
      ],
    ],
  ],
];

place(1, 2)
  thread("custom1", turns=15, table=MY_THREAD_TABLE);

place(2, 2)
  thread("custom2", turns=10, table=MY_THREAD_TABLE);
