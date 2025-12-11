// PB-3 battery pack simplification: single solid block matching the outer envelope.
// Dimensions drawn from measurement photos (measurements/IMG_9373.jpeg–IMG_9385.jpeg)
// and the Stereo2Go teardown cached in research/.
// Units: millimetres.

module pb3_pack_fitting_test() {
    outer_len = 68; 
    outer_width = 17.8;
    outer_height = 8;
    textH=.5; textS=10;
    wiggle=.01;
    difference(){
        cube([outer_len, outer_width, outer_height]);
        translate([textS/2, outer_width/2,outer_height-textH]) linear_extrude(.5+wiggle) text("v0.1",size=textS,valign="center");
    }
}

pb3_pack_fitting_test();
