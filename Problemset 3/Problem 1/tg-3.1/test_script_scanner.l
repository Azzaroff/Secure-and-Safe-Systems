-------------------------------------------------------------------------------

  -- Copyright (C) 1996 by Andre Spiegel.

  -- File:           test_script_scanner.l

  -- Description:    Test_Script_Scanner is the package which scans the 
  --                 script file.
  --                 The scanner is generated by aflex.

  -- Author:         Andre Spiegel
  -- Creation Date:  Wed Jul  7 14:15:53 1993

  -- RCS: $Id: test_script_scanner.l,v 1.2 1996/05/09 12:13:57 spiegel Exp $

  -- This file is part of `tg'.

  -- `tg' is free software; you can redistribute it and/or modify
  -- it under the terms of the GNU General Public License as published by
  -- the Free Software Foundation; either version 2, or (at your option)
  -- any later version.

  -- `tg' is distributed in the hope that it will be useful,
  -- but WITHOUT ANY WARRANTY; without even the implied warranty of
  -- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  -- GNU General Public License for more details.

  -- You should have received a copy of the GNU General Public License
  -- along with `tg'; see the file COPYING.  If not, write to
  -- the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
  -- Boston, MA 02111-1307, USA.

-------------------------------------------------------------------------------
  
-- Macro definitions would go here

%s Count_White_Space Skip_White_Space Stop_Or_Continue Exception_List Pass_Clause Pass_Exception Indented_Text Comment Title_Line No_Condition

-- Rules
%%

  -- read the keywords which begin in column 1

^fail_handling  { Enter (Stop_Or_Continue);
                  return (Key_Fail_Handling); }
^error_handling { Enter (Stop_Or_Continue);
                  return (Key_Error_Handling); }
^context      { Column := 7; Enter (Count_White_Space); 
                return (Key_Context); }
^exceptions   { Column := 10; Enter (Exception_List);
                return (Key_Exceptions); }
^code         { Column := 4; Enter (Count_White_Space);
                return (Key_Code); }
^"*****"      { Column := 5; Enter (Title_Line);
                return (Key_Begin_Test_Case); }
^define       { Column := 6; Enter (Count_White_Space);
                return (Key_Define); }
^prepare      { Column := 7; Enter (Count_White_Space);
                return (Key_Prepare); }
^test         { Column := 4; Enter (Count_White_Space);
                return (Key_Test); }
^pass         { Column := 4; Enter (Pass_Clause);
                return (Key_Pass); }
^cleanup      { Column := 7; Enter (Count_White_Space);
                return (Key_Cleanup); }

  -- read the title line of a test case.

<Title_Line>[ \t]     { null; }
<Title_Line>([0-9]+)  { return (Test_Case_Number); }
<Title_Line>.*        { return (Test_Case_Title); }
<Title_Line>\n        { Line := Line + 1;
                        Enter (No_Condition); }

  -- count the whitespace after a keyword.
  -- (when done, Column contains the level of indentation,
  --  and Indented_Text is supposed to follow).

<Count_White_Space>[ \t] { Column := Column + 1; }
<Count_White_Space>.     { Unput (YYText(YYText'FIRST)); 
                           Enter (Indented_Text); }


  -- read text up to the end of the line, 
  -- then enter Skip_White_Space (possibly continue in the next call)

<Indented_Text>.*        { return (Indented_Text_Line); }
<Indented_Text>\n        { Line := Line + 1;
                           Enter (Skip_White_Space); }

  -- skip `Column' leading whitespace characters

<Skip_White_Space>^" "   { for I in 2 .. Column loop
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
                           end loop; }
<Skip_White_Space>^\t    { Enter (Indented_Text); }
<Skip_White_Space>^.     { Unput (YYText(YYText'FIRST));
                           Enter (No_Condition); }
<Skip_White_Space>^\n    { Line := Line + 1; }
<Skip_White_Space>\n     { Line := Line + 1; 
                           Enter (No_Condition); }
                             

  -- read stop or continue

<Stop_Or_Continue>[ \t]           { null; }
<Stop_Or_Continue>stop            { Enter (No_Condition);
                                    return (Key_Stop); }
<Stop_Or_Continue>continue        { Enter (No_Condition);
                                    return (Key_Continue); }

  -- read a list of exceptions
  
<Exception_List>[ \t]                      { null; }
<Exception_List>[A-Za-z_][A-Za-z_0-9"."]*  { return (Ada_Exception); }
<Exception_List>,                          { return (Colon); }
<Exception_List>\n                         { Line := Line + 1; }
<Exception_List>";"                        { Enter (No_Condition); 
                                             return (Semicolon); }

  -- read a pass clause

<Pass_Clause>[ \t]                  { Column := Column + 1; }
<Pass_Clause>=>                     { Column := Column + 2;
                                      return (Key_Normal_Path); }
<Pass_Clause>exception              { Column := Column + 9;
                                      Enter (Pass_Exception);
                                      return (Key_Exception); }
<Pass_Clause>,                      { Column := Column + 1;
                                      Enter (Count_White_Space);
                                      return (Colon); }
<Pass_Clause>.                      { Unput (YYText(YYText'FIRST));
                                      Enter (Indented_Text); }
<Pass_Clause>\n                     { Enter (No_Condition); }

  -- read the exception name of a pass clause

<Pass_Exception>[ \t]                      { Column := Column + 1; }
<Pass_Exception>[A-Za-z_][A-Za-z_0-9"."]*  { Column := Column +
                                                          YYText'Length; 
                                             return (Ada_Exception); }
<Pass_Exception>\n                         { Line := Line + 1; 
                                             Column := 0; 
                                             Enter (No_Condition); }
<Pass_Exception>,                          { Column := Column + 1;
                                             Enter (Count_White_Space); 
                                             return (Colon); }

  -- Ada style comments

<No_Condition>--                    { Enter(Comment); }
<Comment>.                          { null; }
<Comment>\n                         { Line := Line + 1; 
                                      Enter (No_Condition); }

.                                   { null; }
\n                                  { Line := Line + 1;
                                      null; }

%%
package Test_Script_Scanner is  -----------------------------------------------

  type Token is (Key_Fail_Handling, Key_Error_Handling, 
                 Key_Stop,      Key_Continue,
		 Key_Context,   Key_Exceptions, Key_Code,
                 
                 Key_Begin_Test_Case,
                 Key_Define,    Key_Prepare,   Key_Test,
                 Key_Pass,      Key_Cleanup,
		 
		 Key_Normal_Path, Key_Exception,
                 Test_Case_Number, Test_Case_Title,
                 Indented_Text_Line, Ada_Exception, Colon, Semicolon,
  
                 End_Of_Input, Error);

  procedure Next_Token;

  function Current_Token return Token;

  function Current_Line return Positive;

  function Token_Text return String;

end Test_Script_Scanner;


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
##

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
