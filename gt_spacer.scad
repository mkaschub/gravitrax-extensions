include <gravitrax.scad>

/// Gravitrax compatible spacers with a hole in the middle 
/// for the marble to fall through. 

PART(0, 0) Spacer(5);
PART(60, 0) Spacer(10);
PART(120, 0) Spacer(20);
PART(30, 50) Spacer(30);
PART(90, 50) Spacer(50);


// Spacer();
////////////////////////////////////////////////////////////////////
module Spacer(h=5, stubs=true)
{
  if(stubs) color("grey") {
  Ds = d2_stubs * 2 / sqrt(3);  
  Bs = Ds/2-3;
  
  // Stubs
  for (a=[30:60:359]) rotz(a) t(-Bs/2, -d2_stubs/2) 
    tz(-h_stubs)cube_round([Bs, 2, h_stubs], 0.9, $fn=12);
  for (a=[30:60:359]) rotz(a) t(-10, -d2_stubs/2) 
    hull() {cube([20, 2, 0.1]); ty(-3) cube([20, 2, 2.2]); }
  }
   
  color("grey") diff() 
  { 
      for(z=[0:10:h]) 
        tz(z) le(min(h-z, 10), scale=0.97, center=false) offset(5) 
          hex(d2=46-10);
      tz(-1) le(h+2) hex(d2_stubs+gap);     
  }
}
