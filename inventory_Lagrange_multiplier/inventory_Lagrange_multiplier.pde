/* ********************************************************************************
AUTHOR: JOSE ARMANDO SAENZ ESQUEDA
DATE: NOVEMBER 10, 2020
******************************************************************************** */
float heightM, heightm, widthM, widthm;
float[] Di = {2.0, 4.0, 4.0}; //Demands
float[] ki = {10.0, 5.0, 15.0}; //Shipping cost
float[] hi = {0.30, 0.10, 0.20}; //Storage cost
float[] ai = {1.0, 1.0, 1.0}; //Occupied area
float[] yi = {0.0, 0.0, 0.0}; //optimzed inventory
float A = 25; //Available area
float area = 0;
float x1,y1,x2,y2;
float zy = 5;
float zx = 0.05;
float lambda;
float dlambda=0.0005;
color[] curves = {color(255,0,0),color(0,255,0), color(0,0,255)};
int n = 3; //Products quantity
void setup()
{
  size(900,600, P2D); //Create Screen
  //Optimized inventory computed without area constraint
  for(int i = 0; i<n; i++)
  {
    yi[i] = yopt(Di[i], ki[i], hi[i], ai[i], 0);
  }
  //The area constraint is verified
  area = 0.0;
  for(int i = 0; i<n; i++)
  {
    area += yi[i]*ai[i];
  }
  for(lambda = 0; area > A; lambda -= dlambda)
  {
    area = 0.0;
    for(int i = 0; i<n; i++)
    {
      yi[i] = yopt(Di[i], ki[i], hi[i], ai[i], lambda);
      area += yi[i]*ai[i];
    }
    println("lambda: " + lambda);
  }
  setOrigin();
  background(0); //Black background
  graphframe(); //graph the frame
  for(int j = 0; j<n;j++)
  {
    stroke(curves[j]);
    fill(curves[j]);
    for(float i = 1; i <widthM; i++)
    {
        x1 = i;
        x2 = x1+1;
        y1 = zy*f(Di[j],ki[j],hi[j],x1*zx);
        y2 = zy*f(Di[j],ki[j],hi[j],x2*zx);
        line(x1,-y1,x2,-y2);
    }
    x1 = yi[j];
    y1 = zy*f(Di[j],ki[j],hi[j],x1*zx);
    ellipse(x1,-y1,10,10);
    println(j + ":" + y1);
  }
}

void draw()
{
}

float f(float D,float k,float h, float y)
{
  return k*D/y + h*y/2;
}

float yopt(float D,float k,float h, float a, float l)
{
  return sqrt(2.0*k*D/(h-2*l*a));
}
void setOrigin()
{
  resetMatrix(); //The origin is changed to the default 
  translate(width/10.0, height*0.9); //Change the origin
  heightM = -height * 0.9;
  heightm = height *0.1;
  widthM = width * 0.9;
  widthm = -width * 0.1;
}
void graphframe()
{
  stroke(255); //The line to draw is white
  strokeWeight(3); //The weight of the line is 2 pixels
  line(widthm,0,widthM,0); //Draw x-axis
  line(0, heightm, 0, heightM); //Draw y-axis
  stroke(125); //The line to draw is gray
  strokeWeight(1); //The weight of the line is 1 pixel
  for(float i = widthm; i < widthM; i+=width * 0.1)
  {
    line(i, heightm, i, heightM);
  }
  for(float j = heightM; j < heightm; j+=height*0.1)
  {
    line(widthm, j, widthM, j);
  }
  translate(0,heightM);
  triangle(0,0,-10,10,10,10);
  setOrigin();
  translate(widthM,0);
  triangle(0,0,-10,-10,-10,10);
  setOrigin();
}
