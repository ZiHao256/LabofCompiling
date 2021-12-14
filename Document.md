---
title: Document
---

* C 
* RUST
* Python



* lex / yacc

# 词法分析

* letter = [a-zA-Z_]
* digit = [0-9]
* 常数：CONST_ID : `digit+("."digit*)?` 有属性值
  * `PI`
  * `E`
* 注释：COMMENT `"//"|"--"`
* 关键词：
  * `ORIGIN`
  * `SCALE`
  * `ROT`
  * `IS`
  * `FOR`
  * `T`
  * `FROM`
  * `TO`
  * `STEP`
  * `DRAW`
  * `FUNC` :有属性地址
    * `SIN`
    * `COS`
    * `TAN`
    * `LN`
    * `EXP`
    * `SQRT`
* 分隔符
  * SEMICO `;`
  * L_BRACKET  `(`
  * R_BRACKET  `)`
  * COMMA `,`
* 运算符
  * PLUS `+`
  * MINUS `-`
  * MUL `*`
  * DIV `/`
  * POWER `**`
* 空：
* 空记号：NONTOKEN
* 出错记号：ERRTOKEN

|  记号种别  |  正规式  | 属性值 | 函数地址 |
| :--------: | :----: | :----: | :------: |
|  CONST_ID  |  "PI"  | **3.1415926** |          |
|  CONST_ID  |  "E"   | **2.71828** |          |
|  COMMENT   | `"//"|"--"` |        |          |
|  **FUNC**  | "SIN"  |        | sin |
|  **FUNC**  | "COS"  |        | cos |
|  **FUNC**  | "TAN"  |        | tan |
|  **FUNC**  |  "LN"  |        | log |
|  **FUNC**  | "EXP"  |        | exp |
|  **FUNC**  | "SQRT" |        | sqrt |
|            |        |        |          |
| **ORIGIN** |        |        |          |
| **SCALE**  |        |        |          |
|  **ROT**   |        |        |          |
|   **IS**   |        |        |          |
|  **FOR**   |        |        |          |
| T | | | |
|  **FROM**  |        |        |          |
|   **TO**   |        |        |          |
|  **STEP**  |        |        |          |
|  **DRAW**  |        |        |          |
|            |        |        |          |
| SEMICO    | ; |      |      |
| L_BRACKET | ( |      |      |
| R_BRACKET | ) |      |      |
| COMMA     | , |      |      |
|           |      |      |      |
| PLUS      | + |      |      |
| MINUS     | - |      |      |
| MUL       | * |      |      |
| DIV       | / |      |      |
| POWER     | ** |      |      |
|           |      |      |      |
| NONTOKEN | | | |
| ERRTOKEN | | | |

* 疑问：ID是否多余


# 语法分析

## 语法

```
Program: Program Statement 
```





# 语义分析

构造语法树

* 树节点：
  * Token种别: CONST_ID, PLUS, MINUS, MUL, DIV, POWER, FUNC,T
  * 若为常数
    * 只记录常数的值
  * 若为操作符
    * 构造左右子树
  * 若为函数
    * 构造子树
    * 记录函数地址
  * 若为参数
    * 记录参数地址

* 对每个Expression构造语法树MakeExprNode(TOKEN, ...)
  * CONST_ID
    * 
* 对每个Statement算出需要的绘图参数值
  * 





# 基于lex / yacc

参考：

[Lex使用指南 - 火雨(Nick) - 博客园 (cnblogs.com)](https://www.cnblogs.com/wp5719/p/5528896.html)

[(84条消息) 手把手教程-lex与yacc/flex与bison入门（一）（使用windows环境）_D-Cierra的博客-CSDN博客_flex和bison入门](https://blog.csdn.net/weixin_44007632/article/details/108666375)

## 词法分析

* flex



## 语法分析

* bison





## 借助Python的matplotlib





## 遇到的问题

* lex前导空白
* 语法不完整：FOR
* C/C++调用Python绘画：matplotlib-cpp项目
  * 基于C++调用Python的方法将matplotlib封装了一层
  * Windows:
    * [c++调用matplotlib(一) - 芒果的博客 - 芒果的个人博客 (mangoroom.cn)](https://mangoroom.cn/cpp/call-matplotlib-on-cpp.html)
    * 安装cmake
  * Linux:
    * 
* [(87条消息) [Ubuntu\]Could NOT find PythonLibs_倒霉茄子的博客-CSDN博客](https://blog.csdn.net/u011816873/article/details/74907978)
* #define YYSTEPE 
  * yylval使用
  * $也使用了

* 写struct和union的时候，把变量和类型搞混了
* va在这里是variable-argument(可变参数)的意思.这些宏定义在stdarg.h中,所以用到可变参数的程序应该包含这个头文件.
* 遭遇段错误：**printf**("%d\n",$1->TokenType);
  * 解决：不能这样用，
    * extern struct Token token;  
    * token.value
  * [(87条消息) 解决Program received signal SIGSEGV, Segmentation fault.的辛酸_QuanQuanYuanXin的博客-CSDN博客_program received signal sigsegv](https://blog.csdn.net/QuanQuanYuanXin/article/details/52883895)
  * `#define **YYSTYPE** struct ExprNode * `
  * [Flex Bison Segmentation Fault in C - Stack Overflow](https://stackoverflow.com/questions/18433204/flex-bison-segmentation-fault-in-c)
* enum tokentype OpCode
  * error: field ‘OpCode’ has incomplete type
  * 有定义，但是所在头文件没有被包含文件A中，仅仅在A中声明了，也属于不完整类型
  * 使用强制类型转换吧
* 一元负号的优先级和右结合
  * 怎么在语法树中表示
* 求表达式的值？
  * switch
  * 递归




# 基于 Python

