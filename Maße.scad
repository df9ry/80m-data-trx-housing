
// 80m Datentransceiver Maße

// Resolution for 3D printing:
$fa = 1;
$fs = 0.4;

// Allgemeines:
delta                  = 0.1; // Standard Durchdringung

// Gehäuse Dicke
gehaeuse_dicke         = 2.0;

// Abmessungen der Platine:
platine_breite         = 114.5;
platine_tiefe          =  73.7;
platine_dicke          =   1.6;

// Platz nötig unterhalb der Platine:
platine_bodenfreiheit  = 2.5; 

// Platz nötig oberhalb der Platine:
platine_lichtefreiheit = 27.0;

// Luft rings um die Platine herum:
platine_margin         = 0.25;

// Abmessungen des Bodens:
boden_breite           = platine_breite + 2*platine_margin;
boden_tiefe            = platine_tiefe  + 2*platine_margin;
boden_dicke            = gehaeuse_dicke;

// Abmessungen der verwendeten M3 Schrauben:
m3_kopfdurchmesser     = 6.0;
m3_kopfhoehe           = 3.0;
m3_lochdurchmesser     = 3.5;

// Aussparungen im Boden für die Köpfe der M3 Schrauben:
aussparung_radius      = m3_kopfdurchmesser/2 + 0.5;
aussparung_hoehe       = m3_kopfhoehe + 0.5;

// Position und Größe der Stands:
stand_offset           = 5.0 + platine_margin;
stand_radius           = aussparung_radius + 0.5;
