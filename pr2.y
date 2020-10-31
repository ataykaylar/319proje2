%{
      #include <stdio.h>
      #include <stdlib.h>
  int yylex();
  int yyerror(char *s);
  extern int yylineno;
  %}
%start program
%token                      SEMICOLON
%token                          COMMA
%token                           PLUS
%token                          MINUS
%token                           MULT
%token                            DIV
%token                            POW
%token                             LP
%token                             RP
%token                            LCB
%token                            RCB
%token                            AND
%token                            LOR
%token                             EQ
%token                            LEQ
%token                           LNEQ
%token                             LT
%token                            LTE
%token                             GT
%token                            GTE
%token                           LNOT
%token                          PRINT
%token                             IF
%token                           ELSE
%token                          WHILE
%token                            FOR
%token                            INT
%token                          FLOAT
%token                         STRING
%token                        BOOLEAN
%token                         RETURN
%token                        CONNECT
%token                     DISCONNECT
%token                       FUNCTION
%token                   READALTITUDE
%token                READTEMPERATURE
%token                   TURNONCAMERA
%token                  TURNOFFCAMERA
%token                     STARTVIDEO
%token                     PAUSEVIDEO
%token                      STOPVIDEO
%token                    TAKEPICTURE
%token                      SAVEMEDIA
%token                     STARTTIMER
%token                      STOPTIMER
%token                  READFROMTIMER
%token               READACCELERATION
%token                     READSPEEDX
%token                     READSPEEDY
%token                     READSPEEDZ
%token                      SETSPEEDX
%token                      SETSPEEDY
%token                      SETSPEEDZ
%token                       SETSPEED
%token                    FOLLOWCURVE
%token                      READCURVE
%token                           RISE
%token                        DESCEND
%token                           LAND
%token                    MOVEFORWARD
%token                       MOVEBACK
%token                      MOVERIGHT
%token                       MOVELEFT
%token                     ROTATELEFT
%token                    ROTATERIGHT
%token                           WAIT
%token                           SAVE
%token                           SCAN
%token                      SETHEIGHT
%token                    READBATTERY
%token                   READLOCATION
%token                    READINCLINE
%token                      STOPMOTOR
%token                 BOOLEAN_LITERAL
%token                         COMMENT
%token              IDENTIFIER_LITERAL
%token                      IP_ADDRESS
%token                 INTEGER_LITERAL
%token                   FLOAT_LITERAL
%token                  STRING_LITERAL

%nonassoc IF
%nonassoc ELSE

%left PLUS MINUS AND LT GT
%left POW MULT DIV LOR LTE GTE
%left LEQ LNEQ


%%
program   :  stmtList;

stmtList   :   stmt   SEMICOLON |  stmtList stmt   SEMICOLON    ;


stmt     :  declaration_stmt
         |  assign_stmt
         |  init_stmt
         |  if_stmt
         |  loop_stmt
         |  expr


declaration_stmt     :  funct_declaration
|  var_declaration_list;


var_declaration_list     :  var_declaration
|  var_declaration COMMA var_declaration_list;


var_declaration   : type  IDENTIFIER_LITERAL;

type: INT
| FLOAT
| STRING
| BOOLEAN;


funct_declaration   : FUNCTION type IDENTIFIER_LITERAL LP  parameter_list   RP   LCB  stmtList   RETURN  expr   SEMICOLON RCB
                      | FUNCTION type IDENTIFIER_LITERAL LP  RP   LCB  stmtList   RETURN  expr   SEMICOLON RCB
                      | FUNCTION type IDENTIFIER_LITERAL LP  RP   LCB  stmtList   RCB
                      | FUNCTION type IDENTIFIER_LITERAL LP  parameter_list   RP LCB stmtList RCB
                      | FUNCTION  IDENTIFIER_LITERAL LP  parameter_list   RP   LCB  stmtList    RCB
| FUNCTION  IDENTIFIER_LITERAL LP  RP   LCB  stmtList    RCB;


parameter_list      :  IDENTIFIER_LITERAL
| IDENTIFIER_LITERAL COMMA  parameter_list;


init_stmt     : type  assign_stmt   ;


if_stmt   : IF LP  logic_expr   RP LCB  stmtList   RCB
| IF LP  logic_expr   RP LCB  stmtList   RCB ELSE LCB  stmtList   RCB ;


loop_stmt     :  while_stmt
| for_stmt  ;


while_stmt     : WHILE LP  logic_expr   RP    LCB   stmtList   RCB
| WHILE LP  function_call_expression   RP    LCB   stmtList   RCB;


for_stmt     : FOR LP  init_stmt   SEMICOLON   logic_expr   SEMICOLON   stmt    RP LCB  stmtList   RCB;


expr     :  arithmetic_expr  ;


logic_expr   :  logic_expr   LOR  logic_expr
             | logic_expr   AND  logic_expr
             | logic_expr   LEQ  logic_expr
             |  logic_expr   LNEQ  logic_expr
             |  logic_expr   LT  logic_expr
             |  logic_expr   LTE  logic_expr
             |  logic_expr   GT  logic_expr
             |  logic_expr   GTE  logic_expr
             |   LNOT LP  arithmetic_expr   RP
             | BOOLEAN_LITERAL
             | INTEGER_LITERAL
             | FLOAT_LITERAL
             | STRING_LITERAL
| IDENTIFIER_LITERAL;


arithmetic_expr   :  arithmetic_expr   PLUS  arithmetic_expr
                  | arithmetic_expr   MINUS  arithmetic_expr
                  | arithmetic_expr   MULT  arithmetic_expr
                  | arithmetic_expr   POW  arithmetic_expr
                  | arithmetic_expr   DIV  arithmetic_expr
                  | logic_expr
                  | function_call_expression
| LP  arithmetic_expr   RP ;



function_call_expression   :  IDENTIFIER_LITERAL LP   parameter_list    RP
                           | IDENTIFIER_LITERAL LP RP
| primitive_function  ;


primitive_function   : CONNECT LP IP_ADDRESS COMMA INTEGER_LITERAL RP
| READALTITUDE LP RP
| READACCELERATION LP RP
| READTEMPERATURE LP RP
| TURNONCAMERA LP RP
| TURNOFFCAMERA LP RP
| TAKEPICTURE LP RP
| READFROMTIMER LP RP
| READSPEEDX LP RP
| READSPEEDY LP RP
| READSPEEDZ LP RP
| WAIT LP FLOAT_LITERAL RP
| WAIT LP IDENTIFIER_LITERAL RP
| SETSPEEDX LP FLOAT_LITERAL RP
| SETSPEEDX LP IDENTIFIER_LITERAL RP
| SETSPEEDY LP IDENTIFIER_LITERAL RP
| SETSPEEDY LP FLOAT_LITERAL RP
| SETSPEEDZ LP FLOAT_LITERAL RP
| SETSPEEDZ LP IDENTIFIER_LITERAL RP
| FOLLOWCURVE LP FLOAT_LITERAL RP
| FOLLOWCURVE LP IDENTIFIER_LITERAL RP
| DISCONNECT LP RP
| READCURVE LP RP
| SETHEIGHT LP FLOAT_LITERAL RP
| SETHEIGHT LP IDENTIFIER_LITERAL RP
| RISE LP FLOAT_LITERAL RP
| RISE LP IDENTIFIER_LITERAL RP
| DESCEND LP FLOAT_LITERAL RP
| DESCEND LP IDENTIFIER_LITERAL RP
| LAND LP RP
| MOVEFORWARD LP FLOAT_LITERAL RP
| MOVEFORWARD LP IDENTIFIER_LITERAL RP
| MOVEBACK LP FLOAT_LITERAL RP
| MOVEBACK LP IDENTIFIER_LITERAL RP
| MOVERIGHT LP IDENTIFIER_LITERAL RP
| MOVERIGHT LP FLOAT_LITERAL RP
| MOVELEFT LP IDENTIFIER_LITERAL RP
| MOVELEFT LP FLOAT_LITERAL RP
| STARTVIDEO LP RP
| PAUSEVIDEO LP RP
| STOPVIDEO LP RP
| READBATTERY LP RP
| STOPMOTOR LP RP
| READLOCATION LP RP
| STARTTIMER LP RP
| STOPTIMER LP RP
| SCAN LP  RP
| SAVE LP  parameter_list   RP
| ROTATELEFT LP FLOAT_LITERAL RP
| ROTATELEFT LP IDENTIFIER_LITERAL RP
| ROTATERIGHT LP FLOAT_LITERAL RP
| ROTATERIGHT LP IDENTIFIER_LITERAL RP
| READINCLINE LP RP
| PRINT LP  logic_expr   RP
| PRINT LP  function_call_expression RP ;


assign_stmt   : IDENTIFIER_LITERAL EQ  expr  ;
%%
#include "lex.yy.c"

int main() {
  return yyparse();
}

yyerror(char *s ) { printf("error in line %d: %s\n", yylineno,s); }
