// Data opdracht 2C & 2D
StudentData studendata;
ArrayList <StudentData> studentData =  new ArrayList<StudentData>();

String[] names =new String[6];
//Deze integers krijgen de maximale waarde van elk vak en de leeftijd
int maxANA;
int maxDEV;
int maxPRJ;
int maxSKL;
int maxLFTD;

//Deze waarde schaalt de grafieken
int scale = 7;

//deze waardes worden gebruikt voor de alignment van de grafieken
int marginTop = height / scale;
int topLeft = 50; 

void setup()
{
  background(255,255,255);
  // laad alle data in
  loadStudentData();
  size(1000, 1000);
  noLoop();
  // Tekent alle data
  drawEverything();
  drawTitle();
}

void loadStudentData()
{
  //laad alle data uit de tekst file in een String[]
  String[] Data = loadStrings("studentdata.txt");
  String[] a = new String[500];

  //Loopt over de data
  for (int i = 0; i < Data.length; i++)
  {
    //split de data op een tab
    a = Data[i].split("\t");

    // wanneer i groter is dan 1, groter dan 1, omdat er op de eerste 2 regels niks staat, word een StudentData object opgeslagen in de studenData ArrayList
    if (i > 1 ) {
      studendata = new StudentData(a[0], a[1], a[2], a[3], a[4], a[5]);
      studentData.add(studendata);
    }

    //i is 0 geeft de namen van de vakken terug
    if (i == 0)
    {
      for (int j = 1; j < 6; j++)
      {
        //Alle namen van de vakken worden opgeslagen in de names array
        names[j] = a[j];
      }
    }
  }
}

void drawEverything()
{
  //deze 2 loops zorgen ervoor dat er 5 x 5 grafieken worden getekend
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++)
    {
      {
        //wanneer i niet gelijk is aan j, oftewel de er niet 2 dezelfde vakken staan, worden de grafieken getekend
        if (i != j)
        {
          //Omdat i bij 0 begint en het eerste item niet nodig is moeten we i en j 1 omhoog doen, de namen van de x en y as worden opgehaald
          String nameX = names[i+1];
          String nameY = names[j+1];   
          
          //Zoekt de maximale waardes
          getMax();
          
          //tekend de map met de volgende parameters
          drawMap(i * width / 6, j * height / 6, nameX, nameY);
          
        } else
        {
          //wanneer i gelijk is aan j dan word er een methode aangeroepen die de namen in een rechthoek neerzet
          for (int k = 0; k < 5; k++)
          {
            if (names[k+1] != null) {
              drawName(names[k+1], k * width / 6, k * height / 6);
            }
          }
        }
      }
    }
  }
}


void getMax()
{ 
  //tijdelijke float arrays waarin de data word opgeslagen
  float[] LFTD = new float[500];
  float[] ANA = new float[500];
  float[] DEV = new float[500];
  float[] PRJ = new float[500];
  float[] SKL = new float[500];
  
  //loopt over de studentenData en van elke vak elke waarde en stopt deze in de tijdelijke arrays
  for (int i = 0; i < studentData.size(); i++) {
    LFTD[i] = studentData.get(i).lftd;
    ANA[i] = studentData.get(i).ANA;
    DEV[i] = studentData.get(i).DEV;
    PRJ[i] = studentData.get(i).PRJ;
    SKL[i] = studentData.get(i).SKL;
  }
  //De max van elke array word gezocht en omgezet naar een int.
  maxLFTD = floatToInt(max(LFTD));
  maxANA = floatToInt(max(ANA));
  maxDEV = floatToInt(max(DEV));
  maxPRJ = floatToInt(max(PRJ));
  maxSKL = floatToInt(max(SKL));
}

//zet floats om in integers
int floatToInt(Float floater)
{
  int a = (int) Math.round(floater);
  return a;
}

//tekent de map
void drawMap(int x, int y, String nameX, String nameY)
{ 
  //Loopt over de studentenData 
  for (int i = 1; i < studentData.size(); i++) {
    //de doorgegeven nameX en nameY worden doorgegevn met de loop variabele waarna er een float uitkomt met de waarde van dat vak met een x en y waarde.
    float dataX = data(nameX, i); 
    float dataY = data(nameY, i);
    
    //naast een float is er ook een integer nodig die de maximale waarde van de doorgegeven name op slaat
    int xValue = name(nameX);
    int yValue = name(nameY); 

    //map de zet de dataX en dataY om naar een waarde tussen 0 en xValue en yValue
    float xvalue = map(dataX, 0, xValue , topLeft, width / scale);
    float yvalue = map(dataY, 0, yValue , width / scale, 20);

    //dit gedeelte zorgt ervoor de de grafieken naast elkaar en onder elkaar worden neergezet
    pushMatrix();
    translate(x, y);
    fill(0, 0, 0);
    ellipse(xvalue, yvalue, 1, 1);
    //de xValue en yValue worden meegegeven evenals de nameX en nameY zodat deze waardes bij de grafieken kunnen worden gezet
    drawOutlines(xValue, yValue, nameX, nameY);
    popMatrix();
  }
}

//tekent een ellipse
void drawEllipse(int red, int green, int blue, float x, float y, int size)
{
  fill(red, green, blue);
  ellipse(x, y, size, size);
}

//tekent alles behalve de grafiek, de waardes etc
void drawOutlines(int valueX, int valueY, String nameX, String nameY)
{
  fill(255, 255, 255);
  line(50, height/ scale, topLeft, 20);
  line(50, height / scale, width / scale, height/scale);  
  fill(0, 0, 0);
  text(0, 50 -10, height / scale + marginTop);
  text(valueX, height / scale, height / scale + marginTop);  
  text(valueY, topLeft - marginTop, 22 );
  text(nameY, 10, height / 12);
  text(nameX, width / 12, height / scale + marginTop);
  
  
}

void drawTitle()
{
  textSize(20);
  fill(0,0,0);
  text("Matrix plot van Leeftijd, Analyse, Development, Project, Skills", width / 7,  height - 100);
  
}
//tekent de rechthoeken in de diagonale as
void drawName(String name, int x, int y)
{
  pushMatrix();
  translate(x, y);
  textSize(15);
  fill(255,0,0);
  text(name, 75, 80);
  textSize(10);
  popMatrix();
}

//zorgt ervoor dat er met de naam een waarde kan worden toegewezen
int name(String name)
{
  int value = 0;
  if (name.equals("lftd"))
  {
    value = maxLFTD;
  }
  if (name.equals("ANA"))
  {
    value = maxANA;
  }
  if (name.equals("DEV"))
  {
    value = maxDEV;
  }
  if (name.equals("PRJ"))
  {
    value = maxPRJ;
  }
  if (name.equals("SKL"))
  {
    value = maxSKL;
  }
  if(value < 10)
  {
    value = value + 1;
  }
  return value ;
}

//zorgt ervoor dat er met de naam een float waarde kan worden opgeroepen
float data(String name, int i) {
  float result = 0.0;

  if (name.equals("lftd"))
  {
    result = studentData.get(i).lftd ;
  }
  if (name.equals("ANA"))
  {
    result = studentData.get(i).ANA;
  }
  if (name.equals("DEV"))
  {
    result = studentData.get(i).DEV;
  }
  if (name.equals("PRJ"))
  {
    result = studentData.get(i).PRJ;
  }
  if (name.equals("SKL"))
  {
    result = studentData.get(i).SKL;
  }
  return result;
}

// Class waarin alle studentData in kan worden "opgeslagen" 
class StudentData
{
  int stnr;
  int lftd;
  float ANA;
  float DEV;
  float PRJ;
  float SKL;

  StudentData(String Stnr, String Lftd, String Ana, String Dev, String Prj, String Skl)
  {
    stnr = toInt(Stnr);
    lftd = toInt(Lftd);
    ANA = toFloat(Ana);
    DEV = toFloat(Dev);
    PRJ = toFloat(Prj);
    SKL = toFloat(Skl);
  }

  int toInt(String integer)
  {
    int newinteger;
    newinteger = Integer.parseInt(integer);
    return newinteger;
  }

  float toFloat(String floater)
  {
    floater = floater.replace(',', '.');
    float newfloat;
    newfloat = Float.parseFloat(floater);
    return newfloat;
  }
}