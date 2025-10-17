use <../src/thread_profile.scad>;

function demo_thread_profile() =
  [
    [0, 0],
    [1.5, 1],
    [1.5, 1],
    [0, 3],
    [-1, 3],
    [-1, 0],
  ];

// demo: 
straight_thread(section_profile=demo_thread_profile());
