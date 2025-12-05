/*
This script takes summary .csv files from transcript sequence analyses
and create interactive visualisations. Matches are placed in performance
time, with lines between corresponding matches. The match in the first show 
chronologically are in green, turquoise in the second show. To look at 
the contents of a match (and the three word buffer surround it), click on it. 
Both matching will become red. Text from the first show
is displayed above, and from the second displayed below. The 
associated timestamps and audio code is shows on the right-hand side.
NB: This was developed to aid research rather than for public use. 
The zoom is glitchy, but useful. Dragging the mouse across a section of 
the visualisation zooms into that section and puts it in real time 
(rather than normalised time). To exit zoom, click on the white
border around the shows. 
*/

//TODO: Change show data as appropriate]

// Comedian B
/*
 String[] titles = {"3Feb2018", "22Feb2018", "25Jun2018", "25Jul2018",
                 "11Aug2018", "12Aug2018", "13Aug2018", "14Aug2018",
                 "15Aug2018", "17Aug2018", "18Aug2018", "19Aug2018",
                 "20Aug2018", "21Aug2018", "22Aug2018", "23Aug2018",
                 "24Aug2018", "25Aug2018", "26Aug2018", "20Nov2018"};
                 
// Files generated from transcript sequence analysis
 String[] files = {"ComedianB_Scooby/Transcript_ComedianB_3Feb2018_22Feb2018_SummaryTable.csv",
 "ComedianB_Scooby/Transcript_ComedianB_22Feb2018_25Jun2018_SummaryTable.csv",
 "ComedianB_Scooby/Transcript_ComedianB_25Jun2018_25Jul2018_SummaryTable.csv",
 "ComedianB_Scooby/Transcript_ComedianB_25Jul2018_11Aug2018_SummaryTable.csv",
"ComedianB_Scooby/Transcript_ComedianB_11Aug2018_12Aug2018_SummaryTable.csv",
"ComedianB_Scooby/Transcript_ComedianB_12Aug2018_13Aug2018_SummaryTable.csv",
"ComedianB_Scooby/Transcript_ComedianB_13Aug2018_14Aug2018_SummaryTable.csv",
"ComedianB_Scooby/Transcript_ComedianB_14Aug2018_15Aug2018_SummaryTable.csv",
"ComedianB_Scooby/Transcript_ComedianB_15Aug2018_17Aug2018_SummaryTable.csv",
"ComedianB_Scooby/Transcript_ComedianB_17Aug2018_18Aug2018_SummaryTable.csv",
"ComedianB_Scooby/Transcript_ComedianB_18Aug2018_19Aug2018_SummaryTable.csv",
"ComedianB_Scooby/Transcript_ComedianB_19Aug2018_20Aug2018_SummaryTable.csv",
"ComedianB_Scooby/Transcript_ComedianB_20Aug2018_21Aug2018_SummaryTable.csv",
"ComedianB_Scooby/Transcript_ComedianB_21Aug2018_22Aug2018_SummaryTable.csv",
"ComedianB_Scooby/Transcript_ComedianB_22Aug2018_23Aug2018_SummaryTable.csv",
"ComedianB_Scooby/Transcript_ComedianB_23Aug2018_24Aug2018_SummaryTable.csv",
"ComedianB_Scooby/Transcript_ComedianB_24Aug2018_25Aug2018_SummaryTable.csv",
"ComedianB_Scooby/Transcript_ComedianB_25Aug2018_26Aug2018_SummaryTable.csv",
"ComedianB_Scooby/Transcript_ComedianB_26Aug2018_20Nov2018_SummaryTable.csv"};

 String imageName = "ComedianB_Scooby_chron";
 
 // Delay between start of audio and showtime (if applicable)
 int[] offsets =  {0, 0, 0, 0, 0,
 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0};
 // Delay between start of audio and visualisation (if applicable)
 int[] baseOffsets = {0, 0, 0, 0, 0,
 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0};
 
 // Duration in seconds
 int[] showLengths = {99, 70, 75, 70,
                       78, 77, 79, 81,
                       65, 82, 85, 82,
                       77, 73, 74, 69,
                       70, 104, 82, 91};
 // Number of shows                     
int showNum = 20;
*/
//ComedianA
// Cross-transcript / ComedianA

 String[] titles = {"16Mar2017","29Mar2017","8Apr2017", "24Apr2017", "26Apr2017"};
 
String[] files = {"ComedianA_filesApril/Transcript_ComedianA_16Mar2017_29Mar2017_SummaryTable.csv",
"ComedianA_filesApril/Transcript_ComedianA_29Mar2017_08Apr2017_SummaryTable.csv",
"ComedianA_filesApril/Transcript_ComedianA_08Apr2017_24Apr2017_SummaryTable.csv",
"ComedianA_filesApril/Transcript_ComedianA_24Apr2017_26Apr2017_SummaryTable.csv"};
 String imageName = "ComedianA_chron_transcript";
 
 int[] offsets = {43, 106, 37, 325, 34};
 int[] baseOffsets = {43, 106, 37, 325, 34};
 int[] showLengths = {2517, 2590, 2670, 2837, 2739};
 int showNum = 5;





// General global values for visualisation (height, length, gap between bars)
float visHeight, visLen, gap;
String extension = ".png";
// TODO: Change foldername to save images saved on spacebar hit
String folderName = "/Users/vanessa/Desktop/";
float matchX_a, matchX_b, matchX_c, matchX_d;
color c;

int max = 1000;
float[] coordinates = new float[(showNum+1)]; 
float counter1 = 0, counter2 = 0;
Table table;
int drawn, zoom;
float zoomStart, zoomEnd;
int fntsize = 16;

// Subsets are length of audio in seconds, generated from mouse drag
int subsetStart = 0;
int subsetEnd = 8000; // arbitrarily large number
float[] ratios = new float[showNum];
//Background colour
int backgroundCol = 255;


void setup() {
  background(backgroundCol);
  size(1250, 700);
  coordinates = drawBases();
  for (int i = 0; i < showNum-1; i++) {
    drawMatch(coordinates[0], coordinates[i+1], coordinates[i+2], files[i], i);
  }
}

void draw() {
}

float[] drawBases() {

  println("Drawing bases");

  visHeight = height/(showNum+5);
  visLen = width*0.85;
  gap = visHeight/10;

  float visX = (width-visLen)/2;
  coordinates[0] = visX;

  // Draw bases
  for (int i = 1; i <= showNum; i++) {
    fill(255);
    float yCoord = ((height*i)/(showNum+1))-(visHeight/2);
    rect(visX, yCoord, visLen, visHeight);
    coordinates[i] = yCoord;
    textSize(fntsize);
    fill(0);
    textAlign(RIGHT);
    text(titles[i-1], visX-4, yCoord+(visHeight/2));
  }

  // Translate timestamps into seconds
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
  return coordinates;
}

void readTable(String tableName) {

  table = loadTable(tableName, "header");

  table.addColumn("matchX_start");
  table.addColumn("matchX_end");
  table.addColumn("matchY_start");
  table.addColumn("matchY_end");
  table.addColumn("matchLen");
}

void drawMatch(float xCoord, float firstY, float secondY, String filename, int tableID) { // NB Start show ID

  readTable(filename);

  float showX = xCoord;
  float show1Y = firstY;
  float show2Y = secondY;

  println("Subsets");
  println(subsetStart);
  println(subsetEnd);

  calculateRatios(tableID);

  // Go through each row, turning timestamps into coordinates
  for (int i = 0; i<table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    int start = row.getInt("Audio_start");
    int end = row.getInt("Audio_end");
    String status = row.getString("Status");

    // Adjacent rows correspond to different shows
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
      }

      if (drawn == 1) {
        line(matchX_a, coordinates[tableID+1]+visHeight, matchX_c, coordinates[tableID+2]);
        line(matchX_b, coordinates[tableID+1]+visHeight, matchX_d, coordinates[tableID+2]);
      }

      drawn = 0;
    }

    float show1_percent = (counter1/(showLengths[tableID]-offsets[tableID]))*100;
    float show2_percent = (counter2/(showLengths[tableID+1]-offsets[tableID+1]))*100;
    String show1msg = str(show1_percent);
    String show2msg = str(show2_percent);

    textSize(14);
    fill(0);
    textAlign(CENTER);
  }
}

void mousePressed() {

  testZoom();
  testPair();
  
  // Re-set visualisation if mouse press is at the border
  if (mouseX < coordinates[0] || mouseX > coordinates[0]+visLen) {
    subsetStart = 0;
    subsetEnd = 8000;
    println("Subsets re-adjusted");
    print(subsetStart);
    background(backgroundCol);
    drawBases();
    for (int j = 0; j < showNum-1; j++) {
      drawMatch(coordinates[0], coordinates[j+1], coordinates[j+2], files[j], j);
    }
  }

  println("Done processing click");
}

void drawPair(int tableID, int pairedNum) {
  
  // If one match is clicked on, highlight its partner

  int wordHeight = 5;

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

      float xlocation = visLen+(width*0.1);
      float ylocation;
      float ylocationC = (coordinates[1])/2+(visHeight/4)- wordHeight;
      float ylocationD = coordinates[showNum]+visHeight+(visHeight/4);

      float midPoint = ((coordinates[tableID+2]-coordinates[tableID+1])/2)+coordinates[tableID+1]+visHeight/2;

      // Extract match info and print it on visualisation
      if (i%2 == 0) {
        ylocation = coordinates[tableID+1]+visHeight/2;
        fill(0);
        textSize(14);
        String content = '"'+ row.getString("TEXT")+ '"';
        text(content, width/2, ylocationC);
      } else {
        ylocation = coordinates[tableID+2]+visHeight/2;
        fill(0);
        textSize(14);
        String content = '"'+ row.getString("TEXT")+ '"';
        text(content, width/2, ylocationD+wordHeight);
      }

      textSize(8);
      fill(0);
      textAlign(CENTER);
      text(timestamp, xlocation, ylocation);

      text(id, xlocation, midPoint);

      c = color(226, 21, 6);

      if (row.getInt("Audio_start") > subsetStart &&
        row.getInt("Audio_end") <= subsetEnd) {
        drawRectangle(i, c, tableID);
      }
    }
  }
}

void drawRectangle(int rowNum, color fillColor, int tableID) {

  TableRow row = table.getRow(rowNum);
  fill(fillColor);
  stroke(50);
  rect(row.getFloat("matchX_start"), row.getFloat("matchY_start"), row.getFloat("matchLen"), visHeight);
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
  
  println("Zoom is:");
  print(zoom);

  for (int i = 1; i<=showNum; i++) {
    if (mouseX > coordinates[0] && mouseX < coordinates[0]+visLen) {
      if (mouseY > coordinates[i] && mouseY < coordinates[i]+visHeight) {
        if (zoom == 1) {
          subsetStart = int(zoomStart);
          subsetEnd = int((mouseX-coordinates[0])/ratios[i-1]);
          println("second mouse x");
          println(mouseX);
          println(ratios[i-1]);
          background(backgroundCol);
          drawBases();
          for (int j = 0; j < showNum-1; j++) {
            drawMatch(coordinates[0], coordinates[j+1], coordinates[j+2], files[j], j);
          }
          zoom = 0;
        }
      }
    }
  }
  println("Done processing release");
}


void testZoom() {
  
  // Tests the zoom state

  if (zoom == 0) {
    if (mouseX > coordinates[0] && mouseX < coordinates[0]+visLen) {
      for (int k = 1; k <= showNum; k++) {
        if (mouseY > coordinates[k] && mouseY < coordinates[k]+visHeight) {
          zoomStart = (mouseX-coordinates[0])/ratios[k-1];
          println("First mouse x");
          println(mouseX);
          println(ratios[k-1]);
        }
      }
    }
  }
}

void testPair() {
  
  // Tests pair display state

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

void calculateRatios(int tableID) {
  
  // Adjust visualisation ratios (zoom vs. normalised)

  if (subsetStart > 0 && subsetEnd < showLengths[tableID]) {
    println("Recalculating");
    for (int i = 0; i < showNum; i++) {
      offsets[i] = 0;
      ratios[i] = visLen/(subsetEnd-subsetStart);
      print(ratios[i]);
    }
  } else {
    println("Normal ratios activated");
    for (int i = 0; i < showNum; i++) {
      offsets[i] = baseOffsets[i];
      ratios[i] = visLen/(showLengths[i]-offsets[i]);
      print(ratios[i]);
    }
  }
}

void keyPressed () {
  // Save .png if a key is hit
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