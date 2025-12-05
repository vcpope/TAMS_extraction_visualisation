"""coding: utf-8

This code locates matching subsequences between either two timestamped Subtitle Rip (.srt)
or a series of .srt files a .txt text file on sample data provided.
The files are first processed to remove punctuation
and code certain words. Clips for each match are created from the audio (.wav) files for the transcript.
Two summary .csv files accompany the clips as well as cleaned .txt files. One .csv provides information
on the contents and location of matching subsequences, the other on the tokens that didn't match.

 Implementation:
- Code is run in python3 and is a library of helper functions
- To run an analysis, run the analysis_example.py script also provided
- If using new performances for analysis, create new perfID and show data in
combo_extractMatches() and get_showID() in this file
- Files and information needed to run code are: transcript/script/vowel list filenames,
show audio filenames, data matchtype (Transcript / TranscriptScript)
and performance ID
 - File names are used to create folders and identify shows, so the naming convention is
important.
For transcripts: "DataType_PerfID_Location_Note_DDMMMYYYY.txt"
e.g. "Transcript_ComedianB_Edinburgh_Extract_26Aug2018.txt"
For audio: "PerfID_Location_DDMMMYYYY_Source_Note.wav"
e.g. "ComedianB_Edinburgh_26Aug2018_Mic_Full.wav"

At the bottom of the code there is a commented out sample to test on the sample data.

"""

import datetime
import time
import string
import pandas as pd
import numpy as np
import math
import wave
import struct
import os
from itertools import combinations
from TAMS_priors import *


def combo_extractMatches(tokenFile1, tokenFile2, #transcript or script .srt or .txt
                         audioFile1, audioFile2, 
                         inputDataType, perfID):

    # Add a new perfID and relevant data to priors as required
    
    # Time data to track code running times
    ts = time.time()
    start_time = datetime.datetime.fromtimestamp(ts).strftime("%Y-%m-%d %H:%M:%S")
    print(start_time)

    global perfCode, offsets, showLengths
    global show1_Time, show2_Time
    global show1_index, show2_index
    global buffersize
    global minToken

    offsets = offsets_priors[perfID]
    showLengths = showLengths_priors[perfID]
    shows = shows_priors[perfID]
    perfCode = perfCode_priors[perfID]
    minToken = minToken_priors[perfID]
    buffersize = buffersize_priors[perfID]

    # From the input files, find show information
    show1_index, show1_Time = get_showID(tokenFile1, offsets, showLengths, shows)

    # If the transcript is being compared to a script, there is no second show
    if inputDataType == "TranscriptScript":
        show2_index = show1_index
        show2_Time = 0
    else:
        show2_index, show2_Time = get_showID(tokenFile2, offsets, showLengths, shows)

    print(f"Show 1 index is {show1_index}, Show 2 index is {show2_index}")

    global folderName
    global rowNum
    rowNum = 0

    global dataType
    dataType = inputDataType

    # Create analysis folder
    folderName = token_createFolder(tokenFile1, tokenFile2)

    # print(f'Folder Name is {folderName}')

    # Create the categories reported in the .csv files
    global colNames
    global offcutColNames

    # Summary table reports on matching subsequences
    colNames = [
        "Seq_Contents",
        "TEXT",
        "Seq_Length",
        "Recording_ID",
        "Token_Number",
        "Table_start",
        "Table_end",
        "Audio_start",
        "Audio_end",
        "Norm_start",
        "Norm_end",
        "Status",
        "Tot_Show_Time",
        "Tot_Hes",
        "Hes_In_Match",
        "Buffer_B3",
        "Buffer_B2",
        "Buffer_B1",
        "Break_Type_Before",
        "Break_Quant_Before",
        "Hes_Buf_Before",
        "Buffer_A1",
        "Buffer_A2",
        "Buffer_A3",
        "Break_Type_After",
        "Break_Quant_After",
        "Hes_Buf_After",
    ]

    # Offcut table reports on contents not in a subsequence
    # offcutColNames = ["Word", "Df_index", "Time_Start", "Time_End", "Show", "Why"]

    # Create tables
    # TODO: The offcut table has a bug so I've disabled it for now
    global table
    # global offcutTable
    table = pd.DataFrame(columns=colNames)
    # offcutTable = pd.DataFrame(columns = offcutColNames)

    tableName = summary_tablename(tokenFile1, tokenFile2)
    # offcutTableName = offcut_tablename(tokenFile1, tokenFile2)

    global df_show1
    global df_show2
    global tot_hes_1, tot_hes_2

    # Transform files into dataframes
    if dataType == "Transcript":
        df_show1, tot_hes_1 = transcriptTransform(tokenFile1)
        df_show2, tot_hes_2 = transcriptTransform(tokenFile2)
        ID1 = audioFile1
        ID2 = audioFile2
    elif dataType == "TranscriptScript":
        df_show1, tot_hes_1 = transcriptTransform(tokenFile1)
        df_show2 = scriptTransform(tokenFile2)
        tot_hes_2 = 0
        show2_Time = 0
        ID1 = audioFile1
        ID2 = "Script"

    print("Data extracted")

    # Compare the two shows recursively
    combo_recSearchAndExtract(df_show1, df_show2, audioFile1, audioFile2, "Exact")

    # Create .csv files from the dataframes
    table = table.reset_index(drop=True)
    table.to_csv(tableName)

    global test_df, test_table
    test_df = df_show1
    test_table = table

    print("Summary Tables Printed")

    ts = time.time()
    end_time = datetime.datetime.fromtimestamp(ts).strftime("%Y-%m-%d %H:%M:%S")

    print("Start time was", start_time, ", End time was", end_time)

    print("Analysis Complete")

    return


# Collates the information on a match, calls the contiguous subsequence function and writes to table
# Operates recursively, stopping at a minimum token length
def combo_recSearchAndExtract(
    dfCut_show1, dfCut_show2, audioFile1, audioFile2, matchType
):

    global table
    global show1_Time, show2_Time, tot_hes_1, tot_hes_2
    global minToken

    prebuffer3 = (
        prebuffer2
    ) = prebuffer1 = postbuffer1 = postbuffer2 = postbuffer3 = "NA"
    hes_countA = (
        hes_countB
    ) = breaktype_B = breakquant_B = hes_count_BA = hes_count_BB = "NA"
    breaktype_A = breakquant_A = hes_count_AA = hes_count_AB = "NA"

    print("New search started")

    # Check that sequence is long enough to check
    if len(dfCut_show1) < minToken or len(dfCut_show2) < minToken:
        print("Received sequence is too small")
        # write_to_offcuts(dfCut_show1.index[0], dfCut_show1.index[0]+len(dfCut_show1), dfCut_show1, 'Show 1', 'too_small')
        # write_to_offcuts(dfCut_show2.index[0], dfCut_show2.index[0]+len(dfCut_show2), dfCut_show2, 'Show 1', 'too_small')
        return

    # Check section for contiguous sequence
    (
        brutA,
        brutB,
        contigStringA,
        contigStringB,
        contigLen,
        dfStart_show1,
        dfStart_show2,
        dfEnd_show1,
        dfEnd_show2,
        matchType,
    ) = combo_lcgs(dfCut_show1, dfCut_show2, matchType)

    # print(f'SEARCH INFO. Length: {contigLen}; Show1:{dfStart_show1}, {dfEnd_show1}; Show2: {dfStart_show2}, {dfEnd_show2}')

    if contigLen < minToken:
        print("Contiglen is too small")
        # write_to_offcuts(
        #    dfCut_show1.index[0],
        #    dfCut_show1.index[0] + len(dfCut_show1),
        #    dfCut_show1,
        #    "Show 1",
        #    "too_small",
        # )
        # write_to_offcuts(
        #    dfCut_show2.index[0],
        #    dfCut_show2.index[0] + len(dfCut_show2),
        #    dfCut_show2,
        #    "Show 1",
        #    "too_small",
        # )
        return

    if (
        dfStart_show1 < buffersize
        or dfStart_show2 < buffersize
        or dfEnd_show1 > (len(df_show1) - buffersize)
        or dfEnd_show2 > (len(df_show2) - buffersize)
    ):
        print("Too edgy to buffer analyse")
    else:
        breaktype_B, breakquant_B, hes_count_BA, hes_count_BB = buffer_analysis(
            contigStringA.split()[:buffersize],
            contigStringB.split()[:buffersize],
            "Before",
        )
        hes_countA = hes_counter(contigStringA.split()[buffersize:-buffersize])
        breaktype_A, breakquant_A, hes_count_AA, hes_count_AB = buffer_analysis(
            contigStringA.split()[-buffersize:],
            contigStringB.split()[-buffersize:],
            "After",
        )
        hes_countB = hes_counter(contigStringB.split()[buffersize:-buffersize])

    if dataType == "Transcript":
        timeIndex_show1 = [df_show1.loc[dfStart_show1, 1], df_show1.loc[dfEnd_show1, 2]]
        timeIndex_show2 = [df_show2.loc[dfStart_show2, 1], df_show2.loc[dfEnd_show2, 2]]

    if dataType == "TranscriptScript":

        timeIndex_show1 = [df_show1.loc[dfStart_show1, 1], df_show1.loc[dfEnd_show1, 2]]
        timeIndex_show2 = [df_show2.loc[dfStart_show2, 1], df_show2.loc[dfEnd_show2, 2]]

    # print ("Matched string is %s. In Show 1, should start at %r. In Show 2, should start at %r." \
    #      % (contigStringA, dfStart_show1, dfStart_show2))

    # The following sections create the row contents for show1 buffer analysis
    if (
        buffersize >= 3
        and dfStart_show1 > buffersize
        and dfEnd_show1 < len(df_show1) - buffersize
    ):
        prebuffer3, prebuffer2, prebuffer1 = (
            df_show1.loc[dfStart_show1 - 3, 0].upper(),
            df_show1.loc[dfStart_show1 - 2, 0].upper(),
            df_show1.loc[dfStart_show1 - 1, 0].upper(),
        )
        postbuffer1, postbuffer2, postbuffer3 = (
            df_show1.loc[dfEnd_show1 + 1, 0].upper(),
            df_show1.loc[dfEnd_show1 + 2, 0].upper(),
            df_show1.loc[dfEnd_show1 + 3, 0].upper(),
        )
    elif buffersize < 3 and dfStart_show1 > 1 and dfEnd_show1 < len(df_show1) - 2:
        prebuffer3, prebuffer2, prebuffer1 = (
            "SKIP",
            "SKIP",
            df_show1.loc[dfStart_show1 - 1, 0].upper(),
        )
        postbuffer1, postbuffer2, postbuffer3 = (
            df_show1.loc[dfEnd_show1 + 1, 0].upper(),
            "SKIP",
            "SKIP",
        )
    else:
        prebuffer3, prebuffer2, prebuffer1 = "NA", "NA", "NA"
        postbuffer1, postbuffer2, postbuffer3 = "NA", "NA", "NA"

    if dfStart_show1 <= buffersize and dfStart_show1 > 1:
        prebuffer3, prebuffer2, prebuffer1 = (
            "NA",
            "NA",
            df_show1.loc[dfStart_show1 - 1, 0].upper(),
        )

    if dfEnd_show1 > len(df_show1) - buffersize and dfEnd_show1 <= len(df_show1) - 2:
        postbuffer1, postbuffer2, postbuffer3 = (
            df_show1.loc[dfEnd_show1 + 1, 0].upper(),
            "NA",
            "NA",
        )

    # Create audio clip for show1 match
    matchID = getAudioClip(timeIndex_show1, contigLen, audioFile1)

    # Write show1 match information to the table
    rowContent = [
        brutA,
        contigStringA,
        matchID,
        os.path.basename(audioFile1),
        len(df_show1),
        dfStart_show1,
        dfEnd_show1,
        timeIndex_show1[0],
        timeIndex_show1[1],
        normalise(show1_index, timeIndex_show1[0]),
        normalise(show1_index, timeIndex_show1[1]),
        matchType,
        show1_Time,
        tot_hes_1,
        hes_countA,
        prebuffer3,
        prebuffer2,
        prebuffer1,
        breaktype_B,
        breakquant_B,
        hes_count_BA,
        postbuffer1,
        postbuffer2,
        postbuffer3,
        breaktype_A,
        breakquant_A,
        hes_count_AA,
    ]
    #table = table.append(pd.DataFrame([rowContent], columns=colNames))
    table.loc[len(table)] = rowContent

    # The following sections create the row contents for show2 buffer analysis
    if (
        buffersize >= 3
        and dfStart_show2 > buffersize
        and dfEnd_show2 < len(df_show2) - buffersize
    ):
        prebuffer3, prebuffer2, prebuffer1 = (
            df_show2.loc[dfStart_show2 - 3, 0].upper(),
            df_show2.loc[dfStart_show2 - 2, 0].upper(),
            df_show2.loc[dfStart_show2 - 1, 0].upper(),
        )
        postbuffer1, postbuffer2, postbuffer3 = (
            df_show2.loc[dfEnd_show2 + 1, 0].upper(),
            df_show2.loc[dfEnd_show2 + 2, 0].upper(),
            df_show2.loc[dfEnd_show2 + 3, 0].upper(),
        )
    elif buffersize < 3 and dfStart_show2 > 1 and dfEnd_show2 < len(df_show2) - 2:
        prebuffer3, prebuffer2, prebuffer1 = (
            "SKIP",
            "SKIP",
            df_show2.loc[dfStart_show2 + 1, 0].upper(),
        )
        postbuffer1, postbuffer2, postbuffer3 = (
            df_show2.loc[dfEnd_show2 + 1, 0].upper(),
            "SKIP",
            "SKIP",
        )
    else:
        prebuffer3, prebuffer2, prebuffer1 = "NA", "NA", "NA"
        postbuffer1, postbuffer2, postbuffer3 = "NA", "NA", "NA"

    if dfStart_show2 <= buffersize and dfStart_show2 >= 1:
        prebuffer3, prebuffer2, prebuffer1 = (
            "NA",
            "NA",
            df_show2.loc[dfStart_show2 - 1, 0].upper(),
        )

    if dfEnd_show2 > len(df_show2) - buffersize and dfEnd_show2 <= len(df_show2) - 2:
        postbuffer1, postbuffer2, postbuffer3 = (
            df_show2.loc[dfEnd_show2 + 1, 0].upper(),
            "NA",
            "NA",
        )

    # If the analysis is a transcript to script match, write info to table
    if dataType == "TranscriptScript":
        matchID_2 = matchID
        audioNone = "Script"
        rowContent = [
            brutB,
            contigStringB,
            matchID_2,
            audioNone,
            len(df_show2),
            dfStart_show2,
            dfEnd_show2,
            timeIndex_show2[0],
            timeIndex_show2[1],
            0,
            0,
            matchType,
            show2_Time,
            tot_hes_2,
            hes_countB,
            prebuffer3,
            prebuffer2,
            prebuffer1,
            breaktype_B,
            breakquant_B,
            hes_count_BA,
            postbuffer1,
            postbuffer2,
            postbuffer3,
            breaktype_A,
            breakquant_A,
            hes_count_AB,
        ]
        #table = table.append(pd.DataFrame([rowContent], columns=colNames))
        table.loc[len(table)] = rowContent
    # Otherwise create an audio clip for show2 and write info the table
    else:
        matchID_2 = getAudioClip(timeIndex_show2, contigLen, audioFile2)
        rowContent = [
            brutB,
            contigStringB,
            matchID_2,
            os.path.basename(audioFile2),
            len(df_show2),
            dfStart_show2,
            dfEnd_show2,
            timeIndex_show2[0],
            timeIndex_show2[1],
            normalise(show2_index, timeIndex_show2[0]),
            normalise(show2_index, timeIndex_show2[1]),
            matchType,
            show2_Time,
            tot_hes_2,
            hes_countB,
            prebuffer3,
            prebuffer2,
            prebuffer1,
            breaktype_B,
            breakquant_B,
            hes_count_BA,
            postbuffer1,
            postbuffer2,
            postbuffer3,
            breaktype_A,
            breakquant_A,
            hes_count_AB,
        ]
        #table = table.append(pd.DataFrame([rowContent], columns=colNames))
        table.loc[len(table)] = rowContent

    # split the dataframes so the search can be run again

    df_show1a = df_show1.loc[dfCut_show1.index[0] : dfStart_show1 - 1]  # Changed
    df_show2a = df_show2.loc[dfCut_show2.index[0] : dfStart_show2 - 1]  # Changed
    # print(f'(Show index 1:{dfCut_show1.index[0]}, {dfStart_show1}, \
    # Show index 2: {dfCut_show2.index[0]}, {dfStart_show2})')

    df_show1b = df_show1.loc[
        dfEnd_show1 + 1 : (dfCut_show1.index[0] + len(dfCut_show1) - 1)
    ]
    df_show2b = df_show2.loc[
        dfEnd_show2 + 1 : (dfCut_show2.index[0] + len(dfCut_show2) - 1)
    ]
    # print(f'(Show index 1b:{dfEnd_show1}, {dfCut_show1.index[0]+len(dfCut_show1)}, \
    # Show index 2b: {dfEnd_show2}, {dfCut_show2.index[0]+len(dfCut_show2)})')

    # Chronological matching
    matchType = "Exact"
    # send show1A and show2A through the
    combo_recSearchAndExtract(df_show1a, df_show2a, audioFile1, audioFile2, matchType)
    # send show1B and show2B through
    combo_recSearchAndExtract(df_show1b, df_show2b, audioFile1, audioFile2, matchType)

    # Cross matching
    matchType = "Cross"
    # send show1A and show2A through
    combo_recSearchAndExtract(df_show1a, df_show2b, audioFile1, audioFile2, matchType)
    # send show1B and show2B through
    combo_recSearchAndExtract(df_show1b, df_show2a, audioFile1, audioFile2, matchType)

    return


# Script data Cleaning: remove punctuation, split tokens in dataframe rows
def scriptTransform(origFilename):

    df = pd.DataFrame()
    timestamp = [0, 0]

    cleanFilename = folderName + "/" + "SCRIPT_" + os.path.basename(origFilename)
    # print("CHECK")
    print(cleanFilename)

    origFile = open(origFilename, "r")
    cleanFile = open(cleanFilename, "w")

    for line in origFile:
        for word in line:
            cleanFile.write(word)

    origFile.close()
    cleanFile.close()

    with open(cleanFilename, "r") as f:
        for line in f:
            message = line.split()
            # Remove punctuation from file
            for word in message:
                newWord = word
                newWord = newWord.replace(",", "")
                newWord = newWord.replace("?", "")
                newWord = newWord.replace("!", "")
                newWord = newWord.replace(".", "")
                newWord = newWord.replace("...", " ")
                newWord = newWord.replace("-", " ")
                newWord = newWord.replace('"', " ")
                newWord = newWord.replace("…", " ")
                newWord = newWord.replace("’", " ")
                newWord = newWord.replace("“", " ")
                newWord = newWord.replace("”", " ")

                if newWord:
                    if len(newWord.split()) > 1:
                        for cut_word in newWord.split():
                            newRow = [cut_word, timestamp[0], timestamp[1], "Unmatched"]
                    else:
                        # print("TRUE")
                        newRow = [newWord, timestamp[0], timestamp[1], "Unmatched"]
                        # df.index
                        df = df.append([newRow])

    df = df.reset_index(drop=True)

    return df


# Create an audio clip name based on show info
def clipName(filename, seqLength):

    clipname = (
        folderName
        + "/"
        + str(seqLength)
        + "_"
        + perfCode
        + "_"
        + os.path.basename(filename).split("_")[2]
        + "_"
    )
    clipname += os.path.basename(filename).split("_")[4][0]
    clipname += os.path.splitext(os.path.basename(filename))[1]

    return clipname


# Analyse sequence buffers for disfluencies and similarities
def buffer_analysis(buffer1, buffer1a, switch):

    break_type = break_quant = hes_count_a = hes_count_b = 0

    hes_count_a = hes_counter(buffer1)
    hes_count_b = hes_counter(buffer1a)

    if len(buffer1) < 3 or len(buffer1a) < 3:
        break_type = "TooSmall"
        break_quant = "NA"
        return break_type, break_quant, hes_count_a, hes_count_b

    if switch == "After":
        break1, middle1, end1 = buffer1
        break2, middle2, end2 = buffer1a
    elif switch == "Before":
        end1, middle1, break1 = buffer1
        end2, middle2, break2 = buffer1a

    if end1 == end2:
        if middle1 == middle2:
            break_type = "Substitution"
            break_quant = 1
        
        else:
            break_type = "Substitution"
            break_quant = 2
        

    elif middle1 == break2 and end1 == middle2:
        break_type = "Insertion"
        break_quant = 1
    

    elif break1 == middle2 and middle1 == end2:
        break_type = "Insertion"
        break_quant = 1
    

    elif end1 == break2 or break1 == end2:
        break_type = "Insertion"
        break_quant = 2
    

    elif middle1 == middle2:
        break_type = "Same_Middle"
        break_quant = 2
        
    else:
        break_type = "None"
        break_quant = 3

    return break_type, break_quant, hes_count_a, hes_count_b


#
def combo_lcgs(S, T, matchType):
    # incorporating itertuples for speed

    global df_show1
    global df_show2
    global dataType
    # global offcutTable

    i_start = j_start = i_end = j_end = 0

    S_start = S.index[0]
    m = len(S)
    S_stop = S_start + m

    T_start = T.index[0]
    n = len(T)
    T_stop = T_start + n

    # print(f'(Show 1 start/stop: {S_start},{S_stop}; Show 2 is {T_start},{T_stop})')

    if m < minToken or n < minToken:
        print("df too short")
        # write_to_offcuts(S_start, S_stop, S, "Show 1", "df_too_small")
        # write_to_offcuts(T_start, T_stop, T, "Show 2", "df_too_small")
        return "NA", "NA", "NA", "NA", 0, i_start, j_start, i_end, j_end, matchType

    counter = [[0] * (T_stop + 2) for x in range(S_stop + 2)]

    longest = 0
    lcgs_stringA = lcgs_stringB = lcgs_brutA = lcgs_brutB = ""
    lcgs_set = set()
    c = 0

    for i in S.itertuples():
        for j in T.itertuples():
           
            if str(i[1]).lower() == str(j[1]).lower():
                c = counter[i[0]][j[0]] + 1  # add to counter
                counter[i[0] + 1][
                    j[0] + 1
                ] = c  # reassign counter (THIS IS BIT THAT FALLS OVER IF YOU REMOVE 1)
            if c > longest and c > 0:
                longest = c
                i_start = i[0] - longest + 1
                j_start = j[0] - longest + 1
                if i[0] + 1 >= len(df_show1) or j[0] + 1 >= len(df_show2):
                    j_end = j[0]
                    i_end = i[0]
                else:
                    j_end = j[0] + 1
                    i_end = i[0] + 1

    print("Matching done")
    # print(f'i indices: {i_start}, {i_end} / j indices: {j_start}, {j_end}')

    if i_end == 0 or j_end == 0:
        print("NO WORDS MATCHED, returning")
        # write_to_offcuts(S_start, S_stop, S, "Show 1", "nothing_found")
        # write_to_offcuts(T_start, T_stop, T, "Show 2", "nothing_found")
        return "NA", "NA", "NA", "NA", 0, i_start, j_start, i_end, j_end, matchType

    if dataType == "DARLA":  # Variable for indexing the df column
        col = "vowel"
    else:
        col = 0

    count1 = -3  # Because we go three words back to collect boundary data
    count2 = 1

    for k in range(i_start, i_end):  # goes up until but does not include last number
        lcgs_brutA += str(df_show1.loc[k, col]).upper()
        lcgs_brutA += " "

    for k in range(j_start, j_end):  # goes up until but does not include last number
        lcgs_brutB += str(df_show2.loc[k, col]).upper()
        lcgs_brutB += " "

    if i_start >= 3 and (i_end + 3) <= len(df_show1):
        # print("Buffer search Show 1 begun")
        counter = 0
        counter2 = 0
        for k in range(
            (i_start - 3), (i_end + 3)
        ):  # goes up until but does not include last number
            lcgs_stringA += str(df_show1.loc[k, col]).upper()
            lcgs_stringA += " "
    else:
        for k in range(
            i_start, i_end
        ):  # goes up until but does not include last number
            lcgs_stringA += str(df_show1.loc[k, col]).upper()
            lcgs_stringA += " "

    if j_start >= 3 and (j_end + 3) <= len(df_show2):
        # print("Buffer search Show 2 begun")
        counter = 0
        counter2 = 0
        for k in range(
            (j_start - 3), (j_end + 3)
        ):  # goes up until but does not include last number
            lcgs_stringB += str(df_show2.loc[k, col]).upper()
            lcgs_stringB += " "
    else:
        for k in range(
            j_start, j_end
        ):  # goes up until but does not include last number
            lcgs_stringB += str(df_show2.loc[k, col]).upper()
            lcgs_stringB += " "

    if not lcgs_stringA and not lcgs_stringB:
        lcgs_stringA = lcgs_stringB = "NA"
        i_start = j_start = i_end = j_end = 0

    return (
        lcgs_brutA,
        lcgs_brutB,
        lcgs_stringA,
        lcgs_stringB,
        longest,
        i_start,
        j_start,
        i_end,
        j_end,
        matchType,
    )


# def write_to_offcuts(start, end, df_offcuts, show, why):

# global offcutTable
# global offcutColNames

# short_df = df_offcuts[start:end]

# for row in short_df.itertuples():
#    offcutData = [row[1], row[0], row[2], row[3], show, why]
# print(offcutData)
#    offcutTable = offcutTable.append(
#        pd.DataFrame([offcutData], columns=offcutColNames)
#    )

# return


def offcut_tablename(fileName1, fileName2):

    if dataType == "Transcript":

        offcut_name = (
            folderName
            + "/"
            + dataType
            + "_"
            + os.path.basename(fileName1).split("_")[1]
            + "_"
            + os.path.basename(fileName1).split("_")[4].split(".")[0]
            + "_"
            + os.path.basename(fileName2).split("_")[4].split(".")[0]
            + "_"
            + "Offcuts"
            + ".csv"
        )

    else:

        offcut_name = (
            folderName
            + "/"
            + dataType
            + "_"
            + os.path.basename(fileName1).split("_")[1]
            + "_"
            + os.path.basename(fileName1).split("_")[4].split(".")[0]
            + "_"
            + dataType
            + "_"
            + "Offcuts"
            + ".csv"
        )

    return offcut_name


def summary_tablename(fileName1, fileName2):

    if dataType == "Transcript":

        summary_name = (
            folderName
            + "/"
            + dataType
            + "_"
            + os.path.basename(fileName1).split("_")[1]
            + "_"
            + os.path.basename(fileName1).split("_")[4].split(".")[0]
            + "_"
            + os.path.basename(fileName2).split("_")[4].split(".")[0]
            + "_"
            + "SummaryTable"
            + ".csv"
        )

    else:

        summary_name = (
            folderName
            + "/"
            + dataType
            + "_"
            + os.path.basename(fileName1).split("_")[1]
            + "_"
            + os.path.basename(fileName1).split("_")[4].split(".")[0]
            + "_"
            + dataType
            + "_"
            + "SummaryTable"
            + ".csv"
        )

    return summary_name


def hes_counter(string):
    # Simple counter of number of hesitation tokens
    hes_count = 0

    for word in string:
        if word == "HES":
            hes_count = hes_count + 1

    return hes_count


def getAudioClip(timeIndices, seqLength, audioFile):
    # Based on https://stackoverflow.com/questions/36168253/writing-wav-files-and-make-a-copy-for-the-wav-file
    # With help from Tom Deacon

    # print(f'Start is {timeIndices[0]}, end is [timeIndices[1]}')

    if seqLength < minToken:
        return

    if os.path.isfile(audioFile) == False:
        print("File %s doesn't exist" % audioFile)
        return

    audio1 = wave.open(audioFile, "rb")

    clipname1 = clipName(audioFile, seqLength)
    # Back-up file names to avoid overwriting!
    dup = ""
    dupCount = 0

    while os.path.isfile(clipname1) == True:
        # print("File already exists, making duplicate")
        dup = "_" + str(dupCount)
        dupCount = dupCount + 1
        clipname1 = clipName(audioFile, str(seqLength) + dup)

    clip1 = wave.open(clipname1, "wb")
    clip1.setparams(audio1.getparams())

    nchannels, sampwidth, framerate, nframes, comptype, compname = audio1.getparams()

    # for first show
    start = int(timeIndices[0] * framerate)
    end = int(timeIndices[1] * framerate)

    audio1.readframes(start)
    frames1 = audio1.readframes(end - start)
    clip1.writeframes(frames1)

    print(f'{clipname1.split("/")[-1]} successfully created')

    audio1.close()
    clip1.close()

    id = str(seqLength) + dup

    return id


def transcriptTransform(origFilename):
    
    start_time = []
    end_time = []
    token = []

    df = pd.DataFrame()
    timestamp = [0.000, 0.000]
    hes_count = 0

    new_df = []

    cleanFilename = folderName + "/" + "CLEAN_" + os.path.basename(origFilename)

    origFile = open(origFilename, "r")
    cleanFile = open(cleanFilename, "w")

    for line in origFile:
        # new
        for word in line:
            # word = unicode(word)
            cleanFile.write(word.replace(".", " "))

    origFile.close()
    cleanFile.close()

    print("File cleaned")

    with open(cleanFilename, "r") as f:

        for line in f:
            message = line.split()

            if len(message) >= 1:

                if len(message) > 1 and str(message[1]) == "-->":
                    time = message[0].split(",")
                    # print(time)

                    splitsecond = time[1]
                    time = time[0]
                    time = time.split(":")

                    time1 = (
                        int(time[0]) * 3600
                        + int(time[1]) * 60
                        + int(time[2])
                        + (int(splitsecond[:2]) / 100)
                    )
                    # print(time1)

                    time = message[2].split(",")
                    splitsecond = time[1]
                    time = time[0]
                    time = time.split(":")

                    time2 = (
                        int(time[0]) * 3600
                        + int(time[1]) * 60
                        + int(time[2])
                        + (int(splitsecond[:2]) / 100)
                    )

                    timestamp = [time1, time2]
                    # print(timestamp)

                elif message[0].isdigit() == False:
                    # Cleans punctuation and codes disfluencies as 'HES'
                    for word in message:
                        newWord = word
                        newWord = newWord.replace(",", " ")
                        newWord = newWord.replace("?", " ")
                        newWord = newWord.replace("!", " ")
                        newWord = newWord.replace(".", " ")
                        newWord = newWord.replace("-", " ")
                        newWord = newWord.replace('"', " ")
                        newWord = newWord.replace("MWAH", "ONOM")
                        newWord = newWord.replace("UM", "HES")
                        newWord = newWord.replace("HM", "HES")
                        newWord = newWord.replace("AH", "HES")
                        newWord = newWord.replace("ER", "HES")
                        newWord = newWord.replace("EH", "HES")
                        newWord = newWord.replace("EM", "HES")
                        newWord = newWord.replace("UH", "HES")
                        newWord = newWord.replace("AHM", "HES")
                        newWord = newWord.replace("ERM", "HES")
                        newWord = newWord.replace("MM", "ONOM")
                        # newWord = newWord.split()
                        # print(newWord)
                        if newWord:
                            if len(newWord.split()) > 1:
                                for cut_word in newWord.split():
                                    # newRow = [
                                    #     cut_word,
                                    #     timestamp[0],
                                    #     timestamp[1],
                                    #     "Unmatched",
                                    # ]
                                    # #print(newRow)
                                    # df = df.append([newRow])
                                    token.append(cut_word)
                                    start_time.append(timestamp[0])
                                    end_time.append(timestamp[1])
                                    
                            else:
                                # print("TRUE")
                                newRow = [newWord, time1, time2, "Unmatched"]
                                # df.index
                                # print(newRow)
                                token.append(newWord)
                                start_time.append(timestamp[0])
                                end_time.append(timestamp[1])
    cleanFile.close()

    for row in df.itertuples():
        if row[1] == "HES":
            hes_count = hes_count + 1

    #df = df.reset_index(drop=True)
    #df.to_csv('test_df.csv')
    df = pd.DataFrame(list(zip(token, start_time,end_time)))

    print(f"Transcript translated, hes count is {hes_count}")

    return df, hes_count


def normalise(showID, time):

    normTime = (time - offsets[showID]) / (showLengths[showID] - offsets[showID])
    # print(f'ShowID is {showID}, normTime is {normTime}')

    if normTime > 1 or normTime < 0:
        print("WARNING: NORMALISED OVERFLOW")

    return normTime


def token_createFolder(fileName1, fileName2):

    global dataType

    if dataType == "Transcript":

        folder = (
            os.path.dirname(fileName1)
            + "/"
            + dataType
            + "_"
            + os.path.basename(fileName1).split("_")[1]
            + "_"
            + datetime.date.today().strftime("%Y")
            + datetime.date.today().strftime("%B")[0:3]
            + datetime.date.today().strftime("%d")
            + "_"
            + os.path.basename(fileName1).split("_")[4].split(".")[0]
            + "_"
            + os.path.basename(fileName2).split("_")[4].split(".")[0]
            + "_"
            + os.path.basename(fileName1).split("_")[3][0]
        )

    else:
        folder = (
            os.path.dirname(fileName1)
            + "/"
            + dataType
            + "_"
            + os.path.basename(fileName1).split("_")[1]
            + "_"
            + datetime.date.today().strftime("%Y")
            + datetime.date.today().strftime("%B")[0:3]
            + datetime.date.today().strftime("%d")
            + "_"
            + os.path.basename(fileName1).split("_")[4].split(".")[0]
            + "_"
            + os.path.basename(fileName1).split("_")[3][0]
        )

    if os.path.exists(folder):
        print("Folder already exists")
        folder2 = folder + "_" + "new"
        return folder2

    print(folder)
    os.makedirs(folder)

    return folder


def get_showID(transcriptFile, offsets, showLengths, shows):

    time = "NA"
    showID = 0

    transcriptFile = transcriptFile.split("/")[-1]

    # TODO: Change/add show data as appropriate
    if transcriptFile.split("_")[1][-2:] == "ComedianA":
        for c, show in enumerate(shows, 0):
            if transcriptFile.split("_")[-1][0:3] == show[0:3]:
                # print(show[0:3])
                showID = c
                break
        # This is for a show with intervals
        if transcriptFile.split("_")[-2][0] == "2":
            showID = showID + 5

    elif transcriptFile.split("_")[1][-2:] == "ComedianB":
        for c, show in enumerate(shows, 0):
            if transcriptFile.split("_")[-1][0:3] == show[0:3]:
                showID = c
                break

    elif transcriptFile.split("_")[1][-2:] == "LG":
        for c, show in enumerate(shows, 0):
            if transcriptFile.split("_")[-1][0:3] == show[0:3]:
                showID = c
                break
    else:
        showID = "NA"
        print("Unknown show source")
        return

    if showID != "NA":
        time = showLengths[showID] - offsets[showID]

    print("Show identified")

    return showID, time

#This is to test that code runs properly using sample data
#combo_extractMatches(
#    "TAMS_LG_Input_Files/Transcript_LG_1_cut_1Awards.txt",
#    "TAMS_LG_Input_Files/Transcript_LG_5_cut_5RedCarpet.txt",
#    "TAMS_LG_Input_Files/LG_Montage_1Award_Mic_Full.wav",
#    "TAMS_LG_Input_Files/LG_Montage_5RedCarpet_Mic_Full.wav",
#    "Transcript",
#    "LG",
#)
