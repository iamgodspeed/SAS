*IF THEN;
DATA homeimprovements;
	INFILE '/folders/myfolders/MyRawData/Home.dat';
	INPUT Owner $ 1-7 Description $ 9-33 Cost;
	If Cost=. THEN CostGroup='mising';
		ELSE IF Cost<2000 THEN CostGroup='low';
		ELSE IF Cost<10000 THEN CostGroup='medium';
		ELSE CostGroup='high';
PROC PRINT DATA=homeimprovements;
RUN;

*IF SUBSET;
DATA comedy;
	INFILE '/folders/myfolders/MyRawData/Shakespeare.dat';
	INPUT Title $ 1-26 Year Type $;
	IF Type = 'comedy';
	/*IF Type='tragedy' OR Type='romance' OR Type='history' THEN DELETE*/
PROC PRINT DATA=comedy;
RUN;