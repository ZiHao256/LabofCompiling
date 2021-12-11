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



# 语义分析



# 基于lex / yacc

参考：

[Lex使用指南 - 火雨(Nick) - 博客园 (cnblogs.com)](https://www.cnblogs.com/wp5719/p/5528896.html)

[(84条消息) 手把手教程-lex与yacc/flex与bison入门（一）（使用windows环境）_D-Cierra的博客-CSDN博客_flex和bison入门](https://blog.csdn.net/weixin_44007632/article/details/108666375)

## 词法分析

* flex



## 语法分析

* bison









# 基于 Rust

