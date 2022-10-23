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

axiome		: axiome PV exp      {$$=numeroR();
   /*   printf("(%i) Yacc : S -> E ; S\n rslt:%d\n",makeNum(),$$);  }*/
   printf("r%d = r%d ; r%d\n",$$,$1,$3);}
axiome		: exp                {$$=$1;}
   /*   printf("(%i) Yacc : S -> E ;\n \t rslt:%d\n",makeNum(),$$);}*/
;
;
exp		: exp PLUS exp       {$$=numeroR();
  /*  printf("(%i) Yacc : E -> E + E\n \t rslt:%d\n",makeNum(),$$); }*/
  printf("r%d=r%i + r%i",$$, $1, $3);}
| exp MULT exp       {$$=numeroR();
  /*  printf("(%i) Yacc : E -> E * E\n \t rslt:%d\n",makeNum(),$$); }*/
  printf("r%d=r%i * r%i;\n",$$,$1,$3);}
| PG exp PD          {$$=($2);}
  /*  printf("(%i) Yacc : E -> (E)\n \t rslt:%d\n",makeNum(),$$); }*/
| ID                 {$$=numeroR();
  /*  printf("(%i) Yacc : E -> id\n \t rslt:%d\n",  makeNum(), $$); } */
  printf("r%d=%d\n",$$,$1);}
| CSTE               {$$=numeroR();
  /*  printf("(%i) Yacc : E -> cste\n \t rslt:%d\n",makeNum(),$$); }*/
  printf("r%d=%d\n",$$,$1);}
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


