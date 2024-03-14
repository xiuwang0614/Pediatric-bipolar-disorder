# -*- coding: utf-8 -*-
"""
Created on Thu Mar 14 11:22:58 2024

@author: Lenovo
"""


import numpy as np

# Your affine matrix
affine = dset2.masker.mask_img.affine

# Invert the affine matrix
inv_affine = np.linalg.inv(affine)

# Your spatial coordinates
coords = np.array([-21, -21, -12, 1])

# Calculate the voxel coordinates
voxel_coords = np.dot(inv_affine, coords)

# Round to nearest integer and convert to int
voxel_coords = np.round(voxel_coords[:3]).astype(int)

print(voxel_coords)
