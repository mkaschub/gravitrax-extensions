include <gravitrax.scad>
use <gt_tiles.scad>

$fs = 0.1;

CutEntry(0.3);

d_pin = 3.3;


cmy() ty((d_track-3.75) / 2) {
  hh = 2.4;
le(hh) sqy_co(d_pin, d_pin);
tz(hh) rotx() re(90) sqy_co(d_pin, d_pin);
  
  diff() {
    roty(-90) le(30) sqy_co(d_pin+hh, d_pin);
    //mx() t(0,-5,-e) cube([8, 10, 2]);
    mx() t(0,-5,0.3) cube([8, 10, 2-0.3]);
  } 
}
//cube([d_pin, 3, 

//tz(d_track/2 + h_track) roty(-90) cylinder(d=d_track, h=20);
dd= 12.7;
tz(dd/2 + h_track) roty(-90) cylinder(d=dd, h=20);


//sqc_r(20, 7,2);
//module cisqy(x, y) { 
//  union() { 
//    inter() { tx(y-x/2) circle(d=x);  ty(-x/2) square([y, x]); }
//    if (y>x/2) ty(-x/2) square([y-x/2, x]); 
//  } 
//}
//module ci_sqx(x, y) { rotz() ci_sqy(y,x); }
//
