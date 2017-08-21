* REVISA EL pdf: 1.ExploratoryDataAnalysis. Los datos de aqui se basan en el ejemplo de ahi.

* Primer Paso es conocer las variables. La metadata es donde se describe ello.
* De ahi se sabe que es categorico (nominal u ordinal) y qué es numerico (intervalo o razon)

* LEAMOS este archivo (la ubicacion en tu maquina es diferente):

GET DATA
  /TYPE=TXT
  /FILE="/Users/JoseManuel/Documents/GITHUBs/PUCP/InvestEstad_II/LECTURAS y DATA/Semana 2/dataSemana2/tips.csv"
  /DELCASE=LINE
  /DELIMITERS=","
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /IMPORTCASE=ALL
  /VARIABLES=
  obs F3.0
  totbill F5.2
  tip F5.2
  sex A1
  smoker A3
  day A3
  time A5
  size F1.0.
CACHE.
EXECUTE.
DATASET NAME SinGuardar1  WINDOW=FRONT. 
/*arriba le puse 'Singuardar1' adrede!!*/


****** COMENZAMOS A Explorar Categoricas

** I. Dicotomicas:  
/*buscar la tabla de frecuencias, los estadisticos y graficos*/

FREQUENCIES VARIABLES=smoker
  /STATISTICS=MODE
  /BARCHART PERCENT
  /ORDER=ANALYSIS.



** II. Ordinales:
/*buscar la tabla de frecuencias, los estadisticos y graficos*/

FREQUENCIES VARIABLES=day
  /NTILES=4
  /STATISTICS=MEDIAN MODE
  /BARCHART PERCENT
  /ORDER=ANALYSIS.

/* aqui hago un cambio. Creo una variable con la informacion de la variable 'day'
/* para que lo categorico pueda usarlo como ordinal.

RECODE day ('Thu'=1) ('Fri'=2) ('Sat'=3) ('Sun'=4) INTO dayOrd.
VARIABLE LABELS  dayOrd 'dayOrdinal'.
EXECUTE.

* Ahora ya aparecen mediana y moda:

FREQUENCIES VARIABLES=dayOrd
  /NTILES=4
  /STATISTICS=MEDIAN MODE
  /BARCHART PERCENT
  /ORDER=ANALYSIS.

/* en la ordinal ya podemos usar el boxplot:

EXAMINE VARIABLES=dayOrd 
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /MISSING=LISTWISE.

*** VAYAMOS A LAS Numericas 
* CASO discreto (conteos)
*aqui aun puedo pedir frequencias

FREQUENCIES VARIABLES=size
  /NTILES=4
  /STATISTICS=STDDEV VARIANCE MINIMUM MAXIMUM SEMEAN MEAN MEDIAN MODE SKEWNESS SESKEW KURTOSIS 
    SEKURT
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.



* CASO  continuo (decimales)

FREQUENCIES VARIABLES=totbill
  /FORMAT=NOTABLE /*NOMAS TABLAS DE FREQUENCIA*/
  /NTILES=4
  /STATISTICS=STDDEV MEAN MEDIAN MODE SKEWNESS SESKEW KURTOSIS SEKURT
  /HISTOGRAM NORMAL /*MOSTRAR CURVA NORMAL TEORICA
  /ORDER=ANALYSIS.

EXAMINE VARIABLES=totbill
  /COMPARE VARIABLE  /*BOXPLOT SIMPLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /MISSING=LISTWISE.

EXAMINE VARIABLES=totbill BY dayOrd  /*NUMERICA VERSUS CATEGORICA
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL.

GRAPH
  /SCATTERPLOT(BIVAR)=totbill WITH tip /*NUMERICA VERSUS NUMERICA
  /MISSING=LISTWISE.

GRAPH
  /SCATTERPLOT(BIVAR)=totbill WITH tip /*NUMERICA VERSUS NUMERICA VERSUS CATEGORICA
  /PANEL COLVAR=sex COLOP=CROSS ROWVAR=smoker ROWOP=CROSS
  /MISSING=LISTWISE.


