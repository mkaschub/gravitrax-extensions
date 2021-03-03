use <mkscad/mkscad.scad>

gap = 0.2; // air gap (adjust to your printer)

d2_tile = 60 - gap; // base width of tile
h_tile = 10; // height of tile

d2_insert = 39.6; // base width of insert
h_insert = h_tile - 1.5; // heigt of insert

h_track = 3.9; // Height of track
d_track = 13.75; // width == diameter of track

d2_ring = 35.0; // base width of ring
h_ring = 0.75; // Hoehe Ring
d2_stubs = 29.6; // base width of connecting stubs (below ring)
h_stubs = 3.5; // height (length) of connecting stubs

d2_stack = 7.6; // base width of stacking rod

e = 0.01; // epsilon for boolean operations



d_stack = d2_stack * 2 / sqrt(3); 
d_tile = d2_tile * 2 / sqrt(3); // outer diameter of tile
d_insert = d2_insert * 2 / sqrt(3); 
d_stubs = d2_stubs * 2 / sqrt(3); 


//CutTrack();
////////////////////////////////////////////////////////////////////
module CutTrack(l=d2_tile, h=h_track)
{
  tz(h+d_track/2) roty() 
  {
    cylinder(d=d_track, h=l, center=true, $fn=36);
    cmz() tz(-l/2-e) cylinder(d1=d_track+1, d2=d_track, h=1);
  }
}

//CutEntryInsert();
////////////////////////////////////////////////////////////////////
module CutEntryInsert()
{
  c = gap + 1.5;
  tx(-d2_insert/2) tz(h_track + h_insert - h_tile + d_track/2) roty() 
    cylinder(d1=d_track+c, d2=d_track, h=c);  
}

//Insert();
////////////////////////////////////////////////////////////////////
module Insert(h=h_insert)
{
  r = 3; c = 0.8;
  hull()
  {
    le(h) offset(r) offset(-r) hex(d2=d2_insert - 2 * gap - c);
    tz(c) le(h-2*c) offset(r) offset(-r) hex(d2=d2_insert - 2* gap);
  }
}

//CutCurve();
////////////////////////////////////////////////////////////////////
module CutCurve(r=1, aa=60)
{
  rr = r * d2_tile;
  tx(d2_tile/2) tz(h_track+d_track/2) rotz() tx(-rr)
    re(aa) tx(rr) circle(d_track/2);  
}

//CutStack();
////////////////////////////////////////////////////////////////////
module CutStack()
{  
  ty(d_tile/2 - 1.5 - d_stack/2)
  {
    le(3*h_tile+1) hex(d2=d2_stack+gap);
    tz(-e) le(h_tile/2) hex(d2=d2_stack+2*gap);
  }
}


//Tile();
////////////////////////////////////////////////////////////////////
module Tile(h=h_tile)
{
  hull() {
    le(h) hex(d_tile-1);
    tz(0.75) le(h-1.5) hex(d_tile);
  }
}


//CutEntry(); tx(-10) CutEntry(-0.6);
////////////////////////////////////////////////////////////////////
module CutEntry(o=0)
{
  h_hole = 0.9-o; // Height of hole (bottom)
  l_hole = 5+o;    // Laenge Loch
  b_hole = 3.75+o ; // Width of hole

  tx(d2_tile/2+e) mx() 
  {
    // 5 mm straight cylinder 
    tz(h_track + d_track/2) roty() cylinder(d=d_track+o, h=5, $fn=36);
    // 2 holes  
    tz(h_hole) cmy() ty(-d_track/2-o/2)  
    {
      t(l_hole, b_hole/2) cylinder(d=b_hole, h=h_tile, $fn=18);
      diff()
      {
          cube([l_hole, b_hole, h_tile]);    
        t(-e, -e, -e) cube([1-2*o, b_hole+e+e, 2-gap/2]);       
      }
    }
  }  
}

//CutRing();
////////////////////////////////////////////////////////////////////
module CutRing()
{  
  tz(-e) le(h_ring+gap+0.1) diff() { hex(d2=d2_ring); hex(d2=26-gap);} 
}

//Ring();
////////////////////////////////////////////////////////////////////
module Ring(petg=0)
{
  Ds = d2_stubs * 2 / sqrt(3);  
  Bs = Ds/2-3;
  
  tz(h_ring) for (a=[30:60:359]) rotz(a) t(-Bs/2, -d2_stubs/2) 
    cube_round([Bs, 2, h_stubs], 0.9, $fn=12);
  le(h_ring) diff() { 
    hex(d2=d2_ring-(2+petg)*gap);
    hex(d2=26+(1-petg)*gap);
  } 
} 


