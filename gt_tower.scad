include <gravitrax.scad>

//I()
U(){
//D() { 
  Tower(100, 10); //tz(50+90) cube(100, center=true); }
t(60, 0, 30) Tile();
  
#tz(30 + h_track+7-5) roty(-atan(10/60)) roty() Cy(d=14, h=60);
color("grey") tz(30 + h_track) Cu(110, 13, 3);
}

PART(-300) Tower(135, 10);
PART(-200) Tower(100, 20);
PART(-100) Tower(65, 10);

PART(60, 0, 15) Platform();
rotz(60) 
PART(60, 0, 15) Platform(0);
rotz(120) 
PART(60, 0, 15) PlatformMini();
rotz(240) 
PART(60, 0, 15) Platform2();
rotz(300) 
PART(60, 0, 15) PlatformY();

//rotz(60) t(60, 0, 15)  color("red")Platform();

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
  color("red")
  D() 
  { 
    U()
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
      tz(-1) hex(7, d2_stubs+1); 
      t(-60, 0, 5) Keil(o=gap);
    }  
}

module Keil(o=0)
{
  t(d2_stubs/2, -10, -2) hull() { cube([1.5+o, 20, 2]); t(2, 0, 1.5) cube([1+o, 20, 2]); }
}


//Ring();
////////////////////////////////////////////////////////////////////
module Ring()
{
  color("blue")   
  tz(h_ring) for (a=[30:60:359]) rotz(a) t(-Bs/2, -d2_stubs/2) 
    cube_round([Bs, 2, h_stubs], 0.9, $fn=12);
  D() {
    hex(h_ring, d2_ring-3*gap);
    tz(-1) hex(10, 26+0*gap);
  } 
} 

module Tower(h=35, step=10)
{
  
  color("white") D() 
  { 
    Tile(3); 
    CutRing();
   tz(-1) hex(20, 23);
   tz(2.5) hex(20, 50); 
    }
  // Ringe
  for(z=[10:step:h]) tz(z)
    for (a=[0:60:359]) rotz(a)
      Keil();
      //t(d2_stubs/2, -10, -1) hull() { cube([1.5, 20, 1.5]); t(2, 0, 1.5) cube([1, 20, 1.5]); }

  // Top
  D() { tz(h-3) hex(3, 35); tz(-1) hex(h+2, d2_stubs); }
  
  // Verctical columns
  tz(2) Le(h-2, center=false) I() { 
    D() { hex2(d_tile);hex2(d_stubs);}
    for(a=[0:60:120]) rotz(a) Sq(2, d_tile); 
  }
  
  // Podest
  for(z=[5:step:h-1]) tz(z) 
    for(a=[0:60:359]) rotz(a) 
      ty(-d_tile/2) Podest();


  module Podest()
  {
    rotz()  hull() 
    {
      mz() U() { rotz(-60) cube([4.5, 4, 1]); rotz(60) my() cube([4.5, 4, 1]); }
      mz() cube([1, e, 3.5]);
    }
  }
}
