include <gravitrax.scad>


PART( 80) SlopeTileX();
PART(40, 60) SlopeTileCurve();




module CutCurve(d=d2_tile, rr=0.9, a=60, h=h_track, d0=d_track)
{
  tx(d/2) tz(h+d_track/2) rotz() tx(-d*rr)
    re(a, $fa=5) tx(d*rr) circle(d=d0);  
}

// TileCurveSlope();
//====================================================
module SlopeTileCurve()
{
  diff()
  {
    union()
    {
      Tile();
      inter() {
        Tile(17);
        tz(-33) sphere(50);
        union() { cs(18); rotz(60) my() cs(18); }
        rotz(-60) cube([20, 80, 40], true);
      }
    }
    CutRing();
    for(a=[3,4]) rotz(60*a) CutEntry();
    for(a=[0,1]) tz(5) rotz(60*a) CutEntry();
    for(a=[0:60:350])  rotz(a) CutStack();
    
    cs(); 
    rotz(60) my() cs();
  }
  
  module cs(d=d_track)
  {
    tz(2.5) rotz(30) roty(-5.5) rotz(-30) CutCurve(d2_tile, 0.9, 60, d0=d);
  }
}

// SlopeTileX();
//====================================================
module SlopeTileX()
{
  diff()
  {
    union() {
      Tile();
      for(a=[0,60]) rotz(a) hull() { 
        x = d2_tile/2-1-e; 
        t(-x, 0, 5) cubexy([2, 17, 10]); 
        t(x, 0, 0) cubexy([2, 17, 10]); 
      }
    }
    CutRing();
    for(a=[0:60:350])  rotz(a) CutStack();    
      
    for(a=[0,1]) rotz(60*a) 
    {
      CutEntry();
      rotz(180) tz(5) CutEntry();    
      tz(h_track+2.5) 
        roty(atan(5/(d2_tile-10))) roty(-90)
        le_ch(d2_tile+2, -2., true) sqy_ci(20, d_track);
    }
  }
}
