//**************************************************************************************
//Autor: José Armando Sáenz Esqueda
//Fecha: 02 de Septiembre de 2020
//Descripcion: Programa para grafica la funcion f(x) = x^3 - 2x + 8 
//**************************************************************************************
float xinf, xsup;
float yinf, ysup;
float dx;
float x[];
float fx[];
float x1,x2,fx1,fx2;
float f(float x)
{
  return pow(x,3) - 2*x + 8;
}

void setup()
{
  size(600,600,P2D);
  xinf  = -2000;
  xsup = 2000;
  dx=10;
  x = new float[ceil((xsup - xinf)/dx)];
  fx = new float[x.length];
  int index = x.length;
  for(int i = 0; i<index; i++)
  {
    if(i < index-1)
    {
      x[i] = xinf  + i*dx;
      println(x[i]);
    }
    else
    {
      x[i] = xsup;
      
    }
    fx[i] = f(x[i]);
  }
  yinf = min(fx);
  ysup = max(fx);
  println(min(x));
  println(max(x));
}

void draw()
{
  background(255);
  translate(width/2,height/2);
  strokeWeight(4);
  stroke(0);
  fill(0);
  line(-width/2,0,width/2,0);
  line(0,-height/2,0,height/2);
  strokeWeight(2);
  stroke(255,0,0);
  for(int i = 1; i<x.length;i++)
  {
     x1 = map(x[i-1], xinf, xsup, -width/2, width/2); 
     x2 = map(x[i], xinf, xsup, -width/2, width/2);
     fx1 = map(fx[i-1], yinf, ysup, -height/2, height/2);
     fx2 = map(fx[i], yinf, ysup, -height/2, height/2);
     line(x1,-fx1,x2,-fx2);
  }
}
