include <gravitrax.scad>

//
//PART(-150) Ring(petg=1);
//PART(-100) Ring();
//PART(-70, -20) Stack(20, flat=0);

PART(0) Stack(10);
PART(20) Stack(20);
PART(40) Stack(30);
PART(60) Stack(40, mouseear=1);
PART(80) Stack(60, mouseear=1);
//PART(-60) Stack(30);
//PART(-50) Stack(40);
//PART(-30) Stack(60);
//
PART(-100, 100) TileStraight();
PART(  0, 100) TileBase();
//PART(100, 100) TileCyclone();
PART(200, 100) TileCurves();
//PART(50, 00) TileCurveSlope();
//PART(150, 00) TileUTurn();
//PART(250, 00) TileYoyo();

//PART(100, 200) Spacer1();
//PART(00, 200) Spacer1(5);



// Stack(20, flat=0);
////////////////////////////////////////////////////////////////////
module Stack(L=20, standing=false, mouseear=false)
{
  z = d2_stack/2-0.2;
  ry = standing ? 0 : 90;
  
  tz(standing ? 0 : z)rotz(ry) roty(ry) diff() 
  {
    union() {
      hull() { 
        tz(0.75) le(L+h_tile-1.5) hex(d_stack); 
        tz(gap) le(L+h_tile-2*gap) hex(d_stack-0.5);
      }
      tz(5) hull() { le(1) hex(d_stack+2);  le(3) hex(d_stack); }
      tz(L+h_tile-5) mz() hull() { le(1) hex(d2=d2_stack+2);  le(3) hex(d2=d2_stack); }
    }
    if(!standing) t(z,-10) cube([20, 20, L+h_tile]);
  }
  if(mouseear)
  {
    ty(-4.4) cylinder(d=10, 0.5);
    ty(L+h_tile+4.4) cylinder(d=10, 0.5);
  }
}



// TileBase();
////////////////////////////////////////////////////////////////////
module TileBase()
{
  diff()
  {
    TileStraight();
    tz(h_tile - h_insert) le(h_tile) hex(d_insert + gap);
    tz(-1) le(h_tile) hex(d2=23.5);
  }  
}

// TileCyclone();
////////////////////////////////////////////////////////////////////
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
      tx(-rr) Re(aa) tx(rr) Ci(d_track/2);      
      tx(-rr) rotz(aa) tx(rr) rotx(-90) tz(-e) cylinder(d=d_track, h=15);
    }
    
    tz(h_track+d_track/2) Re(360) tx(rr/2) Ci(d_track/2);
    tz(-1) cylinder(d=15, h=h_tile);
    hull() {tz(2) cylinder(d=15, h=1); tz(h_track) cylinder(d=rr+4, h=h_tile); }
  }
}

// TileUTurn();
////////////////////////////////////////////////////////////////////
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
    tz(40+30) Cu(80);
    CutRing();
    for(a=[0:60:350])  rotz(a) CutStack();
    //for(a=[0,2,3,4]) rotz(60*a)
    CutEntry(); tz(20) CutEntry();
    tx(e) bahn(d_track);
    //tx(e) tz(1) bahn(d_track);
  }
  
  module bahn(d){
  h = d_track/2+h_track;
    tx(d2_tile/2-l) tz(10+h) roty(-90) rotx() Re(180) tx(10-s) 
      hull() { Ci(d/2); tx(-d/4-1) Sq(d/2, d); }
    hull() {
      tx(d2_tile/2)   tz(h)   cc(d, e);
      tx(d2_tile/2-l) tz(h+s) cc(d, e);
    }
    hull() {
      tx(d2_tile/2)   tz(20+h)   cc(d, e);
      tx(d2_tile/2-l) tz(20+h-s) cc(d, e);
    }
  }
  module cc(d, h)
  { roty() cylinder(h=h, d=d); tz(d/4+1)   Cu(h, d, d/2);
  }
}

// TileCurves();
////////////////////////////////////////////////////////////////////
module TileCurves()
{
  diff()
  {
    Tile();
    CutRing();
    for(a=[0,2,3,4]) rotz(60*a) CutEntry();
    for(a=[0:60:350])  rotz(a) CutStack();
    
    CutCurve(d2_tile, 0.9, 60);
    rotz(180) tx(-4) CutCurve(d2_tile, 0.25, 120);
  }
}


// TileYoyo();
////////////////////////////////////////////////////////////////////
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
        in() { d=16; tx(d/4) Cu(d/4+2, d, e); }
      }
    }
    CutRing();
    for(a=[1]) rotz(60*a) CutEntry();
    for(a=[0:60:350])  rotz(a) CutStack();
    for(a=[-60, 180]) rotz(a) {
      up(d_track, full=true); 
      in() Cy(d=d_track, h=e);    
      tz(5) CutEntry();
    }  
      d=d_track;
    
    rotz(60) hull() { 
      tz(d/2+h_track+hm-0.1) roty() Cy(d=d, h=6);
      tx(d2_tile/2) tz(d/2+h_track) roty() Cy(d=d, h=e);
    }
    //tz(40+33) Cu(80);
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
    roty(180) rotx() Re(90) tx(rr) 
      if (full) { 
        Ci(d/2);
      } else { 
        inter() {Ci(d/2); tx(d/4) Sq(d/2, d); } 
      }
  }
}


// TileCurveSlope();
////////////////////////////////////////////////////////////////////
module TileCurveSlope()
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
        rotz(-60) Cu(20, 80, 40);
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



module CutCurve(d=d2_tile, rr=0.9, a=60, h=h_track, d0=d_track)
{
  tx(d/2) tz(h+d_track/2) rotz() tx(-d*rr)
    re(a, $fa=5) tx(d*rr) circle(d=d0);  
}

// TileY();
////////////////////////////////////////////////////////////////////
module TileY()
{
  diff()
  {
    Tile();
    CutRing();
    for(a=[0:60:350]) rotz(a) CutEntry();
    for(a=[0:60:350]) rotz(a) CutStack();
    for(a=[0:120:350]) rotz(a) tz(d_track/2 + h_track) roty() Cy(d_track/2, d_tile, $fn=36);
  }    
}

// TileStraight();
////////////////////////////////////////////////////////////////////
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
