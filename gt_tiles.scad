include <gravitrax.scad>


PART(40, -60) Ring(petg=1);
PART(120, -60) Ring();

PART(  0) TileBase();
PART( 80) TileX();
PART(160) TileStraight();
PART(240) TileCurves();
PART(320) TileY();

PART( 40, 60) TileCyclone();
PART(200, 60) TileUTurn();
PART(280, 60) TileYoyo();

PART(80, 120) TileVulcano();

module CutCurve(d=d2_tile, rr=0.9, a=60, h=h_track, d0=d_track)
{
  tx(d/2) tz(h+d_track/2) rotz() tx(-d*rr)
    re(a, $fa=5) tx(d*rr) circle(d=d0);  
}



// TileCyclone();
//====================================================zz
module TileCyclone()
{
  diff()
  {
    Tile();
    CutRing();
    for(a=[0:120:310]) rotz(a) CutEntry();
    for(a=[0:60:350])  rotz(a) CutStack();
    
    rr = 0.35*d_tile; aa=33;
    
    for(a=[0:120:350]) rotz(a)
    tx(d2_tile/2-2) tz(h_track+d_track/2) rotz() {
      tx(-rr) re(aa) tx(rr) circle(d=d_track);      
      tx(-rr) rotz(aa) tx(rr) rotx(-90) tz(-e) cylinder(d=d_track, h=15);
    }
    
    tz(h_track+d_track/2) re() tx(rr/2) circle(d=d_track);
    tz(-1) cylinder(d=15, h=h_tile);
    hull() {tz(2) cylinder(d=15, h=1); tz(h_track) cylinder(d=rr+4, h=h_tile); }
  }
}

// TileUTurn();
//====================================================
module TileUTurn()
{ 
  s=2; 
  l= d2_tile-20;

  diff()
  {
    union()
    {
      Tile(); 
      bahn(16); 
      t(d2_tile/2-l-2, -8) 
      cube([l+2, 16, 30]);
    }
    tz(40+30) cube(80, true);
    CutRing();
    for(a=[0:60:350])  rotz(a) CutStack();
    ctz([0,20]) CutEntry();
    tx(e) bahn(d_track);
  }
  
  module bahn(d){
  h = d_track/2+h_track;
    tx(d2_tile/2-l)   tz(10+h) roty(-90) rotx() re(180) tx(10-s) 
      union() { circle(d=d); tx(-d/2) ty(-d/2) square([d/2, d]); }
    hull() {
      tx(d2_tile/2)   tz(h)   cc(d, e);
      tx(d2_tile/2-l) tz(h+s) cc(d, e);
    }
    hull() {
      tx(d2_tile/2)   tz(20+h)   cc(d, e);
      tx(d2_tile/2-l) tz(20+h-s) cc(d, e);
    }
  }
  module cc(d, h) { 
    roty() cylinder(h=h, d=d); tz(d/4+1)  cube([h, d, d/2], true);
  }
}

// TileCurves();
//====================================================
module TileCurves()
{
  diff()
  {
    union()
    {
      Tile();
      inter() {
        Tile(17);
        tz(-33.5) sphere(50);
        union() { 
          cc(d2_tile, 0.9, 60, d0=18);
          rotz(180) tx(-4) cc(d2_tile, 0.25, 120, d0=18);
        }
        //#rotz(-50) tx(-8) cube([35, 80, 40], true);
      }
    }
   
    CutRing();
    for(a=[0,2,3,4]) rotz(60*a) CutEntry();
    for(a=[0:60:350])  rotz(a) CutStack();
    
    CutCurve(d2_tile, 0.9, 60);
    rotz(180) tx(-4) CutCurve(d2_tile, 0.25, 120);
  }
  
  

module cc(d=d2_tile, rr=0.9, a=60, h=h_track, d0=d_track)
{
  tx(d/2) tz(h+d_track/2) rotz() tx(-d*rr)
    re(a, $fa=5) tx(d*rr) inter() { circle(d=d0); ty(-d/2) square([d/2, d]);} 
}

}

// TileVulcano();
//====================================================
module TileVulcano()
{
  diff()
  {
    union() {
      Tile();
      tz(10-e) cylinder(h=20, d1=47, d2=25);
    }
    CutRing();
    for(a=[0:60:350])  rotz(a) CutStack();    
    for(a=[0,2,4]) rotz(60*a) CutEntry(); 
    // Auslass
    tz(h_track) 
    {
      tz(d_track/2+2) cylinder(d=d_track,h=20); 

      // Einlass
      rr = 3;
      for(a=[0,2,4]) rotz(60*a) tx(d2_tile/2) rotz() roty() 
        tx(-20) re(120, rr, $fa=3) sqy_co(20, d_track); 
    }
    tz(-e) cylinder(d=d_track,h=40); 
    tz(15) cylinder(d1=d_track, d2=35,h=20); 

  }
}


// TileYoyo();
//====================================================
module TileYoyo()
{
  hm = 2;
  diff()
  {
    union() { 
      Tile(10); 
      for(a=[-60, 180]) rotz(a)  {
       // t(-2,0,-2)
        up(16.5);
        in() { d=16; tx(d/4) cube([d/4+2, d, e], true); }
      }
    }
    CutRing();
    for(a=[1]) rotz(60*a) CutEntry();
    for(a=[0:60:350])  rotz(a) CutStack();
    for(a=[-60, 180]) rotz(a) {
      up(d_track, full=true); 
      in() cylinder(d=d_track, h=e);    
      tz(5) CutEntry();
    }  
      d=d_track;
    
    rotz(60) hull() { 
      tz(d/2+h_track+hm-0.1) roty() cylinder(d=d, h=6);
      tx(d2_tile/2) tz(d/2+h_track) roty() cylinder(d=d, h=e);
    }
  }
  
  module in() {
    hull() { 
      tz(d_track/2+h_track+hm) roty() children(); 
      tx(d2_tile/2) tz(d_track/2+h_track+5) roty() children();
    }
  }
  module up(d, full=false) {
    rr = d2_tile/2-2-d_track/2 + d - d_track;
    tx(d-d_track) tz(h_track + hm + rr + d_track/2 + d_track - d) 
    roty(180) rotx() re(90) tx(rr) 
      if (full) { 
        circle(d=d);
      } else { 
        inter() {circle(d=d); ty(-d/2) square([d/2, d]); } 
      }
  }
}


// TileY();
//====================================================
module TileY()
{
  diff()
  {
    Tile();
    CutRing();
    for(a=[0,2,3,4]) rotz(a*60) CutEntry();
    for(a=[0:60:350]) rotz(a) CutStack();
    cmy() CutCurve(d2_tile, 0.9, 60, d0=d_track);
    CutTrack();
  }    
}

// TileStraight();
//====================================================
module TileStraight()
{
  diff()
  {
    Tile();
    CutRing();
    for(a=[0:60:350]) rotz(a) CutEntry();
    for(a=[0:60:350]) rotz(a) CutStack();
    for(a=[0:120:350]) rotz(a) tz(d_track/2 + h_track) roty() cylinder(d=d_track, h=d_tile, $fn=36, center=true);
  }    
}

// TileX();
//====================================================
module TileX()
{
  diff()
  {
    Tile();
    CutRing();
    for(a=[0,1,3,4]) rotz(a*60) CutEntry();
    for(a=[0:60:350]) rotz(a) CutStack();
    for(a=[0,60]) rotz(a) CutTrack();
  }    
}

// TileBase();
//====================================================
module TileBase()
{
  diff()
  {
    TileStraight();
    tz(h_tile - h_insert) le(h_tile) hex(d_insert + gap);
    tz(-1) le(h_tile) hex(d2=23.5);
  }  
}