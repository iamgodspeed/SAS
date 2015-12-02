*univariate;

data class;
	INFILE '/folders/myfolders/MyRawData/Scores.dat';
	INPUT Score @@;
proc univariate data = class;
	var score;
	title;
run;

*mean,median,confidence;
data books;
	INFILE '/folders/myfolders/MyRawData/Picbooks.dat';
	INPUT NumberOfPages @@;
proc MEANS DATA=books N MEAN MEDIAN CLM ALPHA=0.1;
	TITLE 'SUMMARY';
run;

*freq;
data bus;
	INFILE '/folders/myfolders/MyRawData/Bus.dat';
	INPUT BusType $ OnTimeOrLate $ @@;
proc freq DATA=bus;
	tables BusType * OnTimeOrLate / chisq ;
	TITLE;
RUN;

*correlation;
data examvstv;
	INFILE '/folders/myfolders/MyRawData/Exercise.dat';
	INPUT Score Television Exercise @@;
proc corr data=examvstv;
	var Television Exercise;
	with Score;
run;

*regression;
data hits;
	INFILE '/folders/myfolders/MyRawData/Baseball.dat';
	INPUT Height Distance @@;
proc reg data=hits;
	model distance=height;
	plot distance*height;
run;

*ANOVA;
data basket;
	INFILE '/folders/myfolders/MyRawData/Basketball.dat';
	INPUT Team $ Height @@;
proc ANOVA data=basket;
	class Team;
	model Height=Team;
	means Team / SCHEFFE;
run;