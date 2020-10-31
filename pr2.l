%{
#include <stdlib.h>
#include <stdio.h>
%}
%option yylineno
%%
";"                           {return SEMICOLON;}
","                           {return COMMA;}
"+"                           {return PLUS; }
"-"                           {return MINUS; }
"("                           {return LP; }
")"                           {return RP; }
"{"                           {return LCB; }
"}"                           {return RCB; }
"&&"                          {return LAND; }
"||"                          {return LOR; }
"="                           {return EQ; }
"=="                          {return LEQ; }
"!="                          {return LNEQ; }
"<"                           {return LT; }
"<="                          {return LTE; }
">"                           {return GT; }
">="                          {return GTE; }
"^"                           {return POW; }
!                             {return LNOT; }
log                           {return PRINT; }
else                          {return ELSE; }
if                            {return IF; }
while                         {return WHILE; }
for                           {return FOR; }
int                           {return INT; }
float      {return FLOAT; }
string      {return STRING; }
boolean      {return BOOLEAN; }
return                        {return RETURN; }
Connect                       {return CONNECT; }
Disconnect                    {return DISCONNECT; }
function                      {return FUNCTION; }
ReadAltitude                  {return READALTITUDE; }
ReadTemperature               {return READTEMPERATURE; }
TurnOnCamera                  {return TURNONCAMERA; }
TurnOffCamera                 {return TURNOFFCAMERA; }
StartVideo                    {return STARTVIDEO; }
PauseVideo                    {return PAUSEVIDEO; }
StopVideo                     {return STOPVIDEO; }
TakePicture                   {return TAKEPICTURE; }
SaveMedia                     {return SAVEMEDIA; }
StartTimer                    {return STARTTIMER; }
StopTimer                     {return STOPTIMER; }
ReadFromTimer                 {return READFROMTIMER; }
ReadAcceleration              {return READACCELERATION; }
ReadSpeedX                    {return READSPEEDX; }
ReadSpeedY                    {return READSPEEDY; }
ReadSpeedZ                    {return READSPEEDZ; }
SetSpeedX                     {return SETSPEEDX; }
SetSpeedY                     {return SETSPEEDY; }
SetSpeedZ                     {return SETSPEEDZ; }
SetSpeed                      {return SETSPEED; }
FollowCurve                   {return FOLLOWCURVE; }
ReadCurve                     {return READCURVE; }
Rise                          {return RISE; }
Descend                       {return DESCEND; }
Land                          {return LAND; }
MoveForward                   {return MOVEFORWARD; }
MoveBack                      {return MOVEBACK; }
MoveRight                     {return MOVERIGHT; }
MoveLeft                      {return MOVELEFT; }
RotateLeft                    {return ROTATELEFT; }
RotateRight                   {return ROTATERIGHT; }
Wait                          {return WAIT; }
ReadBattery                   {return READBATTERY; }
ReadLocation                  {return READLOCATION; }
ReadIncline                   {return READINCLINE; }
StopMotor                     {return STOPMOTOR; }
"true"|"false"                {return BOOLEAN_LITERAL; }
#(.+[ \t]*)+                  {return COMMENT;}
[A-zA-z_$]+(A-Za-z_$|[0-9])*  {return IDENTIFIER_LITERAL;}
[0-9]+.[0-9]+.[0-9]+.[0-9]+   {return IP_ADDRESS ;}
[+-]?[0-9]+                   {return INTEGER_LITERAL;}
[+-]?[0-9]*(\.)?[0-9]+        {return FLOAT_LITERAL;}
\"(.+[ \t]*)+\"               {return STRING_LITERAL;}
[ /t/n]+                      ;
.                             ;
%%

int yywrap(){
   return 1;
}
