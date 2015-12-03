*read multiple line;
DATA highlow;
	INFILE '/folders/myfolders/MyRawData/Temperature.dat';
	INPUT city $ state $
		  / NormalHigh NormalLow
		  #3 RecordHigh RecordLow;
PROC PRINT DATA=highlow;
RUN;

*multiple obs in a line;
*Nome AK 2.5 15 Miami FL 6.75 18 Raleigh NC . 12;
DATA rainfall;
	INFILE '/folders/myfolders/MyRawData/Precipitation.dat';
	INPUT City $ State $ NormalRain $ MeanDaysRain @@;
PROC PRINT DATA=rainfall;
RUN;

*read subset - select;
DATA freeways;
	INFILE '/folders/myfolders/MyRawData/Traffic.dat';
	INPUT Type $ @;
	/*input read variable, @ stop waiting for if test*/;
	IF Type = 'surface' THEN DELETE;
	INPUT Name $ 9-38 AMTraffic PMTraffic;
PROC PRINT DATA=freeways;
RUN;

*read subset - since ith row(row!not obs!some obs multi line)/;
DATA icecream;
	INFILE '/folders/myfolders/MyRawData/Sales.dat' FIRSTOBS=3;
	/*FIRSTOBS=3,OBS=5*/;
	INPUT Flavor $ 1-9 Location BoxesSold;
RUN;

*MISSOVER;
DATA class102;
	INFILE '/folders/myfolders/MyRawData/Scores.dat' MISSOVER;
	INPUT Name /*$ Test1 Test2 Test3 Test4 Test5*/;
RUN;
PROC PRINT DATA=class102;
RUN;

*different length;
DATA homeaddress;
	INFILE '/folders/myfolders/MyRawData/Adress.dat' TRUNCOVER;
	INPUT Name $ 1-15 Number 16-19 Street $ 22-37;
RUN;

*delimited files;
*DLM;
DATA reading;
	INFILE '/folders/myfolders/MyRawData/Books.dat' DLM=',';
	INPUT Name $ Week1 Week2 Week3 Week4 Week5;
RUN;
PROC PRINT DATA=reading;
RUN;

*DSD;
DATA music;
	INFILE '/folders/myfolders/MyRawData/Bands.csv' DLM=',' DSD MISSOVER;
	INPUT BandName :$30. GigDate :MMDDYY10. eightpm ninepm tenpm elevenpm;
PROC PRINT DATA=music;
RUN;

