#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# These priors are for the three performers and performances used
# for the original TAMS analysis. 

# Indicates the start of the show in relation to original audio / transcript
offsets_priors = {'ComedianA': [43, 106, 37, 325, 34, 
                  29, 44, 135, 205, 15], 
           'ComedianB': [0, 17, 17, 13, 12],
           'LG': [0, 10.04, 16.52, 22.60, 27.76, 36.19, 40.36, 
                  44.87, 52.19, 58.80, 72.76,]}

# Duration of the show in seconds
showLengths_priors = {'ComedianA':[2517, 2590, 2671, 2837, 2739, 
                     2320, 2175, 2422, 2715, 2413],
               'ComedianB': [3759, 3437, 3649, 3660, 3732],
               'LG': [10.04, 17.64, 23.52, 28.60, 36.19, 
                      41.44, 46, 53.23, 58.80,73.69,89.84,]}
# Titles for the show
shows_priors = {'ComedianA': ["16Mar2017", "29Mar2017", "08Apr2017", "24Apr2017", "26Apr2017"],
         'ComedianB': ["3Feb2018", "25Jul2018", "11Aug2018", "17Aug2018","26Aug2018",],
         'LG': ["1Award", "2Panel", "3Chat", "4Interview", "5RedCarpet",
                "6Colbert", "7RedCarpet", "8RedCarpet", "9Interview", 
                "10Talk", "11Talk",]}
# In this case, the performance ID and code are the same
perfCode_priors = {'ComedianA': 'ComedianA', 'ComedianB': 'ComedianB', 'LG': 'LG'}

# Minimum tokens in contiguous sequences. LG is a very short excerpt for 
# testing purposes, so has a much lower minimum token requirement.
minToken_priors = {'ComedianA': 6, 'ComedianB': 6, 'LG': 2}

# The number of token either side of a match
buffersize_priors = {'ComedianA': 3, 'ComedianB': 3, 'LG': 3}