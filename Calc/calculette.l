%%
[ \t]  ;
";"		    {/* printf("(%i) Lex : ;\n",makeNum());*/ return(PV);} 
"("		    {/* printf("(%i) Lex : (\n",makeNum());*/ return(PG);} 
")"		    {/* printf("(%i) Lex : )\n",makeNum());*/ return(PD);} 
"+"		    {/* printf("(%i) Lex : +\n",makeNum());*/ return(PLUS);}
"*"		    {/* printf("(%i) Lex : *\n",makeNum());*/ return(MULT);}
[0-9]+              {/* printf("(%i) Lex : cst\n",makeNum());*/
                      yylval = atoi(yytext) ;
                      /* conversion valeur lexicale en attribut entier */
                      return(CSTE) ; }
[a-zA-Z]+           { /*printf("(%i) Lex : id\n",makeNum());*/ return(ID);}



