                /* DECLARATIONS */
%{
  /* insertion de code verbatim en entête de tous les fichiers C généré par LEX ou YACC */
  
int yylex();
void yyerror(const char *s);

int makeNum ()
{
  static int n = 0;
  return ++n;
}

 int numeroR()
 {
   static int n=1;
   return n++;
 }

%}

/* TOKENS */
%token  CSTE PG PD ID  PLUS  MULT PV

%left PLUS  /* PLUS est déclaré associatif à gauche */
%left MULT  /* MULT est déclaré associatif à gauche, et il sera prioriotaire sur PLUS */

    /* START SYMBOL */
%start axiome
    /* INSERTIONS DE CODE *VERBATIM* */
%{ 
#include <stdio.h>
  #include<string.h>
#include <ctype.h>
  
%}

%% 
                /* GRAMAIRES ET ACTIONS SEMANTIQUES */

axiome		: axiome PV exp      {$$=$3;/*printf("store\n");*/}
axiome		: exp                {$$=$1;/*printf("store\n");*/}
   
;
;
exp		: exp PLUS exp {$$=$1+$3;printf("add\n");}
| exp MULT exp       {$$=$1*$3;printf("mult\n");}
| PG exp PD          {$$=($2);}
| ID                 {$$=$1;printf("load %d\n",$$);}
| CSTE               {$$=$1;printf("load %d\n",$$);}
  ;

%%
		/* CODE C */

void yyerror(const char*s)
{
  fprintf(stderr,"%s\n",s);
}
#include    "lex.yy.c"
int main() {
       yyparse();
       return 1;
       }

/*Mise en oeuvre de la grammaire E'TE'*/
/*voir ci-dessus.*/
