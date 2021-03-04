include <../gravitrax.scad>
use <../gt_tower.scad>
use <../gt_spacer.scad>



//Tower(145, 10);
rotz(-60) P();

for (a=[-4, -3, -2, 1,2,3,4,5,6]) rotz(a*120) tz(60+a*10)
{
  tz(10) TileCS();
  P();
  tz(7.5) rotz(-60) Kurve(5);
}
tz(75) TileXX(); 
t(60,0,70) color("DimGrey") Spacer();
tz(60)  P();
tz(60) rotz(-60) P2();
tz(70) rotz(-60) tx(60) TileCC(240);
tz(72.5) t(d2_tile/2, -50) rotz(0) Kurve(5);
tz(65) rotz(0) t(d2_tile/2, -50) rotz(240) Kurve(10);

rotz(-120) {
  
tz(57.5) rotz(-60) Kurve(5);
tz(60) TileXX(); 
//t(60,0,60) color("DimGrey") Spacer();
tz(50)  P();
}
color("SteelBlue") import("../gt_tower/Tower_145_10.stl");


module TileCS() {
  tx(60) color("white") rotz(60) import("../gt_tiles/TileCurveSlope.stl");
  tx(60) color("white") tz(0.6) mz() import("../gt_tiles/Ring.stl"); 
}
module TileCC(a=0) {
  tx(60) color("white") rotz(a) import("../gt_tiles/TileCurves.stl");
  tx(60) color("white") tz(0.6) mz() import("../gt_tiles/Ring.stl"); 
}
module TileXX() {
  tx(60) color("white") rotz(60) import("../gt_tiles/TileX.stl");
  tx(60) color("white") tz(0.6) mz() import("../gt_tiles/Ring.stl"); 
}
  
  
  
module P() { color("DodgerBlue") t(60,0,5) import ("../gt_tower/PlatformMini.stl"); }
module P2() {color("DodgerBlue") t(60,0,5) import ("../gt_tower/Platform2.stl"); }
module Kurve(a=0) {
  color("SlateGrey") tx(60) rotx(a) rotz(60) t(-60) import("Kurve_2x60_Schraege_0deg.stl");
}
