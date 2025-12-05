
import java.io.File;
import java.util.Date;

// CHANGE ALL OF THESE DEPENDING ON WHAT YOU'RE ANALYSING
// Currently this code runs on the Lady Gaga example analysis

// Lady Gaga 


String[] titles = {"1Award","2Panel","3Chat","4Interview","5RedCarpet","6Colbert","7RedCarpet",
 "8RedCarpet","9Interview", "10Talk", "11Talk"};
 
 String imageName = "LG_transcriptmatch.png";
 
 int[] offsets =  {0,
 10,
 16,
 23,
 28,
 36,
 40,
 44,
 52,
 58,
 73};
 
 int[] baseOffsets = {0,
 10,
 16,
 22,
 28,
 36,
 40,
 44,
 52,
 58,
 73};
 
 int[] showLengths = {11,
 18,
 24,
 29,
 37,
 42,
 46,
 54,
 59,
 74,
 90};
 
int[] transcriptLengths = {373, 315, 313, 324, 
293, 348, 453, 428, 
365, 345, 515};
 
 int showNum = 11;
 
 String dir = "LG_Files";
 
 String[] audioNames = {"LG_Data/LG_Montage_1Award_Mic_Full.wav", "LG_Data/LG_Montage_2Panel_Mic_Full.wav",
 "LG_Data/LG_Montage_3Chat_Mic_Full.wav", "LG_Data/LG_Montage_4Interview_Mic_Full.wav",
 "LG_Data/LG_Montage_5RedCarpet_Mic_Full.wav", "LG_Data/LG_Montage_6Colbert_Mic_Full.wav",
 "LG_Data/LG_Montage_7RedCarpet_Mic_Full.wav", "LG_Data/LG_Montage_8RedCarpet_Mic_Full.wav",
 "LG_Data/LG_Montage_9Interview_Mic_Full.wav", "LG_Data/LG_Montage_10Talk_Mic_Full.wav",
 "LG_Data/LG_Montage_11Talk_Mic_Full.wav"};


////Scooby

////String dir = "Scooby6min_Unmatch";
////String dir = "Scooby_11Feb2020_6MIN_UnmatchedTables";
//String dir = "Scooby3MIN_UnmatchedTables";

//String[] audioNames ={"ComedianB_3Feb2018_Amb_Scooby.wav", 
//  "ComedianB_22Feb2018_Amb_Scooby.wav", 
//  "ComedianB_25Jun2018_Mic_Scooby.wav", 
//  "ComedianB_25Jul2018_Amb_Scooby.wav", 
//  "ComedianB_11Aug2018_Amb_Scooby.wav", 
//  "ComedianB_12Aug2018_Amb_Scooby.wav", 
//  "ComedianB_13Aug2018_Amb_Scooby.wav", 
//  "ComedianB_14Aug2018_Amb_Scooby.wav", 
//  "ComedianB_15Aug2018_Amb_Scooby.wav", 
//  "ComedianB_17Aug2018_Amb_Scooby.wav", 
//  "ComedianB_18Aug2018_Amb_Scooby.wav", 
//  "ComedianB_19Aug2018_Amb_Scooby.wav", 
//  "ComedianB_20Aug2018_Amb_Scooby.wav", 
//  "ComedianB_21Aug2018_Amb_Scooby.wav", 
//  "ComedianB_22Aug2018_Amb_Scooby.wav", 
//  "ComedianB_23Aug2018_Amb_Scooby.wav", 
//  "ComedianB_24Aug2018_Amb_Scooby.wav", 
//  "ComedianB_25Aug2018_Amb_Scooby.wav", 
//  "ComedianB_26Aug2018_Amb_Scooby.wav", 
//  "ComedianB_20Nov2018_Mic_Scooby.wav"};


//String[] titles = {"3Feb2018", "22Feb2018", "25Jun2018", "25Jul2018", 
//  "11Aug2018", "12Aug2018", "13Aug2018", "14Aug2018", 
//  "15Aug2018", "17Aug2018", "18Aug2018", "19Aug2018", 
//  "20Aug2018", "21Aug2018", "22Aug2018", "23Aug2018", 
//  "24Aug2018", "25Aug2018", "26Aug2018", "20Nov2018"};


//String[] files = {"Scooby/Unmatched_Chron/Transcript_ComedianB_3Feb2018_22Feb2018_Unmatched.csv", 
//  "Scooby/Unmatched_Chron/Transcript_ComedianB_11Aug2018_12Aug2018_Unmatched.csv", 
//  "Scooby/Unmatched_Chron/Transcript_ComedianB_12Aug2018_13Aug2018_Unmatched.csv", 
//  "Scooby/Unmatched_Chron/Transcript_ComedianB_13Aug2018_14Aug2018_Unmatched.csv", 
//  "Scooby/Unmatched_Chron/Transcript_ComedianB_14Aug2018_15Aug2018_Unmatched.csv", 
//  "Scooby/Unmatched_Chron/Transcript_ComedianB_15Aug2018_17Aug2018_Unmatched.csv", 
//  "Scooby/Unmatched_Chron/Transcript_ComedianB_17Aug2018_18Aug2018_Unmatched.csv", 
//  "Scooby/Unmatched_Chron/Transcript_ComedianB_18Aug2018_19Aug2018_Unmatched.csv", 
//  "Scooby/Unmatched_Chron/Transcript_ComedianB_19Aug2018_20Aug2018_Unmatched.csv", 
//  "Scooby/Unmatched_Chron/Transcript_ComedianB_20Aug2018_21Aug2018_Unmatched.csv", 
//  "Scooby/Unmatched_Chron/Transcript_ComedianB_21Aug2018_22Aug2018_Unmatched.csv", 
//  "Scooby/Unmatched_Chron/Transcript_ComedianB_22Aug2018_23Aug2018_Unmatched.csv", 
//  "Scooby/Unmatched_Chron/Transcript_ComedianB_22Feb2018_25Jun2018_Unmatched.csv", 
//  "Scooby/Unmatched_Chron/Transcript_ComedianB_23Aug2018_24Aug2018_Unmatched.csv", 
//  "Scooby/Unmatched_Chron/Transcript_ComedianB_24Aug2018_25Aug2018_Unmatched.csv", 
//  "Scooby/Unmatched_Chron/Transcript_ComedianB_25Aug2018_26Aug2018_Unmatched.csv", 
//  "Scooby/Unmatched_Chron/Transcript_ComedianB_25Jul2018_11Aug2018_Unmatched.csv", 
//  "Scooby/Unmatched_Chron/Transcript_ComedianB_25Jun2018_25Jul2018_Unmatched.csv", 
//  "Scooby/Unmatched_Chron/Transcript_ComedianB_26Aug2018_20Nov2018_Unmatched.csv"};

//String imageName = "ComedianB_Scooby_genetic";
//

//int[] offsets =  {0, 0, 0, 0, 0, 
//  0, 0, 0, 0, 0, 
//  0, 0, 0, 0, 0, 
//  0, 0, 0, 0, 0, 
//  0, 0, 0, 0, 0};
  
//int[] baseOffsets = {0, 0, 0, 0, 0, 
//  0, 0, 0, 0, 0, 
//  0, 0, 0, 0, 0, 
//  0, 0, 0, 0, 0, 
//  0, 0, 0, 0, 0};

//int[] showLengths = {99, 70, 75, 70, 
//  78, 77, 79, 81, 
//  65, 82, 85, 82, 
//  77, 73, 74, 69, 
//  70, 104, 82, 91};

//int[] transcriptLengths = {373, 315, 313, 324, 
//  293, 348, 453, 428, 
//  365, 345, 515, 471, 
//  463, 430, 424, 387, 
//  464, 626, 386, 408};

//int showNum = 20;
//int showMax = 20;


// General global values
float visHeight, visLen, gap, miniVisHeight;
String extension = ".png";
String folderName = "/Users/vanessa/Desktop/";
float matchX_a, matchX_b, matchX_c, matchX_d, minigap;
color c;
int max = 1000;
float[] coordinates = new float[(showNum+1)]; 
float[] minicoordinates = new float[(showNum*showNum+1)];
float counter1 = 0, counter2 = 0;
// int pairedNum = 8000; // Arbitrarily large number
Table table;
Table angleTable;
int drawn, zoom;
float zoomStart, zoomEnd;
//float[] transcript_ratios;

float alpha = 255;

// Numbers are length of audio in seconds

int subsetStart = 0;
int subsetEnd = 20000;
float[] ratios = new float[showNum];
float[] transcript_ratios = new float[showNum];
int backgroundCol = 255;
int fontsize = 20;


void setup() {
  //makeAngleTable();
  background(backgroundCol);
  size(1250, 700);
  String path = sketchPath()+"/"+dir;
  print(path);

  println("\nListing info about all files in a directory: ");

  noLoop();

  coordinates = drawBases();
  minicoordinates = drawMiniBases();

  /* Forward tests
   for (int i = 0; i < 10; i++){
   drawAllTranscripts(unmatchFiles[i]);
   }
   */

  strokeWeight(1);

  File[] files = listFiles(path);
  //print(files);
  print("Got here");
  for (int i = 0; i < files.length; i++) {
    File f = files[i];    
    println("Name: " + f.getName());
    println("Is directory: " + f.isDirectory());
    println("Size: " + f.length());
    String lastModified = new Date(f.lastModified()).toString();
    println("Last Modified: " + lastModified);
    println("-----------------------");
    drawAllTimeTranscripts(f.getName());
    //drawAllTranscripts(f.getName());
    print("Doing this");
  }

  //for (int i = 0; i < 10; i++) {
  //  drawAllTimeTranscripts(unmatchFiles[i]);
  //}


  /*
  for (int i = 0; i < 10; i++) {
   drawAllBackTimeTranscripts(unmatchFiles[i]);
   }
   */
  /*
  
   for (int i = 0; i < showNum-1; i++) {
   drawMatch(coordinates[0], coordinates[i+1], coordinates[i+2], files[i], i);
   }
   saveTable(angleTable, "angleTable.csv");
   
   */
}

void draw() {
}

void makeAngleTable() {

  angleTable = new Table();

  angleTable.addColumn("Show1");
  angleTable.addColumn("Norm_Show1");
  angleTable.addColumn("Show2");
  angleTable.addColumn("Norm_Show2");
  angleTable.addColumn("Length");
  angleTable.addColumn("Angle");
}

void addAngleRow(int id_show1, float xcoord_S1, int id_show2, float xcoord_S2) {

  String show1_name = titles[id_show1];
  String show2_name = titles[id_show2];

  float norm1 = (xcoord_S1-coordinates[0])/visLen;
  float norm2 = (xcoord_S2-coordinates[0])/visLen;

  float angleData[] = getAngle(xcoord_S1, xcoord_S2);
  //line_length = getLength();

  TableRow newRow = angleTable.addRow();
  newRow.setString("Show1", show1_name);
  newRow.setFloat("Norm_Show1", norm1);

  newRow.setString("Show2", show2_name);
  newRow.setFloat("Norm_Show2", norm2);

  newRow.setFloat("Length", angleData[0]);
  newRow.setFloat("Angle", angleData[1]);
}

float[] getAngle(float xcoord_S1, float xcoord_S2) {

  float diff = xcoord_S1-xcoord_S2;
  float angle;

  float hyp = sqrt(sq(diff)+sq(gap));

  if (diff < 0) {
    angle = 90-degrees(asin(abs(diff)/hyp));
    println("Show 1 smaller");
  } else {

    angle = degrees(asin(abs(diff)/hyp))+90;
    println("Show 2 smaller");
  }

  float angleData[] = {hyp, angle};

  println(angle);
  //println(hyp);

  return angleData;
} 

float[] drawBases() {

  println("Drawing bases");

  visHeight = height/(showNum+3);
  visLen = width*0.75;

  //println(width); 
  float visX = (width-visLen)/2;
  coordinates[0] = visX;
  //println(visX);
  int wordHeight = 10;
  
  for (int i = 1; i <= showNum; i++) {
    strokeWeight(1);
    fill(255);
    float yCoord = ((height*i)/(showNum+1))-(visHeight/2);
    rect(visX, yCoord, visLen, visHeight);
    coordinates[i] = yCoord;
    textSize(fontsize);
    fill(0);
    textAlign(RIGHT);
    //if ((i % 2) == 1){
    text(titles[i-1], visX-wordHeight, yCoord+(visHeight/2)+5);
  }

  if (subsetStart > 0 && subsetEnd < showLengths[showNum-1] 
    && subsetEnd < showLengths[showNum-1]) {
    int minute = floor(subsetStart/60);
    int seconds = subsetStart%60;
    int minute2 = floor(subsetEnd/60);
    int seconds2 = subsetEnd%60;
    String timestamp1, timestamp2;

    if (seconds < 10 && seconds2 < 10) {
      timestamp1 = str(minute) + ':' + '0' + str(seconds);
      timestamp2 = str(minute2) + ':' + str(seconds2);
    } else if (seconds > 10 && seconds2 < 10) {
      timestamp1 = str(minute) + ':' + str(seconds);
      timestamp2 =str(minute2) + ':' + '0' + str(seconds2);
    } else if (seconds < 10 && seconds2 > 10) {
      timestamp1 = str(minute) + ':' + '0' + str(seconds);
      timestamp2 = str(minute2) + ':' + str(seconds2);
    } else {
      timestamp1 = str(minute) + ':' + str(seconds);
      timestamp2 = str(minute2) + ':' + str(seconds2);
    }

    text(timestamp1, visX, coordinates[showNum]+visHeight+20);
    text(timestamp1, visX, coordinates[1]-5);
    text(timestamp2, visX+visLen-40, coordinates[showNum]+visHeight+20);
    text(timestamp2, visX+visLen-40, coordinates[1]-5);
  }

  gap = coordinates[2]-coordinates[1]-visHeight;
  return coordinates;
}

float[] drawMiniBases() {
  //void drawMiniBases(float top) {

  println("Drawing bases");

  //float miniHeight = visHeight;
  miniVisHeight = (visHeight/(showNum+2));
  //miniVisLen = width*0.8;

  //println(width); 
  float visX = (width-visLen)/2;
  //coordinates[0] = visX;
  //println(visX);

  minicoordinates[0] = visX;
  strokeWeight(1);

  for (int j = 0; j < showNum; j++) {
    float top = coordinates[j+1];

    for (int i = 1; i <= showNum; i++) {
      fill(255);
      if (i == j+1) {
        fill(0);
      }
      //float yCoord = ((height*i)/(showNum+1))-(visHeight/2);
      // will need to change height obvs
      //float yCoord = ((height*i)/(showNum+1))-(visHeight/2)top;
      float yCoord = top+((visHeight*i)/(showNum+1))-miniVisHeight/2;
      rect(visX, yCoord, visLen, miniVisHeight);
      minicoordinates[j*showNum+i] = yCoord;
      textSize(7);
      fill(0);

      // Write mininames
      //textAlign(RIGHT);
      //if ((i % 2) == 1){
      //text(titles[i-1], width-visX/4-5, yCoord+(miniVisHeight/2)+5);
    }
  }

  if (subsetStart > 0 && subsetEnd < showLengths[showNum-1] 
    && subsetEnd < showLengths[showNum-1]) {
    int minute = floor(subsetStart/60);
    int seconds = subsetStart%60;
    int minute2 = floor(subsetEnd/60);
    int seconds2 = subsetEnd%60;
    String timestamp1, timestamp2;

    if (seconds < 10 && seconds2 < 10) {
      timestamp1 = str(minute) + ':' + '0' + str(seconds);
      timestamp2 = str(minute2) + ':' + str(seconds2);
    } else if (seconds > 10 && seconds2 < 10) {
      timestamp1 = str(minute) + ':' + str(seconds);
      timestamp2 =str(minute2) + ':' + '0' + str(seconds2);
    } else if (seconds < 10 && seconds2 > 10) {
      timestamp1 = str(minute) + ':' + '0' + str(seconds);
      timestamp2 = str(minute2) + ':' + str(seconds2);
    } else {
      timestamp1 = str(minute) + ':' + str(seconds);
      timestamp2 = str(minute2) + ':' + str(seconds2);
    }

    text(timestamp1, visX, coordinates[showNum]+visHeight+20);
    text(timestamp1, visX, coordinates[1]-5);
    text(timestamp2, visX+visLen-40, coordinates[showNum]+visHeight+20);
    text(timestamp2, visX+visLen-40, coordinates[1]-5);
  }

  minigap = minicoordinates[2]-minicoordinates[1]-miniVisHeight;
  return minicoordinates;
}


void drawAllTranscripts(String file) { // NB Start show ID

  String filename = dir + "/" + file;
  readTable(filename);


  c = color(255);

  float showX = coordinates[0];
  //float show1Y = firstY;
  //float show2Y = secondY;
  //float ratio1, ratio2;
  println("Subsets");
  //println(subsetStart);
  //println(subsetEnd);

  // TODO: new ratios

  // This removes offsets
  // new colors
  //TODO: figure out snazzy y coordinates
  //float transcriptStart = 0;
  int factor1 = 0;
  int factor2 = 0;
  int boundaryHes = 0;
  int boundaryDisc = 0;
  int newMatch = 0;
  noStroke();

  println(table.getRowCount());

  for (int i = 0; i<table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    int index = i;
    //int audio_start = row.getInt("Start");
    //int audio_end = row.getInt("End");
    String word = row.getString("Word");
    String status = row.getString("Status");
    String type = row.getString("Type");
    String show1 = row.getString("Show1");
    String show2 = row.getString("Show2");
    int dist = row.getInt("Distance");

    for (int j = 0; j < showNum; j++) {
      if (show1.equals(audioNames[j]) == true) {
        factor1 = j;
      }
    }

    for (int k = 0; k < showNum; k++) {
      if (show2.equals(audioNames[k]) == true) {
        factor2 = k;
        // println(audioNames[k]);
      }
    }

    // println("Factors are:");
    //println(factor1, factor2);

    calculateTranscriptRatios(factor1);

    float yshow = minicoordinates[factor1*showNum+factor2+1];

    println("Transcript Ratio");
    print(transcript_ratios[factor1]);
    //println("Index");
    //print(index*transcript_ratios);

    matchX_a = showX+((index-subsetStart)*transcript_ratios[factor1]);
    matchX_b = showX+((index-subsetStart+1)*transcript_ratios[factor1]);

    //println("xcoord");
    //println(matchX_a, matchX_b);
    //print("match status is");
    //println(status);

    //print("word is:");
    //println(word);
    /*
  // Draws Matches in Black, Hes in Red, Discourse in Blue
     if (status.equals("Matched") == true) {
     c = color(0);
     fill(c);
     if (word.equals("HES") == true) {
     c = color(255, 0, 0);
     fill(c);
     //println("Hes match");
     rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
     } else if (word.equals("So") == true || word.equals("so") == true ||
     word.equals("and") == true || word.equals("And") == true || 
     word.equals("like") == true || word.equals("Like") == true) {
     c = color(0, 0, 255);
     fill(c);
     rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
     //println("Discourse match");
     //rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight);
     } else { 
     // println("No match");
     
     } 
     rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight);
     } else {
     if (word.equals("HES") == true) {
     c = color(255, 0, 0);
     fill(c);
     //println("Hes match");
     rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
     } else if (word.equals("So") == true || word.equals("so") == true ||
     word.equals("and") == true || word.equals("And") == true || 
     word.equals("like") == true || word.equals("Like") == true) {
     c = color(0, 0, 255);
     fill(c);
     rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
     }
     }
     
     
     // This draws matches in different colours depending on what preceded them (disc or hes)
     
     if (type.equals("Boundary") == true && newMatch == 1 || type.equals("Free") == true && newMatch == 1) {
     newMatch = 0;
     boundaryHes = boundaryDisc = 0;
     }
     
     // if (type.equals("Boundary") == true) {
     if (abs(dist) == 1) {
     //newMatch = 1;
     
     if (word.equals("HES") == true) {
     //c = color(255, 0, 0);
     //println("Hes match");
     //rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
     boundaryHes = 1;
     } else if (word.equals("So") == true || word.equals("so") == true ||
     //word.equals("and") == true || word.equals("And") == true || 
     word.equals("like") == true || word.equals("Like") == true) {
     //c = color(255, 0, 0);
     boundaryDisc = 1;
     // fill(c);
     }
     }
     
     if (status.equals("Matched") == true) {
     newMatch = 1;
     if (boundaryHes == 1) {
     fill(color(255, 0, 0, alpha));
     } 
     
     if (boundaryDisc == 1) {
     fill(color(0, 0, 255, alpha));
     } else if (boundaryHes == 0 && boundaryDisc == 0) {
     fill(color(0, 0, 0, alpha));
     } else if (boundaryHes == 1 && boundaryDisc == 1) {
     fill(color(0, 0, 255, alpha));
     }
     fill(color(0, 0, 0));
     rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight);
     }
     }
     
     if (word.equals("HES") == true) {
     c = color(255, 0, 0);
     fill(c);
     //println("Hes match");
     rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
     } else if (word.equals("So") == true || word.equals("so") == true ||
     word.equals("and") == true || word.equals("And") == true || 
     word.equals("like") == true || word.equals("Like") == true) {
     c = color(0, 0, 255);
     fill(c);
     rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
     //println("Discourse match");
     //rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight);
     } else { 
     // println("No match");
     
     } 
     rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight);
     } else {
     
     }
     
     
     //fill(c);
     //stroke(50);
     //rect(matchX_a, yshow, matchX_b, miniVisHeight);
     //rect(matchX_a, yshow, matchX_a+10, miniVisHeight);
     //println("yshow");
     //print(matchX_b-matchX_a);
     //rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight);
     
     // float show1_percent = (counter1/(showLengths[tableID]-offsets[tableID]))*100;
     //float show2_percent = (counter2/(showLengths[tableID+1]-offsets[tableID+1]))*100;
     //String show1msg = str(show1_percent);
     // String show2msg = str(show2_percent);
     
     //textSize(14);
     //fill(0);
     //textAlign(CENTER);
     
     //text(show1msg, (showX+visLen+(width-showX-visLen)/2), (show1Y+(visHeight/2))); 
     // text(show2msg, (showX+visLen+(width-showX-visLen)/2), (show2Y+(visHeight/2)));
    /*
     println("Counter values");
     print(counter1);
     print(counter2);
     println("Show 1 percent is:");
     println(show1_percent);
     println("Show 2 percent is:");
     println(show2_percent);
     
     counter1 = counter2 = 0;
     
     //save(imageName);
     
     
     //if (i%1000 == 0) {
     // println(i);
     //  println(factor1, factor2);
     */
  }
}

void drawAllTimeTranscripts(String filename) { // NB Start show ID

  //print(filename);
  String file = dir + "/" + filename;
  print(file);
  readTable(file);

  c = color(255);

  float showX = coordinates[0];

  int factor1 = 0;
  int factor2 = 0;
  int boundaryHes = 0;
  int boundaryDisc = 0;
  int newMatch = 0;
  noStroke();

  //println(table.getRowCount());

  for (int i = 0; i<table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    //int index = row.getInt("Index");
    int audio_start = row.getInt("Start");
    int audio_end = row.getInt("End");
    String word = row.getString("Word");
    String status = row.getString("Match_status");
    String type = row.getString("Type");
    String show1 = row.getString("Show1");
    String show2 = row.getString("Show2");
    int dist = row.getInt("Distance");

    for (int j = 0; j < showNum; j++) {
      if (show1.equals(audioNames[j]) == true) {
        factor1 = j;
        //print("Factor 1:");
        //println(audioNames[j]);
      }
    }

    for (int k = 0; k < showNum; k++) {
      if (show2.equals(audioNames[k]) == true) {
        factor2 = k;
        //print("Factor 2:");
        //println(audioNames[k]);
      }
    }

    if (factor1 == factor2) {
      break;
    };

    calculateRatios(factor1);

    float yshow = minicoordinates[factor1*showNum+factor2+1];

    //matchX_a = showX+((index-subsetStart)*transcript_ratios[factor1]);
    //matchX_b = showX+((index-subsetStart+1)*transcript_ratios[factor1]);

    //Time
    matchX_a = showX+((audio_start-offsets[factor1])*ratios[factor1]);

    matchX_b = showX+((audio_end-offsets[factor1])*ratios[factor1]);
    //println((audio_start-offsets[factor1])*ratios[factor1]);
    println(matchX_b);

    if (type.equals("Boundary") == true && newMatch == 1 || type.equals("Free") == true && newMatch == 1) {
      newMatch = 0;
      boundaryHes = boundaryDisc = 0;
    }

    // if (type.equals("Boundary") == true) {
    if (abs(dist) == 1) {
      //newMatch = 1;

      if (word.equals("HES") == true) {
        //c = color(255, 0, 0);
        //println("Hes match");
        //rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
        boundaryHes = 1;
      } else if (word.equals("So") == true || word.equals("so") == true ||
        //word.equals("and") == true || word.equals("And") == true || 
        word.equals("like") == true || word.equals("Like") == true) {
        // c = color(255, 0, 0);
        boundaryDisc = 1;
        // fill(c);
      }
    }

    if (status.equals("Matched") == true) {

      fill(color(0, 0, 0, alpha));
      newMatch = 1;
      /*
     if (boundaryHes == 1) {
       fill(color(255, 0, 0, alpha));
       } 
       
       if (boundaryDisc == 1) {
       fill(color(0, 0, 255, alpha));
       } else if (boundaryHes == 0 && boundaryDisc == 0) {
       fill(color(0, 0, 0, alpha));
       } else if (boundaryHes == 1 && boundaryDisc == 1) {
       fill(color(0, 0, 255, alpha));
       }
       fill(color(0, 0, 0, alpha));
       */
      //rect(matchX_a, yshow+miniVisHeight/3, matchX_b-matchX_a, miniVisHeight-miniVisHeight/3);
      rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight);
    }

    /*
    if (word.equals("HES") == true) {
     c = color(0, 255, 0);
     //println("Hes match");
     //rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
     boundaryHes = 1;
     fill(c);
     //rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight);
     } else if (word.equals("So") == true || word.equals("so") == true ||
     word.equals("and") == true || word.equals("And") == true || 
     word.equals("like") == true || word.equals("Like") == true ||
     word.equals("i") == true || word.equals("I") == true) {
     c = color(0, 100, 100);
     boundaryDisc = 1;
     fill(c);
     rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight);
     }
     */
  }
}




void drawAllBackTimeTranscripts(String filename) { // NB Start show ID

  readTable(filename);

  c = color(255);

  float showX = coordinates[0];
  //float show1Y = firstY;
  //float show2Y = secondY;
  //float ratio1, ratio2;
  //println("Subsets");
  //println(subsetStart);
  //println(subsetEnd);

  // TODO: new ratios

  // This removes offsets
  // new colors
  //TODO: figure out snazzy y coordinates
  //float transcriptStart = 0;
  int factor1 = 0;
  int factor2 = 0;
  int boundaryHes = 0;
  int boundaryDisc = 0;
  int newMatch = 0;
  noStroke();

  //println(table.getRowCount());

  for (int i = table.getRowCount()-1; i>=0; i--) {
    TableRow row = table.getRow(i);
    int index = row.getInt("Index");
    int audio_start = row.getInt("Start");
    int audio_end = row.getInt("End");
    String word = row.getString("Word");
    String status = row.getString("Status");
    String type = row.getString("Type");
    String show1 = row.getString("Show1");
    String show2 = row.getString("Show2");
    int dist = row.getInt("Distance");

    for (int j = 0; j < showNum; j++) {
      if (show1.equals(audioNames[j]) == true) {
        factor1 = j;
      }
    }

    for (int k = 0; k < showNum; k++) {
      if (show2.equals(audioNames[k]) == true) {
        factor2 = k;
        // println(audioNames[k]);
      }
    }


    calculateRatios(factor1);

    float yshow = minicoordinates[factor1*showNum+factor2+1];

    //matchX_a = showX+((index-subsetStart)*transcript_ratios[factor1]);
    //matchX_b = showX+((index-subsetStart+1)*transcript_ratios[factor1]);

    //Time
    matchX_a = showX+((audio_start-offsets[factor1])*ratios[factor1]);
    matchX_b = showX+((audio_end-offsets[factor1])*ratios[factor1]);
    println((audio_start-offsets[factor1])*ratios[factor1]);

    if (type.equals("Boundary") == true && newMatch == 1 || type.equals("Free") == true && newMatch == 1) {
      newMatch = 0;
      boundaryHes = boundaryDisc = 0;
    }

    // if (type.equals("Boundary") == true) {
    if (abs(dist) == 1) {
      //newMatch = 1;

      if (word.equals("HES") == true) {
        //c = color(255, 0, 0);
        //println("Hes match");
        //rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
        boundaryHes = 1;
      } else if (word.equals("So") == true || word.equals("so") == true ||
        //word.equals("and") == true || word.equals("And") == true || 
        word.equals("like") == true || word.equals("Like") == true) {
        //c = color(255, 0, 0);
        boundaryDisc = 1;
        // fill(c);
      }
    }

    if (status.equals("Matched") == true) {

      newMatch = 1;
      if (boundaryHes == 1) {
        fill(color(255, 0, 0, alpha));
      } 

      if (boundaryDisc == 1) {
        fill(color(0, 0, 255, alpha));
      } else if (boundaryHes == 0 && boundaryDisc == 0) {
        fill(color(0, 0, 0, alpha));
      } else if (boundaryHes == 1 && boundaryDisc == 1) {
        fill(color(0, 0, 255, alpha));
      }
      // fill(color(0, 0, 0));
      rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight/3);
    }
  }
}

/*
      if (word.equals("HES") == true) {
 c = color(255, 0, 0);
 fill(c);
 //println("Hes match");
 rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
 } else if (word.equals("So") == true || word.equals("so") == true ||
 word.equals("and") == true || word.equals("And") == true || 
 word.equals("like") == true || word.equals("Like") == true) {
 c = color(0, 0, 255);
 fill(c);
 rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
 //println("Discourse match");
 //rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight);
 } else { 
 // println("No match");
 
 } 
 rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight);
 } else {
 
 }
 
 }
 
 void drawAllBackTranscripts(String filename) { // NB Start show ID
 
 readTable(filename);
 
 c = color(255);
 
 float showX = coordinates[0];
 //float show1Y = firstY;
 //float show2Y = secondY;
 //float ratio1, ratio2;
 println("Subsets");
 //println(subsetStart);
 //println(subsetEnd);
 
 // TODO: new ratios
 
 // This removes offsets
 // new colors
 //TODO: figure out snazzy y coordinates
 //float transcriptStart = 0;
 int factor1 = 0;
 int factor2 = 0;
 int boundaryHes = 0;
 int boundaryDisc = 0;
 int newMatch = 0;
 noStroke();
 
 println(table.getRowCount());
 
 for (int i = table.getRowCount()-1; i>0; i--) {
 //print(i);
 TableRow row = table.getRow(i);
 int index = row.getInt("Index");
 //int audio_start = row.getInt("Start");
 //int audio_end = row.getInt("End");
 String word = row.getString("Word");
 String status = row.getString("Status");
 String type = row.getString("Type");
 String show1 = row.getString("Show1");
 String show2 = row.getString("Show2");
 int dist = row.getInt("Distance");
 
 for (int j = 0; j < showNum; j++) {
 if (show1.equals(audioNames[j]) == true) {
 factor1 = j;
 }
 }
 
 for (int k = 0; k < showNum; k++) {
 if (show2.equals(audioNames[k]) == true) {
 factor2 = k;
 // println(audioNames[k]);
 }
 }
 
 // println("Factors are:");
 //println(factor1, factor2);
 
 calculateTranscriptRatios(factor1);
 
 float yshow = minicoordinates[factor1*showNum+factor2+1];
 
 //println("Transcript Ratio");
 //print(transcript_ratios[factor1]);
 //println("Index");
 //print(index*transcript_ratios);
 
 matchX_a = showX+((index-subsetStart)*transcript_ratios[factor1]);
 matchX_b = showX+((index-subsetStart-1)*transcript_ratios[factor1]);
 
 //println("xcoord");
 //println(matchX_a, matchX_b);
 //print("match status is");
 //println(status);
 
 //print("word is:");
 //println(word);
/*
 // Draws Matches in Black, Hes in Red, Discourse in Blue
 if (status.equals("Matched") == true) {
 c = color(0);
 fill(c);
 if (word.equals("HES") == true) {
 c = color(255, 0, 0);
 fill(c);
 //println("Hes match");
 rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
 } else if (word.equals("So") == true || word.equals("so") == true ||
 word.equals("and") == true || word.equals("And") == true || 
 word.equals("like") == true || word.equals("Like") == true) {
 c = color(0, 0, 255);
 fill(c);
 rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
 //println("Discourse match");
 //rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight);
 } else { 
 // println("No match");
 
 } 
 rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight);
 } else {
 if (word.equals("HES") == true) {
 c = color(255, 0, 0);
 fill(c);
 //println("Hes match");
 rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
 } else if (word.equals("So") == true || word.equals("so") == true ||
 word.equals("and") == true || word.equals("And") == true || 
 word.equals("like") == true || word.equals("Like") == true) {
 c = color(0, 0, 255);
 fill(c);
 rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
 }
 }
 
 
 // This draws matches in different colours depending on what preceded them (disc or hes)
 
 if (type.equals("Boundary") == true && newMatch == 1 || type.equals("Free") == true && newMatch == 1) {
 newMatch = 0;
 boundaryHes = boundaryDisc = 0;
 }
 
 //if (type.equals("Boundary") == true) {
 if (abs(dist) == 1) {
 //newMatch = 1;
 
 if (word.equals("HES") == true) {
 //c = color(255, 0, 0);
 //println("Hes match");
 //rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
 boundaryHes = 1;
 } else if (word.equals("So") == true || word.equals("so") == true ||
 word.equals("and") == true || word.equals("And") == true || 
 word.equals("like") == true || word.equals("Like") == true) {
 //c = color(255, 0, 0);
 boundaryDisc = 1;
 // fill(c);
 }
 }
 
 //To do full backwards (all categories)
 if (status.equals("Matched") == true) {
 newMatch = 1;
 if (boundaryHes == 1) {
 fill(color(255, 0, 0, alpha));
 } else if (boundaryDisc == 1) {
 fill(color(0, 0, 255, alpha));
 } else if (boundaryHes == 0 && boundaryDisc == 0) {
 fill(color(0, 0, 0, alpha));
 } else if (boundaryHes == 1 && boundaryDisc == 1) {
 fill(color(0, 255, 0, alpha));
 }
 //rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight);
 rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight/3);
 //println("Matched");
 }
 }
 
/*
 
 // To do only hesitation backwards
 
 if (status.equals("Matched") == true) {
 newMatch = 1;
 if (boundaryHes == 1) {
 fill(color(255, 0, 0, alpha));
 rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight);
 }
 }
 */
/*
      if (word.equals("HES") == true) {
 c = color(255, 0, 0, alpha);
 fill(c);
 //println("Hes match");
 rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
 } else if (word.equals("So") == true || word.equals("so") == true ||
 word.equals("and") == true || word.equals("And") == true || 
 word.equals("like") == true || word.equals("Like") == true) {
 c = color(0, 0, 255, alpha);
 fill(c);
 rect(matchX_a, yshow-5, matchX_b-matchX_a, miniVisHeight+5);
 //println("Discourse match");
 //rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight);
 } else { 
 // println("No match");
 
 } 
 rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight);
 } else {
 
 }
 
 
 //fill(c);
 //stroke(50);
 //rect(matchX_a, yshow, matchX_b, miniVisHeight);
 //rect(matchX_a, yshow, matchX_a+10, miniVisHeight);
 //println("yshow");
 //print(matchX_b-matchX_a);
 //rect(matchX_a, yshow, matchX_b-matchX_a, miniVisHeight);
 
 // float show1_percent = (counter1/(showLengths[tableID]-offsets[tableID]))*100;
 //float show2_percent = (counter2/(showLengths[tableID+1]-offsets[tableID+1]))*100;
 //String show1msg = str(show1_percent);
 // String show2msg = str(show2_percent);
 
 //textSize(14);
 //fill(0);
 //textAlign(CENTER);
 
 //text(show1msg, (showX+visLen+(width-showX-visLen)/2), (show1Y+(visHeight/2))); 
 // text(show2msg, (showX+visLen+(width-showX-visLen)/2), (show2Y+(visHeight/2)));
/*
 println("Counter values");
 print(counter1);
 print(counter2);
 println("Show 1 percent is:");
 println(show1_percent);
 println("Show 2 percent is:");
 println(show2_percent);
 
 counter1 = counter2 = 0;
 
 //save(imageName);
 
 */
//if (i%1000 == 0) {
// println(i);
//  println(factor1, factor2);
//}

void readTable(String tableName) {
  //print(tableName);
  table = new Table();

  table = loadTable(tableName, "header");
  println("Table loaded");

  //for (int i = 0; i <3; i++) {
  //  TableRow row = table.getRow(i);
  //String string = row.getString("Seq_Length");
  // println(string);
  //}

  table.addColumn("matchX_start");
  table.addColumn("matchX_end");
  table.addColumn("matchY_start");
  table.addColumn("matchY_end");
  table.addColumn("matchLen");
}


void drawMatch(float xCoord, float firstY, float secondY, String filename, int tableID) { // NB Start show ID

  String file = dir + "/" + filename;
  //print(file);
  readTable(file);
  stroke(1);

  float showX = xCoord;
  float show1Y = firstY;
  float show2Y = secondY;
  //float ratio1, ratio2;
  println("Subsets");
  println(subsetStart);
  println(subsetEnd);

  calculateRatios(tableID);

  for (int i = 0; i<table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    int start = row.getInt("Audio_start");
    int end = row.getInt("Audio_end");
    String status = row.getString("Status");

    //if (status.equals("Cross") == false) {
    if (status.equals("FP") == false) {
      if (i%2 == 0) {
        matchX_a = showX+((start-subsetStart-offsets[tableID])*ratios[tableID]);
        matchX_b = showX+((end-subsetStart-offsets[tableID])*ratios[tableID]);
        float matchLen = (matchX_b-matchX_a);
        counter1 = counter1 + (row.getInt("Audio_end")-row.getInt("Audio_start"));
        row.setFloat("matchX_start", matchX_a);
        row.setFloat("matchX_end", matchX_b);
        row.setFloat("matchY_start", show1Y);
        row.setFloat("matchY_end", show1Y+visHeight);
        row.setFloat("matchLen", matchLen);

        c = color(98, 244, 66);

        drawn = 0;

        if (row.getInt("Audio_start") >= subsetStart 
          && row.getFloat("Audio_end") <= subsetEnd) {
          drawRectangle(i, c, tableID);
          drawn = 1;
        }
      }
      if (i%2 != 0) {
        matchX_c = showX+((start-subsetStart-offsets[tableID+1])*ratios[tableID+1]);
        matchX_d = showX+((end-subsetStart-offsets[tableID+1])*ratios[tableID+1]);
        float matchLen = (matchX_d-matchX_c);
        counter2 = counter2 + (row.getInt("Audio_end")-row.getInt("Audio_start"));
        row.setFloat("matchX_start", matchX_c);
        row.setFloat("matchX_end", matchX_d);
        row.setFloat("matchY_start", show2Y);
        row.setFloat("matchY_end", show2Y+visHeight);
        row.setFloat("matchLen", matchLen);

        c = color(68, 235, 244);

        if (row.getInt("Audio_start") >= subsetStart 
          && row.getFloat("Audio_end") <= subsetEnd) {
          drawRectangle(i, c, tableID);

          if (drawn == 1) {

            line(matchX_a, coordinates[tableID+1]+visHeight, matchX_c, coordinates[tableID+2]);
            addAngleRow(tableID, matchX_a, tableID+1, matchX_c);
            line(matchX_b, coordinates[tableID+1]+visHeight, matchX_d, coordinates[tableID+2]);
            addAngleRow(tableID, matchX_b, tableID+1, matchX_d);
          }
        }
        drawn = 0;
      }
    }
  }

  float show1_percent = (counter1/(showLengths[tableID]-offsets[tableID]))*100;
  float show2_percent = (counter2/(showLengths[tableID+1]-offsets[tableID+1]))*100;
  String show1msg = str(show1_percent);
  String show2msg = str(show2_percent);

  textSize(14);
  fill(0);
  textAlign(CENTER);

  //text(show1msg, (showX+visLen+(width-showX-visLen)/2), (show1Y+(visHeight/2))); 
  // text(show2msg, (showX+visLen+(width-showX-visLen)/2), (show2Y+(visHeight/2)));
  /*
  println("Counter values");
   print(counter1);
   print(counter2);
   println("Show 1 percent is:");
   println(show1_percent);
   println("Show 2 percent is:");
   println(show2_percent);
   */
  counter1 = counter2 = 0;

  //save(imageName);
}

void mousePressed() {

  testZoom();
  //testPair();

  if (mouseX < coordinates[0] || mouseX > coordinates[0]+visLen) {
    subsetStart = 0;
    subsetEnd = 20000;
    println("Subsets re-adjusted");
    //print(subsetStart);

    background(backgroundCol);
    drawMiniBases();
    //for (int j = 0; j < showNum-1; j++) {
    //  drawMatch(coordinates[0], coordinates[j+1], coordinates[j+2], files[j], j);
  }

  println("Done processing click");
}

/*
void drawPair(int tableID, int pairedNum) {
 
 int wordHeight = 10;
 
 if (pairedNum != 8000) {
 if (pairedNum%2 != 0) {
 pairedNum = pairedNum - 1;
 }
 
 drawMatch(coordinates[0], coordinates[tableID+1], 
 coordinates[tableID+2], files[tableID], tableID);
 
 for (int i = pairedNum; i <= pairedNum+1; i++) {
 TableRow row = table.getRow(i);
 int minute = floor((row.getInt("Audio_start")/60));
 int seconds = (row.getInt("Audio_start")%60);
 int minute2 = floor((row.getInt("Audio_end")/60));
 int seconds2 = (row.getInt("Audio_end")%60);
 String timestamp;
 
 if (seconds < 10 && seconds2 < 10) {
 timestamp = str(minute) + ':' + '0' + str(seconds) + " to " 
 + str(minute2) + ':' + str(seconds2);
 } else if (seconds > 10 && seconds2 < 10) {
 timestamp = str(minute) + ':' + str(seconds) + " to " + str(minute2) + ':' + '0' + str(seconds2);
 } else if (seconds < 10 && seconds2 > 10) {
 timestamp = str(minute) + ':' + '0' + str(seconds) + " to " + str(minute2) + ':' + str(seconds2);
 } else {
 timestamp = str(minute) + ':' + str(seconds) + " to " 
 + str(minute2) + ':' + str(seconds2);
 }
 
 String id = "Audio ID is: " + row.getString("Seq_Length");
 
 float xlocation = visLen+(width*0.15);
 float ylocation;
 float ylocationC = (coordinates[1])/2+(visHeight/4)- wordHeight;
 float ylocationD = coordinates[showNum]+visHeight+(visHeight/4);
 //(height-coordinates[showNum]+visHeight)/2;
 
 if (i%2 == 0) {
 ylocation = coordinates[tableID+1]+visHeight/2;
 //ylocation = row.getFloat("matchY_start")-offset;
 
 fill(0);
 textSize(14);
 //String content = '"'+ row.getString("Seq_Name (with buffer 3 on each side)")+ '"';
 String content = '"'+ row.getString("TEXT")+ '"';
 text(content, width/2, ylocationC);
 } else {
 ylocation = coordinates[tableID+2]+visHeight/2;
 //ylocation = row.getFloat("matchY_end")+offset*2+10;
 
 fill(0);
 textSize(14);
 //String content = '"'+ row.getString("Seq_Name (with buffer 3 on each side)")+ '"';
 String content = '"'+ row.getString("TEXT")+ '"';
 text(content, width/2, ylocationD);
 }
 
 textSize(14);
 fill(0);
 textAlign(CENTER);
 text(timestamp, xlocation, ylocation);
 float midPoint = ((coordinates[tableID+2]-coordinates[tableID+1])/2)+coordinates[tableID+1]+visHeight/2;
 text(id, xlocation, midPoint);
 
 c = color(226, 21, 6);
 
 if (row.getInt("Audio_start") > subsetStart &&
 row.getInt("Audio_end") <= subsetEnd) {
 drawRectangle(i, c, tableID);
 }
 }
 }
 }
 */
void drawRectangle(int rowNum, color fillColor, int tableID) {
  //println("Drawing rectangle");
  TableRow row = table.getRow(rowNum);

  fill(fillColor);
  stroke(50);
  // println(fillColor);
  rect(row.getFloat("matchX_start"), row.getFloat("matchY_start"), row.getFloat("matchLen"), visHeight);
  //println(row.getFloat("matchLen"));
}

void mouseDragged() {

  for (int i = 0; i<showNum; i++) {
    if (mouseX > coordinates[0] && mouseX < coordinates[0]+visLen) {
      if (mouseY > coordinates[i] && mouseY < coordinates[i]+visLen) {
        zoom = 1;
        println("Zoom activated");
      }
    }
  }
}

void mouseReleased() {
  // for (int k = 0; k < showNum-1; k++) {

  //   drawMatch(coordinates[0], coordinates[k+1], coordinates[k+2], files[k], k);

  //println("Zoom is:");
  //print(zoom);

  for (int i = 1; i<=showNum; i++) {
    if (mouseX > coordinates[0] && mouseX < coordinates[0]+visLen) {
      if (mouseY > coordinates[i] && mouseY < coordinates[i]+visHeight) {
        if (zoom == 1) {
          subsetStart = int(zoomStart);
          subsetEnd = int((mouseX-coordinates[0])/transcript_ratios[i-1]);
          println("second mouse x");
          println(mouseX);
          println(transcript_ratios[i-1]);
          background(backgroundCol);
          drawMiniBases();
          // for (int j = 0; j < showNum-1; j++) {
          //   drawMatch(coordinates[0], coordinates[j+1], coordinates[j+2], files[j], j);
          // }
          // zoom = 0;
        }
      }
    }
  }
  println("Done processing release");
}

void testZoom() {

  if (zoom == 0) {
    if (mouseX > coordinates[0] && mouseX < coordinates[0]+visLen) {
      for (int k = 1; k <= showNum; k++) {
        if (mouseY > coordinates[k] && mouseY < coordinates[k]+visHeight) {
          zoomStart = (mouseX-coordinates[0])/transcript_ratios[k-1];
          println("First mouse x");
          println(mouseX);
          println(transcript_ratios[k-1]);
        }
      }
    }
  }
}

/*
void testPair() {
 
 for (int k = 0; k < showNum-1; k++) {  
 
 drawMatch(coordinates[0], coordinates[k+1], coordinates[k+2], files[k], k);
 
 for (int i = 0; i<table.getRowCount(); i++) {
 TableRow row = table.getRow(i);
 
 if (row.getString("Status").equals("FP") == false) {
 if (mouseY >= (row.getFloat("matchY_start")-10) && mouseY <= (row.getFloat("matchY_end")+10)) {
 if (mouseX >= (row.getFloat("matchX_start")-5) && mouseX <= (row.getFloat("matchX_end")+5)) {
 println("Found pair");
 int pairedNum = i;
 background(backgroundCol);
 drawBases(); 
 for (int j = 0; j < showNum-1; j++) {
 drawMatch(coordinates[0], coordinates[j+1], coordinates[j+2], files[j], j);
 }
 int tableID = k; // first file or second file
 drawPair(tableID, pairedNum);
 }
 }
 }
 }
 }
 }
 */
void calculateRatios(int tableID) {

  if (subsetStart > 0 && subsetEnd < showLengths[tableID]) { // && subsetEnd < showLengths[tableID+1]
    println("Recalculating");
    for (int i = 0; i < showNum; i++) {
      offsets[i] = 0;
      ratios[i] = visLen/(subsetEnd-subsetStart);
      //print(ratios[i]);
    }
  } else {
    // println("Normal ratios activated");
    for (int i = 0; i < showNum; i++) {
      offsets[i] = baseOffsets[i];
      ratios[i] = visLen/(showLengths[i]-offsets[i]);
      // print(ratios[i]);
    }
  }
}


void calculateTranscriptRatios(int tableID) {

  if (subsetStart > 0 && subsetEnd < transcriptLengths[tableID]) { // && subsetEnd < showLengths[tableID+1]
    //println("Recalculating");
    for (int i = 0; i < showNum; i++) {
      offsets[i] = 0;
      transcript_ratios[i] = visLen/(subsetEnd-subsetStart);
      //print(transcript_ratios[i]);
    }
  } else {
    //println("Normal ratios activated");
    for (int i = 0; i < showNum; i++) {
      offsets[i] = 0;
      transcript_ratios[i] = visLen/(transcriptLengths[i]-offsets[i]);
      // print(transcript_ratios[i]);
    }
  }
}


void keyPressed () {
  String filename;
  filename = folderName + imageName + extension;
  File file = new File (filename);
  int counter = 1;

  while (file.exists()) {
    filename = folderName + imageName + "_" + counter + extension;
    counter ++;
    file = new File (filename);
  } 
  save(filename);
  println("Image printed");
}

String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

// This function returns all the files in a directory as an array of File objects
// This is useful if you want more info about the file
File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    // If it's not a directory
    return null;
  }
}

// Function to get a list of all files in a directory and all subdirectories
ArrayList<File> listFilesRecursive(String dir) {
  ArrayList<File> fileList = new ArrayList<File>(); 
  recurseDir(fileList, dir);
  return fileList;
}

// Recursive function to traverse subdirectories
void recurseDir(ArrayList<File> a, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    // If you want to include directories in the list
    a.add(file);  
    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      // Call this function on all files in this directory
      recurseDir(a, subfiles[i].getAbsolutePath());
    }
  } else {
    a.add(file);
  }
}