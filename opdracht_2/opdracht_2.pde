// Data Opdracht 2B
PlotData pdata;
ArrayList <PlotData> plotData =  new ArrayList<PlotData>();
float[] eig1Max = new float[500];
float[] eig2Max = new float[500];
int xRight550 = width - 20;
String x = "";
String y = "";
float maxXfloat;
float maxYfloat;
int maxX;
int maxY;

class PlotData
{
  float x;
  float y;
  int category;
  
  PlotData(String eig1, String eig2)
  {
    eig1 = eig1.replace(',','.');
    eig2 = eig2.replace(',','.');
    x = Float.parseFloat(eig1);
    y = Float.parseFloat(eig2);
  }
  
  PlotData(String CAT, String eig1, String eig2)
  {
    
    eig1 = eig1.replace(',','.');
    eig2 = eig2.replace(',','.');
    category = Integer.parseInt(CAT);
    x = Float.parseFloat(eig1);
    y = Float.parseFloat(eig2);
    
  }
}

void setup()
{
  size(600,600);
  loadPlotData();
  
  fill(255,255,255);
  line(50, 550, 50, 20);
  line(50, 550, 580, 550);  
  fill(0,0,0);
  text(0,50 -10 ,550 + 30);
  text(maxX, 550, 550 + 30);  
  text(maxY, 10, 25);
  noLoop();
  fill(0,0,0);
  text(y,10,height /2);
  text(x,width/2, 550 + 30);
  
}



void loadPlotData()
{
   String[] Data =  loadStrings("Data.txt");
   String[] a = null;
  
  
  for(int i = 0; i < Data.length ; i++){
    
    a = Data[i].split("\t");
    if(i > 0){
    
    
    pdata = new PlotData(a[0],a[1],a[2]);
    plotData.add(pdata);
    
    }
    
    else
    {
      x = a[1];
      y = a[2];
    }
  }
  getMax("plotData");
}

void drawMap()
{ 
  for(int i = 1; i < plotData.size(); i++){
   float xvalue = map(plotData.get(i).x,0,maxX,20,580);
   float yvalue = map(plotData.get(i).y,0,maxY,550,20);
   
   if(plotData.get(i).category == 1)
   {
     drawEllipse(255,0,0,xvalue,yvalue,8);
   }
   if(plotData.get(i).category == 2)
   {
     drawEllipse(0,0,255,xvalue,yvalue,8);
   }
   if(plotData.get(i).category == 3)
   {
     drawEllipse(0,255,0,xvalue,yvalue,8);
   }
   if(plotData.get(i).category == 4)
   {
     drawEllipse(255,255,0,xvalue,yvalue,8);
   }
   
  }
}
void drawEllipse(int red,int green, int blue, float x, float y, int size)
{
  fill(red,green,blue);
  ellipse(x,y,size,size);
}

void getMax(String name)
{
  
  if(name == "plotData"){
  for(int i = 0; i < plotData.size(); i++){
      eig1Max[i] = plotData.get(i).x;
      eig2Max[i] = plotData.get(i).y;
  }
  
  maxXfloat = max(eig1Max);
  maxX = (int) Math.round(maxXfloat);
  
  maxYfloat = max(eig2Max);
  maxY = (int) Math.round(maxYfloat);

  drawMap();
}
}