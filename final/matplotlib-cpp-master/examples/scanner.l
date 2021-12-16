%{
    /* 定义声明*/
#include"main.hpp"
#include"y.tab.hpp"
unsigned int LineNo;        // 记录行号

    // 定义变量
struct Token token;

    // 声明函数
extern "C"{
    int yywrap(void);
    int yylex(void);
}

%}
    // 状态
%x comment_entry 

number      [0-9]+(\.[0-9]*)?
ws          [\t]+
newline     \n
comments    "//"|"--"

%%
  /* 第二部分是词法规则部分。 */
  /* 写在这一部分的注释要有前导空格，否则lex编译出错。*/
  /* 翻译规则的形式是：正规式  {动作}
   * 其中，正规式要顶行首写，动作要以C语法写（动作会被拷贝到yylex()函数中，），\
   * 正规式和动作之间要用空白分割。
   */

{comments}                      {BEGIN comment_entry;}
{ws}                            {;}
{newline}                       {LineNo++; printf("\n");}

    /* 关键词 */
"ORIGIN"                        {printf("(ORIGIN,) "); return (ORIGIN);}
"SCALE"                         {printf("(SCALE,) "); return (SCALE);}
"ROT"                           {printf("(ROT,) ") ; return (ROT);}
"IS"                            {printf("(IS,) ") ; return (IS);}
"FOR"                           {printf("(FOR,) "); return (FOR);}
"FROM"                          {printf("(FROM,)"); return (FROM);}
"TO"                            {printf("(TO,) "); return (TO);}
"STEP"                          {printf("(STEP,) "); return (STEP);}
"DRAW"                          {printf("(DRAW,) "); return (DRAW);}

    /* 参数 */
"T"                             {printf("(T,) "); return (T);}

    /* 函数 */
"SIN"                           {printf("(FUNC, SIN) "); token.type=FUNC; token.FuncPtr=sin; return (FUNC);}
"COS"                           {printf("(FUNC, COS) "); token.type=FUNC; token.FuncPtr=cos; return (FUNC);}
"TAN"                           {printf("(FUNC, TAN) "); token.type=FUNC; token.FuncPtr=tan; return (FUNC);}
"LN"                            {printf("(FUNC, LN) "); token.type=FUNC; token.FuncPtr=log; return (FUNC);}
"EXP"                           {printf("(FUNC, EXP) "); token.type=FUNC; token.FuncPtr=exp; return (FUNC);}
"SQRT"                          {printf("(FUNC, SQRT) "); token.type=FUNC; token.FuncPtr=sqrt; return (FUNC);}


    /* 常数 */
{number}                    {token.type = CONST_ID; token.value = atof(yytext); printf("(CONST_ID, %f) ",token.value); return (CONST_ID);}
"PI"                        {token.type = CONST_ID; token.value = 3.1415926; printf("(CONST_ID, %f) ",token.value); return (CONST_ID);}
"E"                         {token.type = CONST_ID; token.value = 2.7; printf("(CONST_ID, %f) ",token.value); return (CONST_ID);}

    /* 分隔符 */
";"                         {return (SEMICO);}
"("                         {return (L_BRACKET);}
")"                         {return (R_BRACKET);}
","                         {return (COMMA);}

    /* 运算符 */
"**"                        {printf("(POWER) "); return (POWER);}
"+"                         {printf("(PLUS) "); return (PLUS);}
"-"                         {printf("(MINUS) "); return (MINUS);}
"*"                         {printf("(MUL) "); return (MUL);}
"/"                         {printf("(DIV) "); return (DIV);}

(" "|\t|\n|\r|\f|\v)+       {;}

.                           {return (ERRTOKEN);}


<comment_entry>. ;
<comment_entry>\n   BEGIN 0; LineNo++;

%%

int yywrap(void){
    return 1;
}
