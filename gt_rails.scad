include <gravitrax.scad>
use <gt_tiles.scad>

$fs = 0.1;

CutEntry(0.3);

d_pin = 3.3;


cmy() ty((d_track-3.75) / 2) {
  hh = 2.4;
le(hh) hc(d_pin, d_pin);
tz(hh) rotx() re(90) hc(d_pin, d_pin);
  
  diff() {
    roty(-90) le(30) hc(d_pin, d_pin+hh);
    //mx() t(0,-5,-e) cube([8, 10, 2]);
    mx() t(0,-5,0.3) cube([8, 10, 2-0.3]);
  } 
}
//cube([d_pin, 3, 

//tz(d_track/2 + h_track) roty(-90) cylinder(d=d_track, h=20);
dd= 12.7;
tz(dd/2 + h_track) roty(-90) cylinder(d=dd, h=20);


//hc(20, 7);
module hc(d, h) { 
  union() { 
    inter() { tx(h-d/2) circle(d=d);  ty(-d/2) square([h, d]); }
    if (h>d/2) ty(-d/2) square([h-d/2, d]); 
  } 
}