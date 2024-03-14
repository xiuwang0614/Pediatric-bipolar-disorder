`recommanded website`: [NiMARE](https://nimare.readthedocs.io/en/stable/auto_examples/04_decoding/01_plot_discrete_decoders.html#sphx-glr-auto-examples-04-decoding-01-plot-discrete-decoders-py)
1. `MNI_affine.py` would be usful during setting the `arr` variable in `neurosynth`
```ruby
# First we'll make an ROI
arr = np.zeros(dset2.masker.mask_img.shape, np.int32)
arr[28:40,46:58,24:36] = 1

mask_img = nib.Nifti1Image(arr, dset2.masker.mask_img.affine)
plot_roi(mask_img, draw_cross=False)
```
2. `neurosynth.py` performs meta-analytic functional decoding on regions of interest.
3. `wordcloud.py` generates the wordcloud figure, based on the `grey_gradiant2.png`, which is used for the background.
```ruby
mk = imageio.imread("grey_gradiant2.png")
...
wc = WordCloud(
        prefer_horizontal = 1,
        mask = mk,
        font_path = "times.ttf",
        background_color = "white",
        contour_color = "yellow",
        colormap = colormap,
        max_words = 100,
        width = 600,
        height = 400)
```
5. `remove_repeat_word.py` is used to remove the phrases contained repeat words.
6. `Brian_region.node` is the input for the BrainNet view.
