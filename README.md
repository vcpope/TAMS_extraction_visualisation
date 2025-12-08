# TAMS_extraction_visualisation

Code in TAMS_extraction scripts compares timestamped transcripts to one another or a script, creates a folder for analysis results, cleans transcripts, outputs the cleaned files as .txt, locates longest contiguous sequences that match, creates a clip from the audio of each transcript’s .wav file for each match, and creates a .csv file that reports sequences and their location (in time and in number of tokens). The core algorithm compares two shows at a time, but the analysis example code shows how you can feed in a bigger collection of shows easily by using combinations from itertools (I've used 20 transcripts at a time, resulting in 20 choose 2 = 190 output folders).

Code in TAMS_visualisation take output files from TAMS_extraction and converts them into interactive visualisations in Processing. 

## Motivation

This sequence matching code was written to find patterns in the transcripts of stand-up comedy shows. You can read more about my work here: Transferring my code onto GitHub is part of a project to make my research replicable and open source. 

## Input
The code takes in .srt files, which are subtitle files that include timestamp information, and .wav files for audio. 

## Output
TAMS_extraction creates a folder for each comparison that contains: an audio clip for each show for each subsequence, copies of the cleaned transcripts as .txt files and a .csv file that provides information on each matched subsequence in each row, with match IDs, time data and buffer analysis (the buffer analysis is a little idiosyncratic to my research, looking at whether hesitations were more likely immediately before or after a matching
sequence).

TAMS_visualisation creates interactive images in Processing.

## What the code does 

The files are first processed to remove punctuation and code certain words. The sequence is tested to see that it is long enough before the contiguous sequence search is run. Once a match is located, its information and information on its surroundings (referred to as a buffer in the code) are added to the summary .csv. Clips for each match are created from the audio (.wav) files that match each transcript.

A summary .csv files accompanies the clips as well as cleaned .txt files. It contains location information as well as light analysis the surroundings of the sequence and whether or not the match contains a disfluency (HES).

# Implementation
- analysis_example.py runs in python3. A list of requirements can be found in requirements.txt
- To test an analysis and get a sense of its outputs, run the analysis_example.py script that runs on sample data 
- If working with new data, create new perfID and show data in combo_extractMatches() and get_showID() in this file (NB: I aim to change these to input parameters but haven't got around to it yet!)
- Files and information needed to run code are: transcript/script/vowel list filenames, show audio filenames, data matchtype (Transcript / TranscriptScript) and performance ID
- File names are used to create folders and identify shows, so the naming convention is important: 

For transcripts: "DataType_PerfID_Location_Note_DDMMMYYYY.txt", "Transcript_PN_Edinburgh_Extract_26Aug2018.txt"

For audio: "PerfID_Location_DDMMMYYYY_Source_Note.wav", e.g. "PN_Edinburgh_26Aug2018_Mic_Full.wav"

## Example analysis

To run in terminal:
``$ python3 analysis_example``

If matching a large number of shows, it is easiest to run the combo_extractMatches 
function wth combinations:

## Transcripts

    from itertools import combinations
    from transcript_seq_analysis import combo_extractMatches
    shownum = 5 # number of shows 
    transcript_files = your_transcript_files # list of .srt filenames
    audio_files = your_audio_files # .wav files the same order as transcript files
    data_type = 'Transcript' # other option is 'TranscriptScript' 
    perfID = which_performer
    
    for x,y in combinations(range(shownum), 2):  #2 for pairs, 3 for triplets, etc
        combo_extractMatches(transcript_files[x], transcript_files[y], 
            audio_files[x], audio_files[y], 'data_type', 'perfID')
   
## Show Scripts (as opposed to code!)

If matching to transcripts to a script (the textual basis for a performance), no need to use combinations:

    from transcript_seq_analysis import combo_extractMatches
    shownum = 5 # number of shows
    transcript_files = your_transcript_files 
    audio_files = your_audio_files # in the same order as transcript files
    data_type = 'TranscriptScript' # other option is 'Transcript'
    perfID = which_performer
    x = 0

    for x in range(shownum):  
        combo_extractMatches(transcript_files[x], "Script.txt",
            audio_files[x], audio_files[x], dataType, perfID)

# Thank you

With thanks to Tom Deacon, Ken Deguernel and Tom Gurion for their help debugging the code and contributions.
