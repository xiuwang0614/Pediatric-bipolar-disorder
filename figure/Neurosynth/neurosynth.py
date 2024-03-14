# -*- coding: utf-8 -*-
"""
Created on Thu Mar 14 09:06:35 2024

@author: Lenovo
"""

# -*- coding: utf-8 -*-
"""
Created on Thu Mar 14 09:03:21 2024

@author: Lenovo
"""

import os

import nibabel as nib
import numpy as np
from nilearn.plotting import plot_roi

from nimare.dataset import Dataset
from nimare.decode import discrete
from nimare.utils import get_resource_path
import nimare 

from pprint import pprint

from nimare.extract import download_abstracts, fetch_neuroquery, fetch_neurosynth
from nimare.io import convert_neurosynth_to_dataset

# biopython is unnecessary here, but is required by download_abstracts.
# We import it here only to document the dependency and cause an early failure if it's missing.
import Bio  # pip install biopython

# Core functionality for managing and accessing data
from neurosynth import Dataset
# Analysis tools for meta-analysis, image decoding, and coactivation analysis
from neurosynth import meta, decode, network

nimare.extract.fetch_neurosynth(path="C:\\Users\\Lenovo\\.nimare\\neurosynth")

out_dir = os.path.abspath("./")
os.makedirs(out_dir, exist_ok=True)

files = fetch_neurosynth(
    data_dir=out_dir,
    version="7",
    overwrite=False,
    source="abstract",
    vocab="terms",
)

# Note that the files are saved to a new folder within "out_dir" named "neurosynth".
pprint(files)
neurosynth_db = files[0]

neurosynth_dset = convert_neurosynth_to_dataset(
    coordinates_file=neurosynth_db["coordinates"],
    metadata_file=neurosynth_db["metadata"],
    annotations_files=neurosynth_db["features"],
)
dset2 = neurosynth_dset
dset2.annotations.head(5)

# First we'll make an ROI
arr = np.zeros(dset2.masker.mask_img.shape, np.int32)
arr[28:40,46:58,24:36] = 1

mask_img = nib.Nifti1Image(arr, dset2.masker.mask_img.affine)
plot_roi(mask_img, draw_cross=False)

# Get studies with voxels in the mask
ids = dset2.get_studies_by_mask(mask_img)

# Run the decoder01
# not useful for my data
#decoder.fit(dset2)
#decoded_df = decoder.transform(ids=ids)
#decoded_df.sort_values(by="probReverse", ascending=False).head()

# Run the decoder
# useful
decoder = discrete.NeurosynthDecoder(correction=None)
decoder.fit(dset2)
decoded_df01 = decoder.transform(ids=ids)
decoded_df01.sort_values(by="probReverse", ascending=False).head()
decoded_df01.to_csv(r'./left_hippo_01.csv', sep=',', encoding='utf-8', header='true')

# This method decodes the ROI image directly, rather than comparing subsets of the Dataset like the
# other two.
# useful toooooo
decoder = discrete.ROIAssociationDecoder(mask_img)
decoder.fit(dset2)

# The `transform` method doesn't take any parameters.
decoded_df02 = decoder.transform()
decoded_df02.sort_values(by="r", ascending=False).head()
decoded_df02.to_csv(r'./left_hippo_02.csv', sep=',', encoding='utf-8', header='true')
