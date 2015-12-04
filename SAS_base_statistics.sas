/*univariate : distribution of a single variable*/
/*mean,median,mode,sd,skewness,kurtosis*/;
/*skewness : asymmetrical distribution, more spread out on one side*/;
/*kurtosis : flat or peaked distribution*/;
/*normal distribution : skewness=0 kurtosis=0*/;

DATA class;
	INFILE '/folders/myfolders/MyRawData/Scores.dat';
	INPUT Score @@;
PROC UNIVARIATE data = class;
	VAR Score;
	HISTOGRAM Score / NORMAL;
	PROBPLOT Score;
	TITLE'distribution of score';
RUN;
*-----------------------------------------------------;

/*PROC MEANS*/;
/*mean,n(non-missing),sd,min,max*/;
/*confidence limits : default 0.05/95% CLM ALPHA=.05*/;
/*PROC MEANS options;*/;
/*	VAR variable-list;*/;
DATA books;
	INFILE '/folders/myfolders/MyRawData/Picbooks.dat';
	INPUT NumberOfPages @@;
PROC MEANS DATA = books N MEAN MEDIAN CLM ALPHA=0.10;
	TITLE 'SUMMARY';
RUN;
*-----------------------------------------------------;

/*PROC TTEST*/;
/*t test compare mean*/;
/*mean > level : one sample test*/;
*	PROC TTEST H0 = n options;
*	VAR variable;
/*meanx vs meany : two independent sample test*/;
*	PROC TTEST options;
*		CLASS variable (distinguish two group);
*		VAR variable;
/*meanbefore vs meanafter : paired test*/;
*	PROC TTEST options;
*		PAIRED variable1 * variable2;
DATA swim;
	INFILE '/folders/myfolders/MyRawData/Olympic50mSwim.dat';
	INPUT Swimmer $ FinalTime SemiFinalTime @@;
RUN;
PROC TTEST DATA = swim PLOTS(ONLY)=(SUMMARYPLOT QQPLOT);
	TITLE'semi vs final';
	PAIRED FinalTime * SemiFinalTime;
RUN;
*mean difference is 0.0850 seconds;
*t value 3.29 Pr>|t| 0.0133 : significant;
*-----------------------------------------------------;

/*PROC FREQ*/;
/*categorical data*/;
/*chi-square*/;
/*association between two variables*/;
DATA bus;
	INFILE '/folders/myfolders/MyRawData/Bus.dat';
	INPUT BusType $ OnTimeOrLate $ @@;
PROC FREQ DATA = bus;
	TABLES BusType * OnTimeOrLate / CHISQ PLOTS=FREQPLOT(TWOWAY=GROUPHORIZONTAL);
	TITLE;
RUN;
*BusRegular is late(61.9%),BusExpress is late(24.14%);
*chisqure prob is 0.0071, there is association between BusType and arrival time;
*Fisher's exact test p 0.0097;
*-----------------------------------------------------;

/*PROC CORR*/;
/*linear relationship between two variables -1 0 1 */;

DATA ExamVsTv;
	INFILE '/folders/myfolders/MyRawData/Exercise.dat';
	INPUT Score Television Exercise @@;
RUN;
PROC CORR DATA = ExamVsTv PLOTS = (SCATTER MATRIX);
	VAR Television Exercise;
	WITH Score;
RUN;
*correlation coefficiency tv -0.55 exer 0.79;
*probability of getting a larger absolute value for each correlation
assuming the population correlation is zero 0.0015 0.0001;
*-----------------------------------------------------;

/*PROC REG*/;
/*one or multiple regressor variables*/;
/*stepwise,forward selection,backward elimination*/;
/*nonlinear,logistic*/;
/*time series*/;
*PROC REG;
*	MODEL dependent = independent;
DATA hits;
	INFILE '/folders/myfolders/MyRawData/Baseball.dat';
	INPUT Height Distance @@;
RUN;
PROC REG DATA = hits PLOTS(ONLY)=(DIAGNOSTICS FITPLOT);
	MODEL Distance = Height;
RUN;
*DF,degree of freedom;
*mean square: sum of squres divided by df;
*F value: test null hypothesis;
*p value;
*root MSE : root mean squre error;
*Coeff Var : Coefficient variation;
*R squre and adjusted for df, low other predictors;
*parameter estimates;
*distance = -11 + 2.89*height;
*-----------------------------------------------------;

/*PROC ANOVA*/;
/*analysis of variance*/;
/*not one way and not balanced GLM*/;
DATA heights;
	INFILE '/folders/myfolders/MyRawData/GirlHeights.dat';
	INPUT Region $ Height @@;
RUN;
PROC ANOVA DATA = heights;
	CLASS Region;
	MODEL Height = Region;
	MEANS Region / scheffe;
RUN;
*Region is classification variable;
*SCHEFFE test which regions are different from the others;
*p 0.0051 there are difference

