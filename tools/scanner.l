%{
/* 定义声明*/
#include<stdio.h>

enum Token_Type{
    NEWLINE,
    CONST_ID,
    COMMENT,
    T,

    FUNC, ORIGIN, SCALE, ROT, IS, FOR, FROM, TO, STEP, DRAW,

    SEMICO, L_BRACKET, R_BRACKET, COMMA,

    PLUS, MINUS, MUL, DIV, POWER,

    NONTOKEN,
    ERRTOKEN,


};

int yylval;
/* yylval 是yacc中定义的变量，用来保存记号的属性值，默认是int类型。 
 * 在用lex实现的词法分析器中可以使用这个变量将记号的属性传递给用
 * yacc实现的语法分析器。
 *
 * 注意：该变量只有在联合使用lex和yacc编写词法和语法分析器时才可在lex
 *       中使用，此时该变量不需要定义即可使用。
 *       单独使用lex时，编译器找不到这个变量。这里定义该变量为了“欺骗”编译器。
 */
int installID();
int installCONST();

%}
num       [0-9]+(.[0-9]*)?

%%
    /* 词法规则 */

"ORIGIN"                        {return (ORIGIN);}
"SCALE"                         {return (SCALE);}
"ROT"                           {return (ROT);}
"IS"                            {return (IS);}
"FOR"                           {return (FOR);}
"FROM"                          {return (FROM);}
"TO"                            {return (TO);}
"STEP"                          {return (STEP);}
"DRAW"                          {return (DRAW);}

"SIN"                           {return (FUNC);}
"COS"                           {return (FUNC);}
"TAN"                           {return (FUNC);}
"LN"                            {return (FUNC);}
"EXP"                           {return (FUNC);}
"SQRT"                          {return (FUNC);}

"T"                             {return (T);}

{num}                       {yylval = installCONST(); return (CONST_ID);}
"PI"                        {return (CONST_ID);}
"E"                         {return (CONST_ID);}


(--|"//")[^\n]*             {return (COMMENT);}

";"                         {return (SEMICO);}
"("                         {return (L_BRACKET);}
")"                         {return (R_BRACKET);}
","                         {return (COMMA);}

"**"                        {return (POWER);}
"+"                         {return (PLUS);}
"-"                         {return (MINUS);}
"*"                         {return (MUL);}
"/"                         {return (DIV);}

(" "|\t|\n|\r|\f|\v)+       {;}

.                           {return (ERRTOKEN);}



%%
 /* 辅助函数 */
 /* yywrap这个辅助函数是词法分析器遇到输入文件结尾时会调用的，用来决定下一步怎么做：
 * 若yywrap返回0，则继续扫描；返回1，则词法分析器返回报告文件已结束的0。
 * lex库中的标准yywrap程序就是返回1，你也可以定义自己的yywrap。
 */

 int yywrap(){
    return 1;
}

// int installID(){
//     /*将词法单元装入符号表，并返回指针*/
//     return ID;
// }
int installCONST(){
    // 把词法单元装入符号表并返回指针
    return CONST_ID;
}

void writeout(int c){
    /* yytext是当前识别的词法单元（词文）的指针*/
    switch(c){
        case ERRTOKEN: fprintf(yyout, "(ERRTOKEN, \"%s\") ", yytext);
            break;
        case ORIGIN: fprintf(yyout, "(ORIGIN, \"%s\") ", yytext);
            break;  	  
        case ROT: fprintf(yyout, "(ROT, \"%s\") ", yytext);
            break;
        case IS: fprintf(yyout, "(IS, \"%s\") ", yytext);
            break;
        case FOR: fprintf(yyout, "(FOR, \"%s\") ", yytext);
            break;
        case FROM: fprintf(yyout, "(FROM, \"%s\") ", yytext);
            break;
        case TO: fprintf(yyout, "(TO, \"%s\") ", yytext);
            break;
        case STEP: fprintf(yyout, "(STEP, \"%s\") ", yytext);
            break;
        case DRAW: fprintf(yyout, "(DRAW, \"%s\") ", yytext);
            break;
        case FUNC: fprintf(yyout, "(FUNC, \"%s\") ", yytext);
            break;
        case T: fprintf(yyout, "(T, \"%s\") ", yytext);
            break;
        case CONST_ID: fprintf(yyout, "(CONST_ID, \"%s\") ", yytext);
            break;
        case COMMENT: fprintf(yyout, "(COMMENT, \"%s\") ", yytext);
            break;
        case MINUS: fprintf(yyout, "(MINUS, \"%s\") ", yytext);
            break; 
        case MUL: fprintf(yyout, "(MUL, \"%s\") ", yytext);
            break; 
        case DIV: fprintf(yyout, "(DIV, \"%s\") ", yytext);
            break; 
        case PLUS: fprintf(yyout, "(PLUS, \"%s\") ", yytext);
            break; 
        case POWER: fprintf(yyout, "(POWER, \"%s\") ", yytext);
            break;
        case SEMICO: fprintf(yyout, "(SEMICO, \"%s\") ", yytext);
            break; 
        case L_BRACKET: fprintf(yyout, "(L_BRACKET, \"%s\") ", yytext);
            break; 
        case R_BRACKET: fprintf(yyout, "(R_BRACKET, \"%s\") ", yytext);
            break; 
        case COMMA: fprintf(yyout, "(COMMA, \"%s\") ", yytext);
            break; 
        // case RIGHT: fprintf(yyout, "(RIGHT, \"%s\") ", yytext);
        //     break; 
        // case COMMA: fprintf(yyout, "(COMMA, \"%s\") ", yytext);
        //     break; 
        // case DOT: fprintf(yyout, "(DOT, \"%s\") ", yytext);
        //     break; 
        // case SEMICOLON: fprintf(yyout, "(SEMICOLON, \"%s\") ", yytext);
        //     break; 
        // case ID: fprintf(yyout, "(ID, \"%s\") ", yytext);
        //     break;     
        // case NUM: fprintf(yyout, "(NUM, \"%s\") ", yytext);
        //     break;          
        case NEWLINE: fprintf(yyout, "\n");
            break;
        default:
            break;
    }
  return;
}

int main (int argc, char ** argv){
	int c,j=0;
	if (argc>=2){
	  if ((yyin = fopen(argv[1], "r")) == NULL){
	    printf("Can't open file %s\n", argv[1]);
	    return 1;
	  }
	  if (argc>=3){
	    yyout=fopen(argv[2], "w");
	  }
	}
	/* yyin和yyout是lex中定义的输入输出文件指针，它们指明了
	 * lex生成的词法分析器从哪里获得输入和输出到哪里。
	 * 默认：键盘输入，屏幕输出。 
	 */

	while (c = yylex()){
		writeout(c);
        writeout(NEWLINE);
	}
	if(argc>=2){
	  fclose(yyin);
	  if (argc>=3) fclose(yyout);
	}
	return 0;
}