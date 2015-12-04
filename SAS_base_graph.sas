/*BAR*/;
DATA chocolate;
	INFILE '/folders/myfolders/MyRawData/Choc.dat';
	INPUT agegroup $ favoriteflavor $ @@;
RUN;
PROC FORMAT;
	VALUE $agegroup 'A'='Adult' 'C'='Child';
RUN;
PROC SGPLOT DATA=chocolate;
	VBAR favoriteflavor / GROUP = agegroup GROUPDISPLAY = CLUSTER;
	FORMAT AgeGroup $AgeGP.;
	LABEL favoriteflavor = 'flavor of chocolate';
	TITLE 'graph';
RUN;

/*HISTOGRAM*/;
DATA contest;
	INFILE '/folders/myfolders/MyRawData/Reading.dat';
	INPUT name $ NumberBooks @@;
RUN;
PROC SGPLOT DATA=contest;
	HISTOGRAM NumberBooks / binwidth=2 showbins scale=count;
	Density NumberBooks;
	Density NumberBooks / TYPE=KERNEL;
RUN;

/*BOX*/;
DATA bikerace;
	INFILE '/folders/myfolders/MyRawData/Criterium.dat';
	INPUT Division $ NumberLaps @@;
RUN;
PROC SGPLOT DATA = bikerace;
	VBOX NumberLaps / CATEGORY = Division;
RUN;

/*SCATTER*/;
DATA wings;
	INFILE '/folders/myfolders/MyRawData/Birds.dat';
	INPUT Name $12. Type $ Length Wingspan @@;
RUN;
PROC FORMAT;
	VALUE $birdtype
		'S'='Songbirds'
		'R'='Raptors';
RUN;
PROC SGPLOT DATA=wings;
	SCATTER X = Wingspan Y = Length / GROUP = TYPE;
	FORMAT TYPE $birdtype.;
RUN;

/*SERIES*/;
DATA electricity;
	INFILE '/folders/myfolders/MyRawData/Hourly.dat';
	INPUT Time kWh @@;
RUN;
PROC SGPLOT DATA = electricity;
	SERIES X = Time Y = kWh / MARKERS;
RUN;

/*FIT*/;
DATA Olympic1500;
	INFILE '/folders/myfolders/MyRawData/Olympic1500.dat';
	INPUT Year Men @@;
RUN;
PROC SGPLOT DATA = Olympic1500;
	LOESS X = Year Y = Men / NOMARKERS CLM NOLEGCLM;
	REG X = Year Y = Men;
	LABEL Men = 'Time in Seconds';
	TITLE "Olympic Times 1500 Meters Run";
RUN;

/*AXIS*/;
DATA cities;
	INFILE '/folders/myfolders/MyRawData/ThreeCities.dat';
	INPUT Month IntFalls Raleigh Yuma @@;
RUN;
PROC SGPLOT DATA = cities;
	SERIES X = Month Y = IntFalls;
	SERIES X = Month Y = Raleigh;
	SERIES X = Month Y = Yuma;
	REFLINE 32 75 / LABEL = ('32 degrees' '75 degrees') TRANSPARENCY = 0.5;
	XAXIS TYPE = DISCRETE;
	YAXIS LABEL = 'Average High Temperature (F)';
RUN;

/*LEGEND*/;
DATA Olympic1500;
	INFILE '/folders/myfolders/MyRawData/OlympicWithWR1500.dat';
	INPUT Year OlympicTime WorldRecord @@;
RUN;
PROC SGPLOT DATA = Olympic1500;
	SCATTER X = Year Y = OlympicTime;
	SERIES X = Year Y = WorldRecord;
	KEYLEGEND / LOCATION = INSIDE POSITION = TOPRIGHT;
	INSET 'olympic not held in 1940 and 1944' / POSITION = BOTTOMLEFT;
	YAXIS LABEL = 'Time in Seconds';
RUN;

/*CUSTOMIZATION*/;
DATA Olympic1500;
	INFILE '/folders/myfolders/MyRawData/OlympicWithWR1500.dat';
	INPUT Year OlympicTime WorldRecord @@;
RUN;
PROC SGPLOT DATA = Olympic1500;
	SCATTER X = Year Y = OlympicTime /
		MARKERATTRS = (SYMBOL = CIRCLEFILLED SIZE = 2MM);
	SERIES X = Year Y = WorldRecord /
		LINEATTRS = (THICKNESS = 2MM) TRANSPARENCY = .75;
	XAXIS LABELATTRS = (WEIGHT = BOLD);
	YAXIS LABEL = 'Time' LABELATTRS = (WEIGHT = BOLD);
RUN;
	
/*PANEL*/;
DATA wings;
	INFILE '/folders/myfolders/MyRawData/Birds.dat';
	INPUT Name $12. Type $ Length Wingspan @@;
RUN;
PROC FORMAT;
	VALUE $birdtype
		'S'='Songbirds'
		'R'='Raptors';
RUN;
PROC SGPANEL DATA = wings;
	PANELBY Type / NOVARNAME SPACING = 5;
	SCATTER X = Wingspan Y = Length;
	FORMAT Type $birdtype.;
RUN;