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
%start E
    /* INSERTIONS DE CODE *VERBATIM* */
%{ 
#include <stdio.h>
  #include<string.h>
#include <ctype.h>
  
%}

%% 
                /* GRAMAIRES ET ACTIONS SEMANTIQUES */
 /*accociativité respectée.(%left)*/ 

E		: T EP      {$$=$2; printf("Resultat=%d\n",$$);} /*espacage important entre les non-terminaux)*/
/*T est GERE APRES!!*/
;

EP		:  {$$=$0;}
                 | PLUS T EP {$$=$0+$3;}
;

T		: F TP {$$=$2;}
;

TP              : {$$=$0;}
                | MULT F TP {$$=$0*$3;}
;

F               : ID {$$=$1;}
                | CSTE     {$$=$1;}
                | PG E PD {$$=$2;}


//regle dans la syntaxe de Yacc :  toujours, axiome: axiome;pv {}
//puis | pv{}...

/*utiliser les nons des terminaux soit les otkens PLUS et MULT au lieu de + et *!!!*/

//car pas de yylval=atoi(yytext) dans le .l. c'est un %i.(specificateur)
//et voilà!!!
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


//syntax error ou bien CRTL-D pour eviter cela affiche le resultat qui n'y était pas
//vient du fait que la continuité de la lecture de l'arbre à la fin pose un probleme
//commun avec ce type de grammaire LK(K dans l'ensemble des entiers naturels \{0}).
