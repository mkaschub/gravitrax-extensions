include <gravitrax.scad>

PART(0) InsertStraight();
PART(60) InsertY();
PART(120) InsertCurve();
PART(30, 50) InsertSpeedCurve();
PART(90, 50) InsertRamp();
PART(150,50) InsertTub();


// InsertY();
////////////////////////////////////////////////////////////////////
module InsertY()
{
  z = h_track + h_insert - h_tile;
  diff()
  {
    Insert();
    for(a=[60:120:350]) rotz(a) CutEntryInsert();
    CutTrack(d2_insert, z);
    rr = d2_insert*0.88; aa=60;
    
    cmy() tx(d2_insert/2) tz(z+d_track/2) rotz() re(aa, rr) circle(d_track/2);
  }
}

// InsertCurve();
////////////////////////////////////////////////////////////////////
module InsertCurve()
{
  z = h_track + h_insert - h_tile;
  diff()
  {
    Insert();
    for(a=[1,3,4,5]) rotz(a*60) CutEntryInsert();
    
    CutCurve(d=d2_insert, rr=0.88, a=60, h=z);
    rotz(120) CutCurve(d=d2_insert, rr=0.295, a=120, h=z);
  }
}

// InsertSpeedCurve();
////////////////////////////////////////////////////////////////////
module InsertSpeedCurve()
{
  z = h_track + h_insert - h_tile;
  diff()
  {
    union()
    {
      Insert();
      inter() { 
        tz(-19) sphere(d_tile/2); 
        Insert(15);
        union(){
          CutCurve(d=d2_insert-1, rr=0.88, a=60, h=z, d0=18);
          rotz(120) CutCurve(d=d2_insert-1, rr=0.295, a=120, h=z, d0=18);
        }
        ty(8) rotz(20) cube([50, 30, 30], true);
      }
    }
    for(a=[1,3,4,5]) rotz(a*60) CutEntryInsert();
    CutCurve(d=d2_insert, rr=0.88, a=60, h=z);
    rotz(120) CutCurve(d=d2_insert, rr=0.295, a=120, h=z);
  }
}

// InsertRamp();
////////////////////////////////////////////////////////////////////
module InsertRamp()
{
  diff()
  {
    hull() {
      Insert();
      inter() {
        Insert(25); 
        rrr() { diff() {circle(d=17); tx(-3) square(20, center=true); }}}
    }
    for(a=[3]) rotz(a*60) CutEntryInsert();

    rrr(d_track) { circle(d=d_track); }
  }
  module rrr(d)
  { 
    rr = 50; z = h_track + h_insert - h_tile +d_track/2;
    tx(d2_insert/2) tz(z) rotz() roty() tx(-rr) re(45, $fa=0.5) tx(rr) children(); 
  }
}


// InsertTub();
////////////////////////////////////////////////////////////////////
module InsertTub()
{
  z = h_track + h_insert - h_tile;
  diff()
  {
    Insert(20);
    //rrr(d_track) { Ci(d=d_track); }
    for(a=[3]) rotz(a*60) CutEntryInsert();
    inter() {
      le(30, center=false) hex(d_insert-3);
      tx(2) tz(16.6) roty(25) scale([1,1,0.4]) sphere(25);
    }
    tz(63) roty(25) cube(80, center=true);
  }
  
  module rrr(d)
  { 
    rr = 50; z = h_track + h_insert - h_tile +d_track/2;
    tx(d2_insert/2) tz(z) rotz() roty() tx(-rr) Re(45, $fa=0.5) tx(rr) children(); 
  }
}


// InsertStraight();
////////////////////////////////////////////////////////////////////
module InsertStraight()
{
  z = h_track + h_insert - h_tile;
  diff()
  {
    Insert();
    for(a=[0:120:350]) rotz(a) CutTrack(d2_insert, z); 
    for(a=[0:1:5]) rotz(a*60) CutEntryInsert();

  }
}



module CutCurve(d=d2_tile, rr=0.9, a=60, h=h_track, d0=d_track)
{
  tx(d/2) tz(h+d_track/2) rotz() tx(-d*rr)
    re(a) tx(d*rr) circle(d0/2);  
}

