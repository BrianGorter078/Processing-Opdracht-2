// Data opdracht 2C & 2D
StudentData studendata;
ArrayList <StudentData> studentData =  new ArrayList<StudentData>();
float[] LFTD = new float[500];
float[] ANA = new float[500];
float[] DEV = new float[500];
float[] PRJ = new float[500];
float[] SKL = new float[500];
int[] STRN = new int[500];
String[] names =new String[6];
int maxANA;
int maxDEV;
int maxPRJ;
int maxSKL;
int maxLFTD;
int scale = 7;
int marginTop = height / scale;
int topLeft = 50; 

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

void setup()
{
  loadStudentData();
  size(1000, 1000);
  noLoop();
  drawEverything();
}



void drawEverything()
{
  for (int i = 0; i < 5; i++) {

    for (int j = 0; j < 5; j++)
    {
      {
        if (i != j)
        {
          String nameX = names[i+1];
          String nameY = names[j+1];   

          println(nameX + " " + nameY);
          getMax();
          drawMap(i * width / 6, j * height / 6, nameX, nameY);
        } else
        {
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
void loadStudentData()
{
  String[] Data = loadStrings("studentdata.txt");
  String[] a = new String[500];


  for (int i = 0; i < Data.length; i++)
  {
    a = Data[i].split("\t");

    if (i > 1 ) {
      studendata = new StudentData(a[0], a[1], a[2], a[3], a[4], a[5]);
      studentData.add(studendata);
    }

    if (i == 0)
    {


      for (int j = 1; j < 6; j++)
      {
        println("Added " + a[j]);
        names[j] = a[j];
      }
    }
  }
}

void getMax()
{ 
  for (int i = 0; i < studentData.size(); i++) {
    LFTD[i] = studentData.get(i).lftd;
    ANA[i] = studentData.get(i).ANA;
    DEV[i] = studentData.get(i).DEV;
    PRJ[i] = studentData.get(i).PRJ;
    SKL[i] = studentData.get(i).SKL;
  }

  maxLFTD = floatToInt(max(LFTD));
  maxANA = floatToInt(max(ANA));
  maxDEV = floatToInt(max(DEV));
  maxPRJ = floatToInt(max(PRJ));
  maxSKL = floatToInt(max(SKL));
}

int floatToInt(Float floater)
{
  int a = (int) Math.round(floater);
  return a;
}

void drawMap(int x, int y, String nameX, String nameY)
{ 

  for (int i = 1; i < studentData.size(); i++) {
    float dataX = data(nameX, i); 
    float dataY = data(nameY, i);
    int xValue = name(nameX);
    int yValue = name(nameY); 

    float xvalue = map(dataX, 0, xValue, topLeft, width / scale);
    float yvalue = map(dataY, 0, yValue, width / scale, 20);
    println( i + " " + xvalue + " " + yvalue);

    pushMatrix();
    translate(x, y);
    fill(0, 0, 0);
    ellipse(xvalue, yvalue, 1, 1);
    drawOutlines(xValue, yValue, nameX, nameY);
    popMatrix();
  }
}
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
  return value;
}
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

void drawEllipse(int red, int green, int blue, float x, float y, int size)
{
  fill(red, green, blue);
  ellipse(x, y, size, size);
}

void drawOutlines(int valueX, int valueY, String nameX, String nameY)
{
  fill(255, 255, 255);
  line(50, height/ scale, topLeft, 20);
  line(50, height / scale, width / scale, height/scale);  
  fill(0, 0, 0);
  text(0, 50 -10, height / scale + marginTop);
  text(valueX, height / scale, height / scale + marginTop);  
  text(valueY, topLeft - marginTop, 30 );
  text(nameY, 10, height / 12);
  text(nameX, width / 12, height / scale + marginTop);
}
void drawName(String name, int x, int y)
{
  pushMatrix();
  translate(x, y);
  fill(0, 0, 0);
  line(50, height / scale, topLeft, 20);
  line(50, height / scale, width / scale, height/scale);  
  line(width / scale, height/ scale, height / scale, 20);
  line(50, 20, height / scale, 20);
  textSize(20);
  text(name, 75, 80);
  textSize(10);
  popMatrix();
}