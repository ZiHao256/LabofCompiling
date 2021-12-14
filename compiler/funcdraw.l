%{
    /* 定义声明*/
#include"semantics.h"
#include"y.tab.h"
unsigned int LineNo;        // 记录行号
struct Token tokens;        // 记号


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
{newline}                       {LineNo++;}

    /* 关键词 */
"ORIGIN"                        {return (ORIGIN);}
"SCALE"                         {return (SCALE);}
"ROT"                           {return (ROT);}
"IS"                            {return (IS);}
"FOR"                           {return (FOR);}
"FROM"                          {return (FROM);}
"TO"                            {return (TO);}
"STEP"                          {return (STEP);}
"DRAW"                          {return (DRAW);}

    /* 参数 */
"T"                             {return (T);}

    /* 函数 */
"SIN"                           {tokens.type=FUNC; tokens.FuncPtr=sin; return (FUNC);}
"COS"                           {tokens.type=FUNC; tokens.FuncPtr=cos; return (FUNC);}
"TAN"                           {tokens.type=FUNC; tokens.FuncPtr=tan; return (FUNC);}
"LN"                            {tokens.type=FUNC; tokens.FuncPtr=log; return (FUNC);}
"EXP"                           {tokens.type=FUNC; tokens.FuncPtr=exp; return (FUNC);}
"SQRT"                          {tokens.type=FUNC; tokens.FuncPtr=sqrt; return (FUNC);}


    /* 常数 */
{number}                    {tokens.type = CONST_ID; tokens.value = atof(yytext); return (CONST_ID);}
"PI"                        {tokens.type = CONST_ID; tokens.value = 3.1415926; printf("(CONST_ID,%f,%s)",tokens.value,yytext);return (CONST_ID);}
"E"                         {tokens.type = CONST_ID; tokens.value = 2.7; return (CONST_ID);}

    /* 分隔符 */
";"                         {return (SEMICO);}
"("                         {return (L_BRACKET);}
")"                         {return (R_BRACKET);}
","                         {return (COMMA);}

    /* 运算符 */
"**"                        {return (POWER);}
"+"                         {return (PLUS);}
"-"                         {return (MINUS);}
"*"                         {return (MUL);}
"/"                         {return (DIV);}

(" "|\t|\n|\r|\f|\v)+       {;}

.                           {return (ERRTOKEN);}


<comment_entry>. ;
<comment_entry>\n   BEGIN 0; LineNo++;

%%
    /* 辅助函数可以定义“动作”中使用的一些函数。这些函数
    * 使用C语言编写，并会直接被拷贝到lex.yy.c中。
    */

    /* yywrap这个辅助函数是词法分析器遇到输入文件结尾时会调用的，用来决定下一步怎么做：
    * 若yywrap返回0，则继续扫描；返回1，则词法分析器返回报告文件已结束的0。
    * lex库中的标准yywrap程序就是返回1，你也可以定义自己的yywrap。
    */

    /* 辅助函数里可以使用yytext和yyleng这些外部定义的变量。
    * yytext指向输入缓冲区当前词法单元(lexeme)的第一个字符，
    * yyleng给出该词法单元的长度		*/

    /* 如果你的词法分析器并不是作为语法分析器的子程序，
    * 而是有自己的输入输出，你可以在这里定义你的词法
    * 分析器的main函数，main函数里可以调用yylex()
    */




    //     // int installID(){
    //     //     /*将词法单元装入符号表，并返回指针*/
    //     //     return ID;
    //     // }
    // int installCONST(){
    //     // 把词法单元装入符号表并返回指针
    //     return CONST_ID;
    // }

    // void writeout(int c){
    //     /* yytext是当前识别的词法单元（词文）的指针*/
    //     switch(c){
    //         case ERRTOKEN: fprintf(yyout, "(ERRTOKEN, \"%s\") ", yytext);
    //             break;
    //         case ORIGIN: fprintf(yyout, "(ORIGIN, \"%s\") ", yytext);
    //             break;  	  
    //         case ROT: fprintf(yyout, "(ROT, \"%s\") ", yytext);
    //             break;
    //         case IS: fprintf(yyout, "(IS, \"%s\") ", yytext);
    //             break;
    //         case FOR: fprintf(yyout, "(FOR, \"%s\") ", yytext);
    //             break;
    //         case FROM: fprintf(yyout, "(FROM, \"%s\") ", yytext);
    //             break;
    //         case TO: fprintf(yyout, "(TO, \"%s\") ", yytext);
    //             break;
    //         case STEP: fprintf(yyout, "(STEP, \"%s\") ", yytext);
    //             break;
    //         case DRAW: fprintf(yyout, "(DRAW, \"%s\") ", yytext);
    //             break;
    //         case FUNC: fprintf(yyout, "(FUNC, \"%s\") ", yytext);
    //             break;
    //         case T: fprintf(yyout, "(T, \"%s\") ", yytext);
    //             break;
    //         case CONST_ID: fprintf(yyout, "(CONST_ID, \"%s\") ", yytext);
    //             break;
    //         case COMMENT: fprintf(yyout, "(COMMENT, \"%s\") ", yytext);
    //             break;
    //         case MINUS: fprintf(yyout, "(MINUS, \"%s\") ", yytext);
    //             break; 
    //         case MUL: fprintf(yyout, "(MUL, \"%s\") ", yytext);
    //             break; 
    //         case DIV: fprintf(yyout, "(DIV, \"%s\") ", yytext);
    //             break; 
    //         case PLUS: fprintf(yyout, "(PLUS, \"%s\") ", yytext);
    //             break; 
    //         case POWER: fprintf(yyout, "(POWER, \"%s\") ", yytext);
    //             break;
    //         case SEMICO: fprintf(yyout, "(SEMICO, \"%s\") ", yytext);
    //             break; 
    //         case L_BRACKET: fprintf(yyout, "(L_BRACKET, \"%s\") ", yytext);
    //             break; 
    //         case R_BRACKET: fprintf(yyout, "(R_BRACKET, \"%s\") ", yytext);
    //             break; 
    //         case COMMA: fprintf(yyout, "(COMMA, \"%s\") ", yytext);
    //             break; 
    //         // case RIGHT: fprintf(yyout, "(RIGHT, \"%s\") ", yytext);
    //         //     break; 
    //         // case COMMA: fprintf(yyout, "(COMMA, \"%s\") ", yytext);
    //         //     break; 
    //         // case DOT: fprintf(yyout, "(DOT, \"%s\") ", yytext);
    //         //     break; 
    //         // case SEMICOLON: fprintf(yyout, "(SEMICOLON, \"%s\") ", yytext);
    //         //     break; 
    //         // case ID: fprintf(yyout, "(ID, \"%s\") ", yytext);
    //         //     break;     
    //         // case NUM: fprintf(yyout, "(NUM, \"%s\") ", yytext);
    //         //     break;          
    //         case NEWLINE: fprintf(yyout, "\n");
    //             break;
    //         default:
    //             break;
    //     }
    //     return;
    // }