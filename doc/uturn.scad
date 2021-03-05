include <../gravitrax.scad>
use <../gt_tower.scad>
use <../gt_tiles.scad>
use <../gt_stack.scad>
use <../gt_spacer.scad>


// Exit
t(120) rotz(-60) { TileC(); Stacks(10);}
ctz([0,140]) tx(120) rotz(-60) tx(60) Rail1();

for(z=[0,1,2]) tz(z*40) {
  t(-120) { UTurn();Stacks(30); }
  ctz([0,20]) Rail3();
  t(120,0,20) rotz(180) { UTurn();Stacks(30); }
}

tz(120) { tx(-120) UTurn(); ctz([0,20]) Rail3(); }
// Entry
t(120, 0, 140) rotz(-60) TileC(); 



module TileC()
{
  color("white") import("../gt_tiles/TileCurves.stl");
  color("white") tz(0.6) mz() import("../gt_tiles/Ring.stl");
}


module UTurn()
{
  color("PaleGreen") { import("../gt_tiles/TileUTurn.stl");
   tz(0.6) mz() import("../gt_tiles/Ring.stl"); }
}


module Rail1() { 
  color("SlateGrey") t(-36.5, -5, 4) rotx() 
    import("Rail_short-1_73mm_v2.stl");
}
module Rail3() { 
  color("SlateGrey") t(-36.5-60, -5, 4) rotx() 
  import("Rail_long-2_192mm_v3.stl");
}

module Stacks(h)
{
  color("Tomato") tz(5) for(a=[1,3,5]) rotz(a*60) ty(d2_tile/2) Stack(h, standing=1);
}