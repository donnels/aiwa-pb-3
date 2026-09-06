#!/usr/bin/env python3
"""Convert a KiCad glTF board export to an OpenSCAD-ready STL.

Usage: convert-glb-to-stl.py <input.glb> <output.stl>

glTF is meters, Y-up. OpenSCAD is millimetres, Z-up. This rescales,
rotates, and re-origins the board so it drops into an OpenSCAD import()
at [0,0,0] matching the board's real footprint.
"""
import sys

import numpy as np
import trimesh


def main(glb_path: str, stl_path: str) -> None:
    mesh = trimesh.load(glb_path)
    board = trimesh.util.concatenate(list(mesh.geometry.values()))
    board.apply_scale(1000.0)  # metres -> millimetres
    board.apply_transform(
        trimesh.transformations.rotation_matrix(np.radians(-90), [1, 0, 0])
    )  # glTF Y-up -> OpenSCAD Z-up
    board.apply_translation(-board.bounds[0])  # origin-align at [0,0,0]
    board.export(stl_path)
    print(f"board bounds (mm): {board.bounds.tolist()}")


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
