// Data Opdracht 2B

//Alle data word als PlotData object opgeslagen in de plotData arrayList
PlotData pdata;
ArrayList <PlotData> plotData =  new ArrayList<PlotData>();

//float[] waarin alle waardes van eig1 en eig2 worden opgeslagen die worden gebruikt om de hoogste waarde eruit te pakken
float[] eig1Max = new float[500];
float[] eig2Max = new float[500];

// In de 2 Strings worden de namen van de x en y as opgeslagen
String x = "";
String y = "";


//De maximale waarde van de x en y as
int maxX;
int maxY;

//Class waarin alle data word opgeslagen
class PlotData
{
  float x;
  float y;
  int category;

  PlotData(String eig1, String eig2)
  {
    //zorgt ervoor dat de comma een punt word zodat deze van string naar float geparsd kan worden
    eig1 = eig1.replace(',', '.');
    eig2 = eig2.replace(',', '.');
    x = Float.parseFloat(eig1);
    y = Float.parseFloat(eig2);
  }

  PlotData(String CAT, String eig1, String eig2)
  {
    //zorgt ervoor dat de comma een punt word zodat deze van string naar float geparsd kan worden
    eig1 = eig1.replace(',', '.');
    eig2 = eig2.replace(',', '.');
    category = Integer.parseInt(CAT);
    x = Float.parseFloat(eig1);
    y = Float.parseFloat(eig2);
  }
}

void setup()
{
  size(600, 600);
  //laad alle data uit het txt bestand
  loadPlotData();
  //laad de graffiek + waardes
  loadGraph();
  noLoop();
}



void loadGraph()
{
  //tekent de grafiek
  fill(255, 255, 255);
  line(50, 550, 50, 20);
  line(50, 550, 580, 550);  

  //tekent de waardes bij de grafiek
  fill(0, 0, 0);
  text(0, 50 -10, 550 + 30);
  text(maxX, 550, 550 + 30);  
  text(maxY, 10, 25);

  //tekent de namen van de x en y as bij de grafiek
  fill(0, 0, 0);
  text(y, 10, height /2);
  text(x, width/2, 550 + 30);
}

void loadPlotData()
{
  //laad de data uit de Data.txt in een array
  String[] Data =  loadStrings("Data.txt");
  String[] a = null;

  //loopt over de Data array
  for (int i = 0; i < Data.length; i++) {

    //split de data bij een tab
    a = Data[i].split("\t");
    if (i > 0) {

      // slaat de waarde als een object op in een arrayList
      pdata = new PlotData(a[0], a[1], a[2]);
      plotData.add(pdata);
    } else
    {
      //haalt de namen van de x en y as op uit de data
      x = a[1];
      y = a[2];
    }
  }
  //Deze methode haalt de maximale waardes van x en y op 
  getMax();
}

void drawMap()
{ 
  //loopt over de plotData. Deze begint bij 1 omdat de data pas op de 2de regel in het txt bestand staat
  for (int i = 1; i < plotData.size(); i++) {
    //Hier worden de x en y waardes omgezet naar punten in de grafiek
    float xvalue = map(plotData.get(i).x, 0, maxX, 20, 580);
    float yvalue = map(plotData.get(i).y, 0, maxY, 550, 20);

    //kijkt tot welke category de data behoord en roept een methode aan die de data tekend
    if (plotData.get(i).category == 1)
    {
      drawEllipse(255, 0, 0, xvalue, yvalue, 8);
    }
    if (plotData.get(i).category == 2)
    {
      drawEllipse(0, 0, 255, xvalue, yvalue, 8);
    }
    if (plotData.get(i).category == 3)
    {
      drawEllipse(0, 255, 0, xvalue, yvalue, 8);
    }
    if (plotData.get(i).category == 4)
    {
      drawEllipse(255, 255, 0, xvalue, yvalue, 8);
    }
  }
}

void drawEllipse(int red, int green, int blue, float x, float y, int size)
{
  //Tekent een ellipse met de meegegeven waardes
  fill(red, green, blue);
  ellipse(x, y, size, size);
}

void getMax()
{

  // loopt over de plotData en vult 2 arrays met alle data van x en y
  for (int i = 0; i < plotData.size(); i++) {
    eig1Max[i] = plotData.get(i).x;
    eig2Max[i] = plotData.get(i).y;
  }

  // in de 2 floats hieronder worden de maximale waardes van x en y tijdelijk opgeslagen
  float maxXfloat;
  float maxYfloat;

  // Vind de maximale waarde en zet het om naar een integer
  maxXfloat = max(eig1Max);
  maxX = (int) Math.round(maxXfloat);

  maxYfloat = max(eig2Max);
  maxY = (int) Math.round(maxYfloat);

  // tekent de grafiek
  drawMap();
}