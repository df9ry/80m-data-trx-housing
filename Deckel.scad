
// 80m Datentransceiver Boden
include <Maße.scad>

// Resolution for 3D printing:
$fa = 1;
$fs = 0.4;

// Deckel schön dick wegen Lüftungsgitter:
deckel_dicke = 3.0;

gesamt_hoehe = boden_dicke + 
               platine_bodenfreiheit +
               platine_dicke +
               platine_lichtefreiheit +
               deckel_dicke;

// Höhe des Stands:
stand_basis  = boden_dicke +
               platine_bodenfreiheit +
               platine_dicke;
stand_hoehe  = platine_lichtefreiheit +
               delta;

//***********************************************************
//** Einzelnes Lüftungsgitter.
//***********************************************************
module gitter(sx, sy, sz, steps_x, steps_y, bar_size) {
    x_inc = (sx - bar_size) / steps_x;
    x_gap = x_inc - bar_size;
    y_inc = (sy - bar_size) / steps_y;
    y_gap = y_inc - bar_size;
    
    union() {
        for(n = [0 : 1 : steps_x]) {
            translate([n*x_inc, 0, 0])
                cube([bar_size, sy+bar_size, 
                      sz/2 + delta]);
        }; // end for //   
        for(n = [0 : 1 : steps_y]) {
            translate([0, n*y_inc, sz/2 - delta])
                cube([sx+bar_size, bar_size, 
                      sz/2 + delta]);
        }; // end for // 
    }
}

//***********************************************************
//** Kombiniertes Lüftungsgitter.
//***********************************************************
module lueftungsgitter() {
    sx = boden_breite / 2 - 15.0;
    sy = boden_tiefe - 20.0;
    translate([10, 
               boden_tiefe - 10 - sy, -delta])
        gitter(sx = sx, sy = sy, sz = deckel_dicke + 2*delta,
               steps_x = 10, steps_y = 12, bar_size = 2.0);
    translate([boden_breite - 10 - sx, 
               boden_tiefe - 10 - sy, -delta])
        gitter(sx = sx, sy = sy, sz = deckel_dicke + 2*delta,
               steps_x = 10, steps_y = 12, bar_size = 2.0);
}


//***********************************************************
//** Gehäusedeckel mit Lüftungsgitter.
//***********************************************************
module deckel() {
    difference() {
        translate([-delta, -delta, 0])
            cube([boden_breite + 2*delta,
                  boden_tiefe + 2* delta, deckel_dicke]);
        lueftungsgitter();
    }
}

//***********************************************************
//** Seitenwand.
//***********************************************************
module seitenwand() {
    cube([gehaeuse_dicke, boden_tiefe + 2*gehaeuse_dicke,
          gesamt_hoehe]);
}

//***********************************************************
//** Vorderwand.
//***********************************************************
module vorderwand() {
    translate([-delta, 0, 0])
        cube([boden_breite + 2*delta, gehaeuse_dicke,
            gesamt_hoehe]);
}

//***********************************************************
//** Rückwand mit den Ausschnitten für die Buchsen.
//***********************************************************
module rueckwand() {
    grundlinie = boden_dicke + platine_bodenfreiheit;
    margin     = 0.5;
    
    translate([0, boden_dicke, 0])
    rotate([90, 0, 0])
    difference() {
        cube([boden_breite + 2*delta, gesamt_hoehe,
            gehaeuse_dicke]); 
        {
            // Erste Buchse:
            translate([14.7 + delta,
                       grundlinie + 3.5, -delta])
                cylinder(h = gehaeuse_dicke + 2*delta,
                         r = 3.5);
            // Zweite Buchse:
            translate([28.8 + delta, 
                       grundlinie + 3.5, -delta])
                cylinder(h = gehaeuse_dicke + 2*delta,
                         r = 3.5);
            // Antennenbuchse:
            translate([91.7 + delta, 
                       grundlinie + 7.0, -delta])
                cylinder(h = gehaeuse_dicke + 2*delta,
                         r = 7.0);
            // Stromversorgung:
            translate([68.5 - margin + delta,
                       grundlinie - margin, -delta])
                cube([9.0 + 2*margin,
                      11.0 + 2*margin,
                      gehaeuse_dicke + 2*delta]);
            // RS232 Buchse:
            translate([35.6 - margin + delta,
                       grundlinie - margin, -delta])
                cube([31.0 + 2*margin,
                      12.5 + 2*margin,
                      gehaeuse_dicke + 2*delta]);
        }
    }
}

//***********************************************************
//** Gefüllte Säule mit den Streben.
//***********************************************************
module full_pylon(h, r, o) {
    translate([0, o-0.5, 0])
        cube([o, 1, h]);
    translate([o-0.5, 0, 0])
        cube([1, o, h]);
    translate([o, o, 0])
        cylinder(h = h, r = r);
}

//***********************************************************
//** Säule mit Bohrloch zum Gewindeschneiden.
//***********************************************************
module pylon(h, ro, ri, o) {
    translate([0, 0, -delta])
    difference() {
        translate([0, 0, delta])
            full_pylon(h, ro, o);
        translate([o, o, 0])
            cylinder(h = h, r = ri);
    }
}

//***********************************************************
//** Fertiger Stand.
//***********************************************************
module stand(g) {
    bohr_radius = (m3_lochdurchmesser * 0.8) / 2;
    rotate([0, 0, g])
        pylon(stand_hoehe + delta,
            bohr_radius + 1.5,
            bohr_radius,
            stand_offset);
}

//***********************************************************
//** Zusammengesetzte Haube.
//***********************************************************
module haube() {
    // Deckel:
    translate([0, 0, gesamt_hoehe -deckel_dicke])
        deckel();
    // Seitenwand links:
    translate([-gehaeuse_dicke, -gehaeuse_dicke, 0])
        seitenwand();
    // Seitenwand rechts:
    translate([boden_breite, -gehaeuse_dicke, 0])
        seitenwand();
    // Vorderwand:
    translate([0, -gehaeuse_dicke, 0])
        vorderwand();
    // Rückwand:
    translate([0, boden_tiefe, 0])
        rueckwand();
    // Stand links vorne:
    translate([0, 0, stand_basis])
        stand(0);
    // Stand rechts vorne:
    translate([boden_breite, 0, stand_basis])
        stand(90);
    // Stand links hinten:
    translate([0, boden_tiefe, stand_basis])
        stand(270);
    // Stand rechts hinten:
    translate([boden_breite, boden_tiefe, stand_basis])
        stand(180);
}

//***********************************************************
//** Drehen für den 3D - Druck.
//***********************************************************

rotate([180, 0, 0])
translate([gehaeuse_dicke,
           -boden_tiefe - gehaeuse_dicke,
           -gesamt_hoehe])
haube();