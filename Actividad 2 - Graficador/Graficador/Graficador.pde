//Definicion de las variables
float[] fx,x;     //Variable dependiente e independiente
float xmin, xmax; //Rango de la variable independiente
float fxmin, fxmax; //Rango de la variable dependiente
int n;            //Número de puntos a graficar
float inc;        //Incremento de la variable independiente
int ancho, alto;  //Tamaño de la pantala
int anchoL, altoL;//Tamaño del lienzo
float[] fxg, xg;  //Variable dependiente e independiente ajustadas al lienzo

//Función a graficar
float f(float v)
{
  return  -pow(v,3) + pow(v,2) + v - 1;
}

//Rutina para dibujar el mallado
void grid(int d)
{
  float inch; //Incremento horizontal
  float incv; //Incremento vertical
  //Ubicando el origen en el centro de la pantalla
  translate(width/2, height/2);
  inch = anchoL/(d-1);
  incv = altoL/(d-1);
  //Dibujando las lineas
  for(int i = 0; i<d;i++)
  {
    line(-anchoL/2, -altoL/2 + i*incv, anchoL/2, -altoL/2 + i*incv); //Linea horizontal
    line(-anchoL/2 + i*inch, -altoL/2 , -anchoL/2 + i*inch, altoL/2); //Linea vertical
  }
}

void setup()
{
  xmin = -1000; //Valor inferior a graficar
  xmax = 1000; //Valor superior a graficar
  int n = 500; //Cantidad de puntos a graficar
  inc = (xmax - xmin)/n; //Determinando el incremento
  x = new float[n+1];
  fx = new float[n+1];
  xg = new float[n+1];
  fxg = new float[n+1];
  //Obteniendo los puntos a graficar
  for(int i = 0; i<=n; i++)
  {
    x[i] = xmin + i*inc;
    fx[i] = f(x[i]);
  }
  fxmax = max(fx); //Obteniendo el maximo valor de la variable dependiente
  fxmin = min(fx); //Obteniendo el minimo valor de la variable independiente
  fullScreen();//Creando una ventana que ocupa la pantalla completa y para renderizar en 2D
  ancho = width; //Obtiene el ancho de la ventana;
  alto = height; //Obtiene el alto de la ventana;
  anchoL = ancho - 10; //Es el ancho que va a ocupar la grafica
  altoL = alto - 10; //Es el alto que va a ocupar la grafica
  //Ajustando los valores a pixeles
  for(int i = 0; i<=n; i++)
  {
    xg[i] = map(x[i],xmin,xmax,0, anchoL);
    fxg[i] = map(fx[i],fxmin,fxmax,0, altoL);
  }
  background(0); //Seleccionando un color de fondo negro
  stroke(255); //Seleccionando color de linea blanco;
  strokeWeight(2); //Seleccionando un ancho de linea de 2 pixeles
  grid(11); //Haciendo un mallado con 11 lineas
  stroke(0,255,0); //Seleccionando un color de linea verde
  resetMatrix();
  translate(5,5); //Reubicando el origen en la parte superior izquierda del lienzo
  for(int i = 1; i<=n; i++)
  {
    line(xg[i-1], fxg[i-1], xg[i], fxg[i]); //Graficando los puntos
  }
  //Mostrando nombre
  String autor = "JOSE ARMANDO SAENZ ESQUEDA";
  textSize(20);
  float aautor = textWidth(autor);
  fill(255);
  noStroke();
  rect(anchoL-aautor-10, altoL-30, aautor+10,30);
  fill(0);
  text(autor,anchoL-aautor-5,altoL-5);
  save("Grafica"+year()+month()+day()+hour()*minute()+second()); //Se guarda la imagen en la carpeta del proyecto
}
