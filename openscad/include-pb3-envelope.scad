// Shared PB-3 outer envelope library. Dimensions drawn from measurement
// photos (measurements/IMG_9373.jpeg-IMG_9385.jpeg) and the Stereo2Go
// teardown cached in research/. Units: millimetres.
//
// Included by pb3-pack.scad (print-fit gauge) and pb3-fit-check.scad
// (board-STL overlay). Per ADR-004, `include-*.scad` files are libraries
// only -- they are skipped by the CI render loop.

pb3_envelope_len = 68;
pb3_envelope_width = 17.8;
pb3_envelope_height = 8;

module pb3_envelope(emboss_version=false) {
    textH = .5;
    textS = 10;
    wiggle = .01;
    if (emboss_version) {
        difference() {
            cube([pb3_envelope_len, pb3_envelope_width, pb3_envelope_height]);
            translate([textS / 2, pb3_envelope_width / 2, pb3_envelope_height - textH])
                linear_extrude(.5 + wiggle) text("v0.1", size=textS, valign="center");
        }
    } else {
        cube([pb3_envelope_len, pb3_envelope_width, pb3_envelope_height]);
    }
}
