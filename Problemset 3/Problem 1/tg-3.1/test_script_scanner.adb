

with Text_IO; use Text_IO;

package body Test_Script_Scanner is  ------------------------------------------

  Tok    : Token       := Error;
  Column : Natural     := 0;  -- the level of indentation for Indented Text.
  Line   : Positive    := 1;

  Discarded_Character : Character;

  function Standard_Error return Text_IO.File_Type is
  begin
    return Text_IO.Standard_Output;
  end Standard_Error;
  
-- function YYlex will go here
function YYLex return Token is
subtype short is integer range -32768..32767;
    yy_act : integer;
    yy_c : short;

-- returned upon end-of-file
YY_END_TOK : constant integer := 0;
YY_END_OF_BUFFER : constant := 49;
subtype yy_state_type is integer;
yy_current_state : yy_state_type;
INITIAL : constant := 0;
Count_White_Space : constant := 1;
Skip_White_Space : constant := 2;
Stop_Or_Continue : constant := 3;
Exception_List : constant := 4;
Pass_Clause : constant := 5;
Pass_Exception : constant := 6;
Indented_Text : constant := 7;
Comment : constant := 8;
Title_Line : constant := 9;
No_Condition : constant := 10;
yy_accept : constant array(0..495) of short :=
    (   0,
        0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
        0,    0,    0,    0,   18,   18,    0,    0,   14,   14,
        0,    0,   49,   46,   47,   46,   46,   46,   46,   46,
       46,   46,   17,   16,   17,   17,   17,   17,   17,   17,
       17,   24,   22,   21,   23,   20,   22,   22,   22,   22,
       22,   22,   22,   25,   46,   46,   46,   28,   31,   30,
       32,   29,   29,   29,   29,   29,   29,   29,   37,   33,
       38,   36,   37,   37,   37,   37,   37,   37,   37,   37,
       37,   39,   41,   42,   40,   40,   40,   40,   40,   40,
       40,   18,   19,   18,   18,   18,   18,   18,   18,   18,

       44,   45,   44,   44,   44,   44,   44,   44,   44,   14,
       12,   15,   13,   14,   14,   14,   14,   14,   14,   14,
       46,    0,    0,    0,    0,    0,    0,    0,    0,    0,
        0,    0,    0,    0,   29,   29,   29,   29,   29,   29,
       29,   29,   29,   29,   34,    0,    0,   40,   40,   40,
       40,   40,   40,   40,   40,   40,   40,   18,   18,   18,
       18,   18,   18,   18,   18,   18,   18,   18,   14,   13,
       14,   14,   14,   14,   14,   14,   14,   14,   14,   14,
       43,    0,    0,    0,    0,    0,    0,    0,    0,    0,
        0,    0,    0,    0,    0,   29,   29,   29,   29,   29,

       29,   29,   29,   29,   29,    0,    0,   40,   40,   40,
       40,   40,   40,   40,   40,   40,   40,   18,   18,   18,
       18,   18,   18,   18,   18,   18,   18,   18,   14,   14,
       14,   14,   14,   14,   14,   14,   14,   14,   14,    0,
        0,    5,    0,    0,    0,    0,    0,   10,    0,    9,
        0,   26,    0,   29,    5,   29,   29,   29,   29,   29,
       10,   29,    9,    0,    0,   40,    5,   40,   40,   40,
       40,   40,   10,   40,    9,   18,   18,    5,   18,   18,
       18,   18,   18,   10,   18,    9,   14,   14,    5,   14,
       14,   14,   14,   14,   10,   14,    9,    6,    0,    0,

        0,    0,    0,    0,    0,    0,   29,   29,   29,   29,
       29,   29,   29,    0,    0,   40,   40,   40,   40,   40,
       40,   40,    6,   18,   18,   18,   18,   18,   18,   18,
        6,   14,   14,   14,   14,   14,   14,   14,    0,    0,
        7,    0,    0,    0,    0,    0,   29,   29,    7,   29,
       29,   29,   29,    0,    0,   40,   40,    7,   40,   40,
       40,   40,   18,   18,    7,   18,   18,   18,   18,   14,
       14,    7,   14,   14,   14,   14,   11,    3,    0,    0,
        0,    8,    0,   11,    3,   29,   29,   29,    8,    0,
        0,   11,    3,   40,   40,   40,    8,   11,    3,   18,

       18,   18,    8,   11,    3,   14,   14,   14,    8,    0,
        0,    0,   27,   29,   29,   29,    0,    0,   40,   40,
       40,   18,   18,   18,   14,   14,   14,    0,    0,    0,
       29,   29,   29,   35,   35,   40,   40,   40,   18,   18,
       18,   14,   14,   14,    0,    4,    0,   29,    4,   29,
       40,    4,   40,   18,    4,   18,   14,    4,   14,    0,
        0,   29,   29,   40,   40,   18,   18,   14,   14,    0,
        0,   29,   29,   40,   40,   18,   18,   14,   14,    0,
        1,   29,    1,   40,    1,   18,    1,   14,    1,    2,
        2,    2,    2,    2,    0

    ) ;

yy_ec : constant array(ASCII.NUL..ASCII.DEL) of short :=
    (   0,
        1,    1,    1,    1,    1,    1,    1,    1,    2,    3,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
        1,    4,    1,    5,    1,    1,    1,    1,    1,    1,
        1,    6,    1,    7,    8,    5,    1,    9,    9,    9,
        9,    9,    9,    9,    9,    9,    9,    1,   10,    1,
       11,   12,    1,    1,   14,   15,   16,   17,   18,   19,
       20,   21,   22,   15,   15,   23,   15,   24,   25,   26,
       15,   27,   28,   29,   30,   15,   15,   31,   15,   15,
        1,    1,    1,    1,   13,    1,   14,   15,   16,   17,

       18,   19,   20,   21,   22,   15,   15,   23,   15,   24,
       25,   26,   15,   27,   28,   29,   30,   15,   15,   31,
       15,   15,    1,    1,    1,    1,    1
    ) ;

yy_meta : constant array(0..31) of short :=
    (   0,
        1,    1,    2,    1,    3,    1,    1,    1,    3,    1,
        1,    1,    3,    3,    3,    3,    3,    3,    3,    3,
        3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
        3
    ) ;

yy_base : constant array(0..508) of short :=
    (   0,
      630,    0,    5,   28,  629,   56,   84,    8,  112,  124,
      154,  171,  200,  212,  628,  241,  627,  268,   11,  296,
       19,  621,  628,  634,  634,  621,    0,  608,    6,  611,
       14,  606,  634,  634,  617,   15,  604,    8,  607,   28,
      602,  634,  634,  634,  634,  634,  613,   25,  600,   22,
      603,   29,  598,  634,  590,  585,   38,  634,  634,  634,
      634,    0,   41,  595,   38,  598,   53,  593,  634,  634,
      634,  634,  598,  578,  602,   45,  589,   50,  592,   57,
      587,  634,  634,  634,    0,   53,  586,   52,  589,   75,
      584,    0,  634,  595,   67,  582,   64,  585,   79,  580,

      634,  634,  591,   71,  578,   70,  581,   84,  576,    0,
        0,  634,  584,  586,   80,  573,   77,  576,  149,  571,
      580,  581,  568,  142,  566,  557,  567,  560,  553,  562,
      551,  554,  552,  143,    0,  558,  145,  556,  547,  557,
      550,  543,  552,  541,  634,  552,  551,    0,  548,  147,
      546,  537,  547,  540,  533,  542,  531,    0,  552,  539,
      162,  537,  528,  538,  531,  524,  533,  522,    0,  540,
      542,  529,  167,  527,  518,  528,  521,  514,  523,  512,
      634,  533,  524,  519,  507,  513,  509,  515,  509,  503,
      504,  500,  499,  501,  497,  511,  506,  494,  500,  496,

      502,  496,  490,  491,  487,  497,  496,  499,  494,  482,
      488,  484,  490,  484,  478,  479,  475,  497,  488,  483,
      471,  477,  473,  479,  473,  467,  468,  464,  486,  477,
      472,  460,  466,  462,  468,  462,  456,  457,  453,  475,
      456,  634,  461,  454,  450,  450,  462,  634,  460,  634,
      451,  634,  163,  448,    0,  453,  446,  442,  442,  454,
        0,  452,    0,  439,  438,  439,    0,  444,  437,  433,
      433,  445,    0,  443,    0,  450,  431,    0,  436,  429,
      425,  425,  437,    0,  435,    0,  442,  423,    0,  428,
      421,  417,  417,  429,    0,  427,    0,  634,  410,  408,

      420,  424,  407,  414,  407,  409,  402,  400,  412,  416,
      399,  406,  399,  396,  395,  393,  391,  403,  407,  390,
      397,  390,    0,  386,  384,  396,  400,  383,  390,  383,
        0,  379,  377,  389,  393,  376,  383,  376,  376,  372,
      634,  379,  377,  384,  379,  366,  369,  365,    0,  372,
      370,  377,  372,  367,  366,  361,  357,    0,  364,  362,
      369,  364,  355,  351,    0,  358,  356,  363,  358,  349,
      345,    0,  352,  350,  357,  352,  634,  634,  355,  343,
      343,  634,  348,    0,    0,  351,  339,  339,    0,  337,
      336,    0,    0,  346,  334,  333,    0,    0,    0,  340,

      299,  299,    0,    0,    0,  307,  295,  295,    0,  294,
      293,  299,  634,  287,  286,  292,  284,  283,  282,  280,
      286,  277,  272,  278,  269,  268,  274,  273,  261,  265,
      266,  254,  258,  634,  252,  262,  250,  254,  259,  247,
      250,  255,  241,  245,  243,  634,  243,  241,    0,  241,
      239,    0,  239,  233,    0,  233,  231,    0,  231,  230,
      227,  228,  225,  226,  222,  223,  175,  176,  172,  171,
      174,  169,  172,  159,  160,  146,  148,   86,   89,   87,
      634,   79,    0,   32,    0,   31,    0,    1,    0,  634,
        0,    0,    0,    0,  634,  325,  328,  331,  334,  337,

      340,  343,  346,  349,    2,    1,  352,  355
    ) ;

yy_def : constant array(0..508) of short :=
    (   0,
      496,  496,  497,  497,  496,  498,  496,    2,  499,  495,
      500,  500,  501,  495,  502,  502,  503,  503,  504,  504,
      496,    2,  495,  495,  495,  495,  495,  495,  495,  495,
      495,  495,  495,  495,  495,  495,  495,  495,  495,  495,
      495,  495,  495,  495,  495,  495,  495,  495,  495,  495,
      495,  495,  495,  495,  495,  495,  495,  495,  495,  495,
      495,  505,  505,  505,  505,  505,  505,  505,  495,  495,
      495,  495,  495,  495,  495,  495,  495,  495,  495,  495,
      495,  495,  495,  495,  506,  506,  506,  506,  506,  506,
      506,  507,  495,  507,  507,  507,  507,  507,  507,  507,

      495,  495,  495,  495,  495,  495,  495,  495,  495,  508,
      508,  495,  508,  508,  508,  508,  508,  508,  508,  508,
      495,  495,  495,  495,  495,  495,  495,  495,  495,  495,
      495,  495,  495,  495,  505,  505,  505,  505,  505,  505,
      505,  505,  505,  505,  495,  495,  495,  506,  506,  506,
      506,  506,  506,  506,  506,  506,  506,  507,  507,  507,
      507,  507,  507,  507,  507,  507,  507,  507,  508,  508,
      508,  508,  508,  508,  508,  508,  508,  508,  508,  508,
      495,  495,  495,  495,  495,  495,  495,  495,  495,  495,
      495,  495,  495,  495,  495,  505,  505,  505,  505,  505,

      505,  505,  505,  505,  505,  495,  495,  506,  506,  506,
      506,  506,  506,  506,  506,  506,  506,  507,  507,  507,
      507,  507,  507,  507,  507,  507,  507,  507,  508,  508,
      508,  508,  508,  508,  508,  508,  508,  508,  508,  495,
      495,  495,  495,  495,  495,  495,  495,  495,  495,  495,
      495,  495,  495,  505,  505,  505,  505,  505,  505,  505,
      505,  505,  505,  495,  495,  506,  506,  506,  506,  506,
      506,  506,  506,  506,  506,  507,  507,  507,  507,  507,
      507,  507,  507,  507,  507,  507,  508,  508,  508,  508,
      508,  508,  508,  508,  508,  508,  508,  495,  495,  495,

      495,  495,  495,  495,  495,  495,  505,  505,  505,  505,
      505,  505,  505,  495,  495,  506,  506,  506,  506,  506,
      506,  506,  507,  507,  507,  507,  507,  507,  507,  507,
      508,  508,  508,  508,  508,  508,  508,  508,  495,  495,
      495,  495,  495,  495,  495,  495,  505,  505,  505,  505,
      505,  505,  505,  495,  495,  506,  506,  506,  506,  506,
      506,  506,  507,  507,  507,  507,  507,  507,  507,  508,
      508,  508,  508,  508,  508,  508,  495,  495,  495,  495,
      495,  495,  495,  505,  505,  505,  505,  505,  505,  495,
      495,  506,  506,  506,  506,  506,  506,  507,  507,  507,

      507,  507,  507,  508,  508,  508,  508,  508,  508,  495,
      495,  495,  495,  505,  505,  505,  495,  495,  506,  506,
      506,  507,  507,  507,  508,  508,  508,  495,  495,  495,
      505,  505,  505,  495,  495,  506,  506,  506,  507,  507,
      507,  508,  508,  508,  495,  495,  495,  505,  505,  505,
      506,  506,  506,  507,  507,  507,  508,  508,  508,  495,
      495,  505,  505,  506,  506,  507,  507,  508,  508,  495,
      495,  505,  505,  506,  506,  507,  507,  508,  508,  495,
      495,  505,  505,  506,  506,  507,  507,  508,  508,  495,
      505,  506,  507,  508,    0,  495,  495,  495,  495,  495,

      495,  495,  495,  495,  495,  495,  495,  495
    ) ;

yy_nxt : constant array(0..665) of short :=
    (   0,
      495,  495,   25,  148,  135,   26,   34,   25,   34,   54,
      495,   54,  111,  112,  111,   27,   28,   29,   30,  113,
      494,   25,  123,   57,  124,   31,  121,  129,   32,   34,
       25,   34,  126,   35,  126,   56,  127,  123,  127,  124,
      130,  129,  129,   36,   37,   38,   39,  123,  126,  124,
      493,  492,  127,   40,  130,  130,   41,   44,   45,   46,
      123,   47,  134,  136,  139,  137,  142,  123,  140,  124,
      129,   48,   49,   50,   51,  149,  126,  150,  152,  143,
      147,   52,  153,  130,   53,   54,   25,   54,  155,  160,
      163,  161,  166,  123,  164,  124,  126,  129,  491,   55,

      127,  156,  172,  175,  173,  167,  490,  176,  489,  488,
      130,   56,   24,   58,   59,   58,   24,   24,   60,   24,
       24,   61,   24,   24,   24,   58,   59,   58,   24,   26,
       60,   24,   24,   61,   24,   24,   62,   62,   62,   63,
       64,   65,   66,   62,   62,   62,   62,   62,   62,   67,
       62,   62,   68,   62,   62,   70,   71,   70,  184,  184,
       72,  197,  178,  209,   73,  185,  195,  487,  198,  486,
      210,   74,   70,   71,   70,  179,   75,   72,  220,  485,
      300,   73,  484,  231,  306,  221,   76,   77,   78,   79,
      232,  483,  482,  481,  480,  479,   80,  478,  477,   81,

       24,   82,   83,   82,   24,   24,   84,   24,   24,   24,
       24,   24,   24,   82,   83,   82,   24,   26,   84,   24,
       24,   24,   24,   24,   85,   85,   85,   86,   87,   88,
       89,   85,   85,   85,   85,   85,   85,   90,   85,   85,
       91,   85,   85,   93,  476,  475,   94,  474,  473,  472,
      471,  470,  469,  468,  467,  466,   95,   96,   97,   98,
      465,  464,  463,  462,  461,  460,   99,  459,  458,  100,
      102,  457,  456,  103,  455,  454,  453,  452,  451,  446,
      450,  449,  448,  104,  105,  106,  107,  447,  446,  445,
      444,  443,  442,  108,  441,  440,  109,  111,  112,  111,

      439,  114,  438,  437,  113,  436,  435,  434,  433,  432,
      431,  115,  116,  117,  118,  430,  429,  428,  427,  426,
      425,  119,  424,  423,  120,   24,   24,   24,   33,   33,
       33,   43,   43,   43,   62,   62,   62,   69,   69,   69,
       85,   85,   85,   92,   92,   92,  101,  101,  101,  110,
      110,  110,  158,  422,  158,  169,  421,  169,  420,  419,
      418,  417,  416,  415,  414,  413,  412,  411,  410,  409,
      408,  407,  406,  405,  404,  403,  402,  401,  400,  399,
      398,  397,  396,  395,  394,  393,  392,  391,  390,  389,
      388,  387,  386,  385,  384,  383,  382,  381,  380,  379,

      378,  377,  376,  375,  374,  373,  372,  371,  370,  369,
      368,  367,  366,  365,  364,  363,  362,  361,  360,  359,
      358,  357,  356,  355,  354,  353,  352,  351,  350,  349,
      348,  347,  346,  345,  344,  343,  342,  341,  340,  339,
      338,  337,  336,  335,  334,  333,  332,  331,  330,  329,
      328,  327,  326,  325,  324,  323,  322,  321,  320,  319,
      318,  317,  316,  315,  314,  313,  312,  311,  310,  309,
      308,  307,  306,  305,  304,  303,  302,  301,  300,  299,
      298,  297,  296,  295,  294,  293,  292,  291,  290,  289,
      288,  287,  286,  285,  284,  283,  282,  281,  280,  279,

      278,  277,  276,  275,  274,  273,  272,  271,  270,  269,
      268,  267,  266,  265,  264,  263,  262,  261,  260,  259,
      258,  257,  256,  255,  254,  253,  252,  251,  250,  249,
      248,  247,  246,  245,  244,  243,  242,  241,  240,  239,
      238,  237,  236,  235,  234,  233,  230,  229,  170,  228,
      227,  226,  225,  224,  223,  222,  219,  218,  217,  216,
      215,  214,  213,  212,  211,  208,  207,  206,  205,  204,
      203,  202,  201,  200,  199,  196,  194,  193,  192,  191,
      190,  189,  188,  187,  186,  183,  182,  181,  180,  177,
      174,  171,  170,  131,  128,  125,  122,  168,  165,  162,

      159,  157,  154,  151,  131,  128,  125,  122,  146,  145,
      144,  141,  138,  133,  132,  131,  128,  125,  122,  131,
      128,  125,  122,  131,  128,  125,  122,  495,  121,  102,
       93,   42,   25,   23,  495,  495,  495,  495,  495,  495,
      495,  495,  495,  495,  495,  495,  495,  495,  495,  495,
      495,  495,  495,  495,  495,  495,  495,  495,  495,  495,
      495,  495,  495,  495,  495
    ) ;

yy_chk : constant array(0..665) of short :=
    (   0,
        0,    0,    2,  506,  505,    2,    3,    3,    3,    8,
        0,    8,   19,   19,   19,    2,    2,    2,    2,   19,
      488,   21,   27,    8,   27,    2,   21,   31,    2,    4,
        4,    4,   29,    4,   38,    8,   29,   36,   38,   36,
       31,   40,   52,    4,    4,    4,    4,   48,   50,   48,
      486,  484,   50,    4,   40,   52,    4,    6,    6,    6,
       57,    6,   57,   63,   65,   63,   67,   76,   65,   76,
       80,    6,    6,    6,    6,   86,   78,   86,   88,   67,
       78,    6,   88,   80,    6,    7,    7,    7,   90,   95,
       97,   95,   99,  104,   97,  104,  106,  108,  482,    7,

      106,   90,  115,  117,  115,   99,  480,  117,  479,  478,
      108,    7,    9,    9,    9,    9,    9,    9,    9,    9,
        9,    9,    9,    9,   10,   10,   10,   10,   10,   10,
       10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
       10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
       10,   10,   10,   10,   10,   11,   11,   11,  124,  134,
       11,  137,  119,  150,   11,  124,  134,  477,  137,  476,
      150,   11,   12,   12,   12,  119,   12,   12,  161,  475,
      253,   12,  474,  173,  253,  161,   12,   12,   12,   12,
      173,  473,  472,  471,  470,  469,   12,  468,  467,   12,

       13,   13,   13,   13,   13,   13,   13,   13,   13,   13,
       13,   13,   14,   14,   14,   14,   14,   14,   14,   14,
       14,   14,   14,   14,   14,   14,   14,   14,   14,   14,
       14,   14,   14,   14,   14,   14,   14,   14,   14,   14,
       14,   14,   14,   16,  466,  465,   16,  464,  463,  462,
      461,  460,  459,  457,  456,  454,   16,   16,   16,   16,
      453,  451,  450,  448,  447,  445,   16,  444,  443,   16,
       18,  442,  441,   18,  440,  439,  438,  437,  436,  435,
      433,  432,  431,   18,   18,   18,   18,  430,  429,  428,
      427,  426,  425,   18,  424,  423,   18,   20,   20,   20,

      422,   20,  421,  420,   20,  419,  418,  417,  416,  415,
      414,   20,   20,   20,   20,  412,  411,  410,  408,  407,
      406,   20,  402,  401,   20,  496,  496,  496,  497,  497,
      497,  498,  498,  498,  499,  499,  499,  500,  500,  500,
      501,  501,  501,  502,  502,  502,  503,  503,  503,  504,
      504,  504,  507,  400,  507,  508,  396,  508,  395,  394,
      391,  390,  388,  387,  386,  383,  381,  380,  379,  376,
      375,  374,  373,  371,  370,  369,  368,  367,  366,  364,
      363,  362,  361,  360,  359,  357,  356,  355,  354,  353,
      352,  351,  350,  348,  347,  346,  345,  344,  343,  342,

      340,  339,  338,  337,  336,  335,  334,  333,  332,  330,
      329,  328,  327,  326,  325,  324,  322,  321,  320,  319,
      318,  317,  316,  315,  314,  313,  312,  311,  310,  309,
      308,  307,  306,  305,  304,  303,  302,  301,  300,  299,
      296,  294,  293,  292,  291,  290,  288,  287,  285,  283,
      282,  281,  280,  279,  277,  276,  274,  272,  271,  270,
      269,  268,  266,  265,  264,  262,  260,  259,  258,  257,
      256,  254,  251,  249,  247,  246,  245,  244,  243,  241,
      240,  239,  238,  237,  236,  235,  234,  233,  232,  231,
      230,  229,  228,  227,  226,  225,  224,  223,  222,  221,

      220,  219,  218,  217,  216,  215,  214,  213,  212,  211,
      210,  209,  208,  207,  206,  205,  204,  203,  202,  201,
      200,  199,  198,  197,  196,  195,  194,  193,  192,  191,
      190,  189,  188,  187,  186,  185,  184,  183,  182,  180,
      179,  178,  177,  176,  175,  174,  172,  171,  170,  168,
      167,  166,  165,  164,  163,  162,  160,  159,  157,  156,
      155,  154,  153,  152,  151,  149,  147,  146,  144,  143,
      142,  141,  140,  139,  138,  136,  133,  132,  131,  130,
      129,  128,  127,  126,  125,  123,  122,  121,  120,  118,
      116,  114,  113,  109,  107,  105,  103,  100,   98,   96,

       94,   91,   89,   87,   81,   79,   77,   75,   74,   73,
       68,   66,   64,   56,   55,   53,   51,   49,   47,   41,
       39,   37,   35,   32,   30,   28,   26,   23,   22,   17,
       15,    5,    1,  495,  495,  495,  495,  495,  495,  495,
      495,  495,  495,  495,  495,  495,  495,  495,  495,  495,
      495,  495,  495,  495,  495,  495,  495,  495,  495,  495,
      495,  495,  495,  495,  495
    ) ;


-- copy whatever the last rule matched to the standard output

procedure ECHO is
begin
   if (text_io.is_open(user_output_file)) then
     text_io.put( user_output_file, yytext );
   else
     text_io.put( yytext );
   end if;
end ECHO;

-- enter a start condition.
-- Using procedure requires a () after the ENTER, but makes everything
-- much neater.

procedure ENTER( state : integer ) is
begin
     yy_start := 1 + 2 * state;
end ENTER;

-- action number for EOF rule of a given start state
function YY_STATE_EOF(state : integer) return integer is
begin
     return YY_END_OF_BUFFER + state + 1;
end YY_STATE_EOF;

-- return all but the first 'n' matched characters back to the input stream
procedure yyless(n : integer) is
begin
        yy_ch_buf(yy_cp) := yy_hold_char; -- undo effects of setting up yytext
        yy_cp := yy_bp + n;
        yy_c_buf_p := yy_cp;
        YY_DO_BEFORE_ACTION; -- set up yytext again
end yyless;

-- redefine this if you have something you want each time.
procedure YY_USER_ACTION is
begin
        null;
end;

-- yy_get_previous_state - get the state just before the EOB char was reached

function yy_get_previous_state return yy_state_type is
    yy_current_state : yy_state_type;
    yy_c : short;
    yy_bp : integer := yytext_ptr;
begin
    yy_current_state := yy_start;
    if ( yy_ch_buf(yy_bp-1) = ASCII.LF ) then
	yy_current_state := yy_current_state + 1;
    end if;

    for yy_cp in yytext_ptr..yy_c_buf_p - 1 loop
	yy_c := yy_ec(yy_ch_buf(yy_cp));
	if ( yy_accept(yy_current_state) /= 0 ) then
	    yy_last_accepting_state := yy_current_state;
	    yy_last_accepting_cpos := yy_cp;
	end if;
	while ( yy_chk(yy_base(yy_current_state) + yy_c) /= yy_current_state ) loop
	    yy_current_state := yy_def(yy_current_state);
	    if ( yy_current_state >= 496 ) then
		yy_c := yy_meta(yy_c);
	    end if;
	end loop;
	yy_current_state := yy_nxt(yy_base(yy_current_state) + yy_c);
    end loop;

    return yy_current_state;
end yy_get_previous_state;

procedure yyrestart( input_file : file_type ) is
begin
   open_input(text_io.name(input_file));
end yyrestart;

begin -- of YYLex
<<new_file>>
        -- this is where we enter upon encountering an end-of-file and
        -- yywrap() indicating that we should continue processing

    if ( yy_init ) then
        if ( yy_start = 0 ) then
            yy_start := 1;      -- first start state
        end if;

        -- we put in the '\n' and start reading from [1] so that an
        -- initial match-at-newline will be true.

        yy_ch_buf(0) := ASCII.LF;
        yy_n_chars := 1;

        -- we always need two end-of-buffer characters.  The first causes
        -- a transition to the end-of-buffer state.  The second causes
        -- a jam in that state.

        yy_ch_buf(yy_n_chars) := YY_END_OF_BUFFER_CHAR;
        yy_ch_buf(yy_n_chars + 1) := YY_END_OF_BUFFER_CHAR;

        yy_eof_has_been_seen := false;

        yytext_ptr := 1;
        yy_c_buf_p := yytext_ptr;
        yy_hold_char := yy_ch_buf(yy_c_buf_p);
        yy_init := false;
    end if; -- yy_init

    loop                -- loops until end-of-file is reached


        yy_cp := yy_c_buf_p;

        -- support of yytext
        yy_ch_buf(yy_cp) := yy_hold_char;

        -- yy_bp points to the position in yy_ch_buf of the start of the
        -- current run.
	yy_bp := yy_cp;
	yy_current_state := yy_start;
	if ( yy_ch_buf(yy_bp-1) = ASCII.LF ) then
	    yy_current_state := yy_current_state + 1;
	end if;
	loop
		yy_c := yy_ec(yy_ch_buf(yy_cp));
		if ( yy_accept(yy_current_state) /= 0 ) then
		    yy_last_accepting_state := yy_current_state;
		    yy_last_accepting_cpos := yy_cp;
		end if;
		while ( yy_chk(yy_base(yy_current_state) + yy_c) /= yy_current_state ) loop
		    yy_current_state := yy_def(yy_current_state);
		    if ( yy_current_state >= 496 ) then
			yy_c := yy_meta(yy_c);
		    end if;
		end loop;
		yy_current_state := yy_nxt(yy_base(yy_current_state) + yy_c);
	    yy_cp := yy_cp + 1;
if ( yy_current_state = 495 ) then
    exit;
end if;
	end loop;
	yy_cp := yy_last_accepting_cpos;
	yy_current_state := yy_last_accepting_state;

<<next_action>>
	    yy_act := yy_accept(yy_current_state);
            YY_DO_BEFORE_ACTION;
            YY_USER_ACTION;

        if aflex_debug then  -- output acceptance info. for (-d) debug mode
            text_io.put( Standard_Error, "--accepting rule #" );
            text_io.put( Standard_Error, INTEGER'IMAGE(yy_act) );
            text_io.put_line( Standard_Error, "(""" & yytext & """)");
        end if;


<<do_action>>   -- this label is used only to access EOF actions
            case yy_act is
		when 0 => -- must backtrack
		-- undo the effects of YY_DO_BEFORE_ACTION
		yy_ch_buf(yy_cp) := yy_hold_char;
		yy_cp := yy_last_accepting_cpos;
		yy_current_state := yy_last_accepting_state;
		goto next_action;



  -- read the keywords which begin in column 1

when 1 => 
--# line 44 "test_script_scanner.l"
 Enter (Stop_Or_Continue);
                  return (Key_Fail_Handling); 

when 2 => 
--# line 46 "test_script_scanner.l"
 Enter (Stop_Or_Continue);
                  return (Key_Error_Handling); 

when 3 => 
--# line 48 "test_script_scanner.l"
 Column := 7; Enter (Count_White_Space); 
                return (Key_Context); 

when 4 => 
--# line 50 "test_script_scanner.l"
 Column := 10; Enter (Exception_List);
                return (Key_Exceptions); 

when 5 => 
--# line 52 "test_script_scanner.l"
 Column := 4; Enter (Count_White_Space);
                return (Key_Code); 

when 6 => 
--# line 54 "test_script_scanner.l"
 Column := 5; Enter (Title_Line);
                return (Key_Begin_Test_Case); 

when 7 => 
--# line 56 "test_script_scanner.l"
 Column := 6; Enter (Count_White_Space);
                return (Key_Define); 

when 8 => 
--# line 58 "test_script_scanner.l"
 Column := 7; Enter (Count_White_Space);
                return (Key_Prepare); 

when 9 => 
--# line 60 "test_script_scanner.l"
 Column := 4; Enter (Count_White_Space);
                return (Key_Test); 

when 10 => 
--# line 62 "test_script_scanner.l"
 Column := 4; Enter (Pass_Clause);
                return (Key_Pass); 

when 11 => 
--# line 64 "test_script_scanner.l"
 Column := 7; Enter (Count_White_Space);
                return (Key_Cleanup); 

  -- read the title line of a test case.
when 12 => 
--# line 69 "test_script_scanner.l"
 null; 

when 13 => 
--# line 70 "test_script_scanner.l"
 return (Test_Case_Number); 

when 14 => 
--# line 71 "test_script_scanner.l"
 return (Test_Case_Title); 

when 15 => 
--# line 72 "test_script_scanner.l"
 Line := Line + 1;
                        Enter (No_Condition); 

  -- count the whitespace after a keyword.
  -- (when done, Column contains the level of indentation,
  --  and Indented_Text is supposed to follow).
when 16 => 
--# line 79 "test_script_scanner.l"
 Column := Column + 1; 

when 17 => 
--# line 80 "test_script_scanner.l"
 Unput (YYText(YYText'FIRST)); 
                           Enter (Indented_Text); 

  -- read text up to the end of the line, 
  -- then enter Skip_White_Space (possibly continue in the next call)
when 18 => 
--# line 87 "test_script_scanner.l"
 return (Indented_Text_Line); 

when 19 => 
--# line 88 "test_script_scanner.l"
 Line := Line + 1;
                           Enter (Skip_White_Space); 

  -- skip `Column' leading whitespace characters
when 20 => 
--# line 93 "test_script_scanner.l"
 for I in 2 .. Column loop
                             Discarded_Character := Input;
                             case Discarded_Character is
                               when ' '      => if I = Column then
                                                  Enter (Indented_Text);
                                                  exit;
                                                end if;
                               when ASCII.HT => Enter (Indented_Text);
                                                exit;
                               when ASCII.LF => Line := Line + 1;
                                                exit;
                               when others   => Unput (Discarded_Character);
                                                Enter (Indented_Text);
                                                exit; 
                             end case;
                           end loop; 

when 21 => 
--# line 109 "test_script_scanner.l"
 Enter (Indented_Text); 

when 22 => 
--# line 110 "test_script_scanner.l"
 Unput (YYText(YYText'FIRST));
                           Enter (No_Condition); 

when 23 => 
--# line 112 "test_script_scanner.l"
 Line := Line + 1; 

when 24 => 
--# line 113 "test_script_scanner.l"
 Line := Line + 1; 
                           Enter (No_Condition); 

  -- read stop or continue
when 25 => 
--# line 119 "test_script_scanner.l"
 null; 

when 26 => 
--# line 120 "test_script_scanner.l"
 Enter (No_Condition);
                                    return (Key_Stop); 

when 27 => 
--# line 122 "test_script_scanner.l"
 Enter (No_Condition);
                                    return (Key_Continue); 

  -- read a list of exceptions
when 28 => 
--# line 127 "test_script_scanner.l"
 null; 

when 29 => 
--# line 128 "test_script_scanner.l"
 return (Ada_Exception); 

when 30 => 
--# line 129 "test_script_scanner.l"
 return (Colon); 

when 31 => 
--# line 130 "test_script_scanner.l"
 Line := Line + 1; 

when 32 => 
--# line 131 "test_script_scanner.l"
 Enter (No_Condition); 
                                             return (Semicolon); 

  -- read a pass clause
when 33 => 
--# line 136 "test_script_scanner.l"
 Column := Column + 1; 

when 34 => 
--# line 137 "test_script_scanner.l"
 Column := Column + 2;
                                      return (Key_Normal_Path); 

when 35 => 
--# line 139 "test_script_scanner.l"
 Column := Column + 9;
                                      Enter (Pass_Exception);
                                      return (Key_Exception); 

when 36 => 
--# line 142 "test_script_scanner.l"
 Column := Column + 1;
                                      Enter (Count_White_Space);
                                      return (Colon); 

when 37 => 
--# line 145 "test_script_scanner.l"
 Unput (YYText(YYText'FIRST));
                                      Enter (Indented_Text); 

when 38 => 
--# line 147 "test_script_scanner.l"
 Enter (No_Condition); 

  -- read the exception name of a pass clause
when 39 => 
--# line 151 "test_script_scanner.l"
 Column := Column + 1; 

when 40 => 
--# line 152 "test_script_scanner.l"
 Column := Column +
                                                          YYText'Length; 
                                             return (Ada_Exception); 

when 41 => 
--# line 155 "test_script_scanner.l"
 Line := Line + 1; 
                                             Column := 0; 
                                             Enter (No_Condition); 

when 42 => 
--# line 158 "test_script_scanner.l"
 Column := Column + 1;
                                             Enter (Count_White_Space); 
                                             return (Colon); 

  -- Ada style comments
when 43 => 
--# line 164 "test_script_scanner.l"
 Enter(Comment); 

when 44 => 
--# line 165 "test_script_scanner.l"
 null; 

when 45 => 
--# line 166 "test_script_scanner.l"
 Line := Line + 1; 
                                      Enter (No_Condition); 

when 46 => 
--# line 169 "test_script_scanner.l"
 null; 

when 47 => 
--# line 170 "test_script_scanner.l"
 Line := Line + 1;
                                      null; 

when 48 => 
--# line 173 "test_script_scanner.l"
raise AFLEX_SCANNER_JAMMED;
when YY_END_OF_BUFFER + INITIAL + 1 |
YY_END_OF_BUFFER + Count_White_Space + 1 |
YY_END_OF_BUFFER + Skip_White_Space + 1 |
YY_END_OF_BUFFER + Stop_Or_Continue + 1 |
YY_END_OF_BUFFER + Exception_List + 1 |
YY_END_OF_BUFFER + Pass_Clause + 1 |
YY_END_OF_BUFFER + Pass_Exception + 1 |
YY_END_OF_BUFFER + Indented_Text + 1 |
YY_END_OF_BUFFER + Comment + 1 |
YY_END_OF_BUFFER + Title_Line + 1 |
YY_END_OF_BUFFER + No_Condition + 1 => 
    return End_Of_Input;
                when YY_END_OF_BUFFER =>
                    -- undo the effects of YY_DO_BEFORE_ACTION
                    yy_ch_buf(yy_cp) := yy_hold_char;

                    yytext_ptr := yy_bp;

                    case yy_get_next_buffer is
                        when EOB_ACT_END_OF_FILE =>
                            begin
                            if ( yywrap ) then
                                -- note: because we've taken care in
                                -- yy_get_next_buffer() to have set up yytext,
                                -- we can now set up yy_c_buf_p so that if some
                                -- total hoser (like aflex itself) wants
                                -- to call the scanner after we return the
                                -- End_Of_Input, it'll still work - another
                                -- End_Of_Input will get returned.

                                yy_c_buf_p := yytext_ptr;

                                yy_act := YY_STATE_EOF((yy_start - 1) / 2);

                                goto do_action;
                            else
                                --  start processing a new file
                                yy_init := true;
                                goto new_file;
                            end if;
                            end;
                        when EOB_ACT_RESTART_SCAN =>
                            yy_c_buf_p := yytext_ptr;
                            yy_hold_char := yy_ch_buf(yy_c_buf_p);
                        when EOB_ACT_LAST_MATCH =>
                            yy_c_buf_p := yy_n_chars;
                            yy_current_state := yy_get_previous_state;

                            yy_cp := yy_c_buf_p;
                            yy_bp := yytext_ptr;
                            goto next_action;
                        when others => null;
                        end case; -- case yy_get_next_buffer()
                when others =>
                    text_io.put( "action # " );
                    text_io.put( INTEGER'IMAGE(yy_act) );
                    text_io.new_line;
                    raise AFLEX_INTERNAL_ERROR;
            end case; -- case (yy_act)
        end loop; -- end of loop waiting for end of file
end YYLex;
--# line 173 "test_script_scanner.l"

  procedure Next_Token is begin Tok := YYLex; end Next_Token;

  function Current_Token return Token is
  begin
    return Tok;
  end Current_Token;

  function Current_Line return Positive is
  begin
    return Line;
  end Current_Line;

  function Token_Text return String is
  begin
    return YYText;
  end Token_Text;

end Test_Script_Scanner;
