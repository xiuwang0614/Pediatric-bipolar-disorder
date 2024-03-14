# -*- coding: utf-8 -*-
"""
Created on Thu Mar 14 16:32:52 2024

@author: Lenovo
"""

def remove_duplicates(filename, keyword):
    with open(filename, 'r') as file:
        lines = file.readlines()

    seen = False
    with open(filename, 'w') as file:
        for line in lines:
            if keyword in line:
                if seen:
                    continue
                else:
                    seen = True
            file.write(line)

# Usage
# replace 'yourfile.txt' with your file name and 'tt' with your keyword
remove_duplicates('./hippo_02_500.txt', 'adults')

