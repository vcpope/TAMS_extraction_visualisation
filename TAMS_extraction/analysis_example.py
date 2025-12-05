# Sample analysis code to test on sample data:
# To run in terminal:
# $ python3 analysis_example
# If matching a large number of shows, it is easiest to run the combo_extractMatches 
# function wth combinations:
# # Transcripts
# from itertools import combinations
# from transcriptseqanalysis import combo_extractMatches
# shownum = 5 # number of shows 
# transcript_files = your_transcript_files # list of .srt filenames
# audio_files = your_audio_files # .wav files the same order as transcript files
# data_type = 'Transcript' # other option is 'TranscriptScript' 
# perfID = which_performer
#for x,y in combinations(range(shownum), 2):  # 2 for pairs, 3 for triplets, etc
#    combo_extractMatches(transcript_files[x], transcript_files[y], 
#                                            audio_files[x], audio_files[y], 'data_type', 'perfID')
# # If matching to transcripts to a script, no need to use combinations:
# shownum = 5 # number of shows
# transcript_files = your_transcript_files 
# audio_files = your_audio_files # in the same order as transcript files
# data_type = 'TranscriptScript' # other option is 'Transcript'
# perfID = which_performer
# x = 0
# for x in range(shownum):  
#    combo_extractMatches(transcript_files[x], "Script.txt",
#                                           audio_files[x], audio_files[x], dataType, perfID)

# TEST CODE TO COMPARE TWO SHOWS ONLY
# Change location of file directory
transcript1 = "TAMS_LG_Input_Files/Transcript_LG_1_cut_Awards1.txt"
transcript2 = "TAMS_LG_Input_Files/Transcript_LG_5_cut_RedCarpet1.txt"
audio1 = "TAMS_LG_Input_Files/LG_Montage_1Award_Mic_Full.wav"
audio2 = "TAMS_LG_Input_Files/LG_Montage_5RedCarpet_Mic_Full.wav",
comparison_type = 'Transcript' # Other option is "TranscriptScript"
# Existing performer IDs in TAMS_priors.py file are LG, ComedianA and ComedianB
# LG dataset is used to test the code as source data from ComedianA and ComedianB 
# cannot be shared.
performer_ID = 'LG' 

from TAMS_analysis_functions import *

combo_extractMatches(transcript1, transcript2,
                     audio1, audio2,
                     comparison_type,
                     performer_ID)
