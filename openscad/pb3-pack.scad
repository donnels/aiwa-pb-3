// PB-3 battery pack simplification: single solid block matching the outer
// envelope, embossed with a version marker. See include-pb3-envelope.scad
// for the shared dimensions (also used by pb3-fit-check.scad).
include <include-pb3-envelope.scad>

pb3_envelope(emboss_version=true);
// To test fitting, run OpenSCAD and export to STL. Then 3D print a test block to verify fit in the PB-3 housing.
