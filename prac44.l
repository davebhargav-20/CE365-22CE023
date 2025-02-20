/*%option noyywrap
%{
#include<stdio.h>
int l=0, lc=0, uc=0, ss=0, d=0, ec=0;
%}
%%
[0-9] {d++;  l++;}
[a-z] {lc++;  l++;}
[A-Z] {uc++;  l++;}
[@ #] {ss++;  l++;}
\n        {if(d>0 && lc>0 && uc>0 && ss>0 && l>=9 && l<=15 && ec==0 )
		printf("Valid\n");
	     else
			printf("Invalid\n");
		}
.  {ec ++ ; printf("Invalid\n");}
<<EOF>> {yyterminate();}
%%
int main()
{
printf("Enter String : ");
yylex();
return 0;
}*/

%{
#include <stdio.h>

int l = 0, lc = 0, uc = 0, ss = 0, d = 0, ec = 0; // Declare all variables
%}

%option noyywrap

%%
[0-9]    { d++; l++; } 
[a-z]    { lc++; l++; } 
[A-Z]    { uc++; l++; } 
[@#]     { ss++; l++; } 
\n       { 
            if(d > 0 && lc > 0 && uc > 0 && ss > 0 && l >= 9 && l <= 15 && ec == 0) 
                printf("Valid\n"); 
            else 
                printf("Invalid\n"); 
            // Reset counters for next input
            l = lc = uc = ss = d = ec = 0;
        }
.        { ec++; printf("Invalid\n"); }  // Fix incorrect syntax

<<EOF>>  { yyterminate(); }
%%

int main() {
int i=3;
while(i--){
    printf("Enter String : ");
    yylex();
}
    return 0;
}
