# -*- coding: utf-8 -*-
"""
Created on Thu Mar 14 17:55:40 2024

@author: Lenovo
"""
from wordcloud import WordCloud, ImageColorGenerator
import matplotlib.pyplot as plt
from matplotlib import colors
from matplotlib import cm
import imageio
colormap = cm.get_cmap("Greys")
# 再把这个放到WordCloud()中的colormap参数值就行了

mk = imageio.imread("grey_gradiant2.png")
from wordcloud import get_single_color_func


class SimpleGroupedColorFunc(object):
    def __init__(self, color_to_words, default_color):
        self.word_to_color = {word: color
                              for (color, words) in color_to_words.items()
                              for word in words}

        self.default_color = default_color

    def __call__(self, word, **kwargs):
        return self.word_to_color.get(word, self.default_color)

def create_word_cloud():
    frequencies = {}
    for line in open("./hippo_02_500.txt"):
        arr = line.split(",")
        frequencies[arr[0]] = float(arr[1])

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
    word_cloud = wc.generate_from_frequencies(frequencies)

    color_to_words = {
        '#4472c4': [word for word in frequencies.keys() if 'fear' in word or 'insul' in word or 'angu' in word or 'emot' in word
                or 'depress' in word or 'limbi' in word or 'recall' in word or 'default' in word 
                or 'affect' in word or 'nega' in word or 'avoid' in word or 'default' in word
                or 'remem' in word or 'seman' in word or 'stress' in word or 'recoll' in word
                or 'memo' in word or 'detail' in word or 'hippo' in word or 'default' in word
                or 'therapy' in word or 'unpleas' in word
                or 'painful' in word or 'unpleas' in word
                or 'autobio' in word] 
   }

    default_color = 'grey'
    grouped_color_func = SimpleGroupedColorFunc(color_to_words, default_color)
    #grouped_color_func = SimpleGroupedColorFunc(default_color)

    wc.recolor(color_func=grouped_color_func)

    word_cloud.to_file("H_wordcloud_grey.jpg")
    plt.imshow(word_cloud)
    plt.axis("off")
    plt.show()

p = create_word_cloud()