
// 80m Datentransceiver Boden
include <Maße.scad>

// Resolution for 3D printing:
$fa = 1;
$fs = 0.4;

// Radius der Löcher in den Stands:
loch_radius = m3_lochdurchmesser / 2;

//***********************************************************
//** Stand sind die Abstandshalter vom Boden bis zur Platine.
//***********************************************************
module stand(h)
{
    difference() {
        cylinder(h = h, r = stand_radius);
        translate([0, 0, -delta])
            cylinder(h = h + 2*delta, r=loch_radius);
    }
}

//***********************************************************
//** Aussparung sind die Aussparungen im Boden in die von
//** unten die Schrauben für die Befestigung des Deckels
//** hinein kommen.
//***********************************************************
module aussparung(h) {
    translate([0, 0, -delta]) {
        cylinder(h = aussparung_hoehe + 2*delta,
                 r = aussparung_radius);
        cylinder(h = h + 2*delta,
                 r = loch_radius);
    }
}

//***********************************************************
//** Gehäuseboden ohne Aussparungen.
//***********************************************************
module boden() {
    // Boden Platte:
    cube([boden_breite, boden_tiefe, boden_dicke]);
    
    // Stand links vorne: 
    translate([stand_offset, 
               stand_offset, 0])
        stand(h = boden_dicke + platine_bodenfreiheit);
    
     // Stand rechts vorne:
    translate([boden_breite - stand_offset, 
               stand_offset, 0])
        stand(h = boden_dicke + platine_bodenfreiheit);
    
    // Stand links hinten:
    translate([stand_offset, 
               boden_tiefe - stand_offset, 0])
        stand(h = boden_dicke + platine_bodenfreiheit);
    
    // Stand rechts hinten:            
    translate([boden_breite - stand_offset,
               boden_tiefe - stand_offset, 0])
        stand(h = boden_dicke + platine_bodenfreiheit);
}

//***********************************************************
//** Aussparungen für den Gehäuseboden.
//***********************************************************
module aussparungen() {
    // Aussparung links vorne:
    translate([stand_offset,
               stand_offset,
               -delta])
        aussparung(h = boden_dicke + 2*delta);    
     // Aussparung rechts vorne:
    translate([boden_breite - stand_offset,
               stand_offset,
               -delta])
        aussparung(h = boden_dicke + 2*delta);          
    // Aussparung links hinten:
    translate([stand_offset,
               boden_tiefe - stand_offset,
               -delta])
        aussparung(h = boden_dicke + 2*delta);          
    // Aussparung rechts hinten:            
    translate([boden_breite - stand_offset,
               boden_tiefe - stand_offset,
               -delta])
        aussparung(h = boden_dicke + 2*delta);
}

//***********************************************************
//** Fertiger Gehäuseboden.
//***********************************************************
difference() {
    boden();
    aussparungen();
}

