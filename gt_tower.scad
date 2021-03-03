include <gravitrax.scad>
use <gt_spacer.scad>

PART() Tower(145, 10);
PART(-200) Tower(140, 20);
PART(-100) Tower(65, 10);

rotz(240)
PART(60, 0, 45) Platform();
rotz(240) 
PART(60, 0, 75) PlatformMini();
rotz(240) 
PART(60, 0, 15) Platform2();
rotz(300) 
PART(60, 0, 15) PlatformY();


module PlatformMini()
{
  tz(2) Spacer(3, 0); 
  PlatformHaken(h=3);
}

module Platform2(stubs=1)
{
  Spacer(5, stubs);
  tx(60) Spacer(5, stubs);
  PlatformHaken();
  tx(30) cubexy([25, 30, 5]);
}
module PlatformY(stubs=1)
{
  PlatformHaken();
  Spacer(5, stubs);
  cmy() rotz(60) tx(60) Spacer(5, stubs);
  cmy() rotz(60) tx(30) cubexy([25, 30, 5]);
}

module Platform(stubs=1)
{
  Spacer(5, stubs);
  PlatformHaken();
}

module PlatformHaken(h=5)
{
  diff() 
  { 
    union()
    {
      t(-60+d2_stubs/2+3, -7) mx() hull() {
        tz(3) cube_round([6.6, 14, 2], 3); cube([3.5, 14, 2]); 
      } 
      hull()
        { 
          t(-60+d2_stubs/2-.2, -7) cube([.1, 14, 5]); 
          b = d_tile/2;
          t(-60+d2_tile/2+2, -b/2) cube([1, b, 5]); 
          t(-12, -b/2, 5-h) cube([1, b, h]); 
        }
      }
      tz(-1) le(7) hex(d_stubs+1); 
      t(-60, 0, 5) Keil(o=gap);
    }  
}

module Keil(o=0)
{
  t(d2_stubs/2, -10, -2) hull() { cube([1.5+o, 20, 2]); t(2, 0, 1.5) cube([1+o, 20, 2]); }
}

module Tower(h=35, step=10)
{ 
  color("white") diff() 
  { 
    Tile(3); 
    CutRing();
    tz(-1) le(20) hex(d2=23);
    tz(2.5) le(20) hex(d2=50); 
  }
  // Ringe
  for(z=[10:step:h-5]) tz(z)
    for (a=[0:60:359]) rotz(a)
      Keil();
      //t(d2_stubs/2, -10, -1) hull() { cube([1.5, 20, 1.5]); t(2, 0, 1.5) cube([1, 20, 1.5]); }

  // Top
  diff() { tz(h-3) le(3) hex(d2=35); tz(-1) le(h+2) hex(d2=d2_stubs); }
  
  // Verctical columns
  tz(2) le(h-2) inter() { 
    diff() { hex(d_tile);hex(d_stubs);}
    for(a=[0:60:120]) rotz(a) square([2, d_tile], true); 
  }
  
  // Podest
  for(z=[5:step:h-6]) tz(z) 
    for(a=[0:60:359]) rotz(a) 
      ty(-d_tile/2) Podest();


  module Podest()
  {
    rotz()  hull() 
    {
      mz() union() { rotz(-60) cube([4.5, 4, 1]); rotz(60) my() cube([4.5, 4, 1]); }
      mz() cube([1, e, 3.5]);
    }
  }
}
