include <../gravitrax.scad>
use <../gt_tower.scad>
use <../gt_tiles.scad>
use <../gt_stack.scad>
use <../gt_spacer.scad>


// Unten
t(-60,0,0) color("DimGrey") Spacer(10);
t(0, d_tile*1.5, 0) rotz(120) { TileC(); Stacks(20);}

// Schichten
for (z=[0,30, 60]) tz(z)
{
  t(60,0,0) rotz(-60) { TileC(); rotz(-60) Stacks(20);}
  t(-60,0,10) rotz(240){ TileC(); if(z < 50) Stacks(20);}
  t(0, d_tile*1.5,20) rotz(120) { TileC(); if(z < 50) Stacks(20);}
  
   tz(5) RailUp();
   t(0, d_tile*1.5, 15) rotz(240) tx(d2_tile) RailUp();
  t(60,0, 25) rotz(120) tx(d2_tile) RailUp();
}

// Ende oben
t(60,0,90) rotz(120) TileC(); 
t(120, 0, 95) mx() RailUp();

// Ende unten
t(60) rotz(-60) tx(d2_tile) Rail();

module TileC()
{
  color("white") import("../gt_tiles/TileCurves.stl");
  color("white") tz(0.6) mz() import("../gt_tiles/Ring.stl");
}


module RailUp() { roty(10) t(-1) Rail(); }
module Rail() { 
  color("SlateGrey") t(-36.5, -5, 4) rotx() 
    import("Rail_short-1_73mm_v2.stl");
}

module Stacks(h)
{
  color("Tomato") tz(5) for(a=[1,3,5]) rotz(a*60) ty(d2_tile/2) Stack(h, standing=1);
}