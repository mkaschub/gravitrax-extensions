include <gravitrax.scad>

PART(0, -20) Stack(10, standing=1);
PART(20, -20) Stack(20, standing=1);
PART(0) Stack(10);
PART(20) Stack(20);
PART(40) Stack(30);
PART(60) Stack(40, mouseear=1);
PART(80) Stack(60, mouseear=1);


// Stack(20, standing=0);
//====================================================================//
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
