libname mydata "/courses/u_coursera.org1/i_1006328/c_5333" access=readonly;

DATA new; set mydata.gapminder_pds;

PROC SORT; by Country;

PROC FREQ; TABLES incomeperson Internetuserate;

RUN;