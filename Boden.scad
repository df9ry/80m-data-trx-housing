
// 80m Datentransceiver Boden
include <Maße.scad>

// Resolution for 3D printing:
$fa = 1;
$fs = 0.4;

stand_dim        = 6.0;
stand_margin     = 1.5;
loch_durchmesser = 3.5;
tiefe_aussparung = 1.5;
breite_total     = platine_breite + 2*platine_margin;
tiefe_total      = platine_tiefe  + 2*platine_margin;

module stand(h)
{
    difference() {
        cube([stand_dim, stand_dim, h]);
        translate([stand_dim/2, stand_dim/2, 0])
            cylinder(h+delta, r=loch_durchmesser/2);
    }
}

module boden() {
    cube([breite_total, tiefe_total, 2*gehaeuse_dicke]);
    // Stand links vorne: 
    translate([stand_margin, stand_margin, 0])
        stand(h = 2*gehaeuse_dicke+platine_bodenfreiheit);          
     // Stand rechts vorne:
    translate([breite_total-stand_margin-stand_dim,
               stand_margin, 0])
        stand(h = 2*gehaeuse_dicke+platine_bodenfreiheit);          
    // Stand links hinten:
    translate([stand_margin,
               tiefe_total-stand_margin-stand_dim, 0])
        stand(h = 2*gehaeuse_dicke+platine_bodenfreiheit);          
    // Stand rechts hinten:            
    translate([breite_total-stand_margin-stand_dim,
               tiefe_total-stand_margin-stand_dim, 0])
        stand(h = 2*gehaeuse_dicke+platine_bodenfreiheit);
}

module aussparung(h) {
    // Aussparung von unten:
    cube([stand_dim, stand_dim, h]);
    // Loch:
    translate([stand_dim/2, stand_dim/2, 0])
        cylinder(5, r=loch_durchmesser/2);
}

module aussparungen() {
    // Aussparung links vorne:
    translate([stand_margin, stand_margin, -delta])
        aussparung(h = tiefe_aussparung+delta);    
     // Aussparung rechts vorne:
    translate([breite_total-stand_margin-stand_dim,
               stand_margin, -delta])
        aussparung(h = tiefe_aussparung+delta);          
    // Aussparung links hinten:
    translate([stand_margin,
               tiefe_total-stand_margin-stand_dim, -delta])
        aussparung(h = tiefe_aussparung+delta);          
    // Aussparung rechts hinten:            
    translate([breite_total-stand_margin-stand_dim,
               tiefe_total-stand_margin-stand_dim, -delta])
        aussparung(h = tiefe_aussparung+delta);
}


// Gehäuseboden:

difference() {
    boden();
    aussparungen();
}

/*
  
*/
