-------------------------------------------------------------------------------

  -- Copyright (C) 1996, 1997 by Andre Spiegel.

  -- File:           translator.adb

  -- Description:    <to be supplied>

  -- Author:         Andre Spiegel
  -- Creation Date:  Wed Jul 14 08:49:49 1993

  -- RCS: $Id: translator.adb,v 1.4 1997/02/17 14:47:09 spiegel Exp $

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

with Text_IO;             use Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;
with Test_Script_Scanner; use Test_Script_Scanner;
with Test_Script_Parser;  use Test_Script_Parser;

package body Translator is

  package ASU renames Ada.Strings.Unbounded;

  function "&" (Left  : in ASU.Unbounded_String;
                Right : in String) return String is
  begin
     return ASU.To_String (Left) & Right;
  end "&";

  function "&" (Left  : in String;
                Right : in ASU.Unbounded_String) return String is
  begin
     return Left & ASU.To_String (Right);
  end "&";


  procedure Translate (Input_File   : in Text_IO.File_Type;  ------------------
                       Output_File  : in Text_IO.File_Type;
                       Error_Stream : in Text_IO.File_Type;
                       Unit_Name    : in String;
                       Fail_Output  : in Output_Mode;
                       Pass_Output  : in Output_Mode) is

    -- Variables
    ------------
  
    Indent : Natural := 0;  -- number of spaces to be inserted 
                            -- before every LOC produced.

    Indent_Step     : constant Natural  := 2;
    Max_Path_Length : constant Positive := 256;

    General_Part     : General_Part_Type;

    Test_Case_Number : Positive := 1;    

    -- Local Procedures
    -------------------

    function Purged_Exception_List  -------------------------------------------
               (Complete_List : in Exception_Lists.List;
                Subtract_List : in Exception_Lists.List) 
                                      return Exception_Lists.List is
      -- returns an exception list that contains those names
      -- from Complete_List which do not occur in Subtract_List
      use Exception_Lists;
      I      : ListIter;
      Result : List;
    begin
      Result := Create;
      I := MakeListIter (Complete_List);
      while More (I) loop
        if not IsInList (Subtract_List, CellValue (I)) then
          Attach (Result, CellValue (I));
        end if;
        Forward (I);
      end loop;
      return Result;
    end Purged_Exception_List;
                                   

    procedure Put_Indented (Line : in String) is  -----------------------------
    begin
      for I in 1 .. Indent loop
        Put (' ');
      end loop;
      Put_Line (Line);
    end Put_Indented;

    procedure Put_Indented (Code_List : Code_Lists.List) is
      use Code_Lists;
      I    : ListIter;
    begin
      I := MakeListIter (Code_List);
      while More (I) loop
        for J in 1 .. Indent loop Put (' '); end loop;
        Put_Line (ASU.To_String (CellValue (I)));
        Forward (I);
      end loop;
    end Put_Indented;
        
    procedure Put_Indent is
    begin
      for I in 1 .. Indent loop
        Put (' ');
      end loop;
    end Put_Indent;

    function Quoted (Data : in String) return String is  ----------------------
       -- return Data with quotes expanded to double quotes
    begin
       if Data'Length = 0 then
          return "";
       elsif Data (Data'First) = '"' then
          return """""" 
                 & Quoted (Data (Data'First + 1 .. Data'Last));
       else
          return Data (Data'First) 
                 & Quoted (Data (Data'First + 1 .. Data'Last));
       end if;
    end Quoted;

    function Quoted (Data : in ASU.Unbounded_String) 
                     return ASU.Unbounded_String is
    begin
       return ASU.To_Unbounded_String (Quoted (ASU.To_String (Data)));
    end Quoted;
       
    procedure Put_Fail (Test_Case          : in Test_Case_Type;  --------------
                        Comment_Expression : in String := "") is
                          -- note that `Comment_Expression' is 
                          -- _not_ the same as `Comment' in Put_Pass
    begin
      Put_Indented ("Driver_Internals.Test_Case_Passed := False;");
      Put_Indented ("Driver_Internals.Fail_Result := True;");
      case Fail_Output is
        when Off     => 
          null;
        when Numbers => 
          Put_Indent; Put ("Put_Line (""("); Put (Test_Case_Number, 0);
          Put_Line (") FAIL."");");
        when Titles => 
          if not (    Pass_Output in Titles..Full 
                  and Fail_Output in Titles..Full) then
            Put_Indent; Put ("Put_Line (""("); Put (Test_Case_Number, 0);
            Put_Line (") " & Quoted (Test_Case.Title) & """);" );
          end if;
          Put_Indented ("Put_Line (""      ...FAIL."");");
        when Full =>
          if not (    Pass_Output in Titles..Full 
                  and Fail_Output in Titles..Full) then
            Put_Indent; Put ("Put_Line (""("); Put (Test_Case_Number, 0);
            Put_Line (") " & Quoted (Test_Case.Title) & """);" );
          end if;
          Put_Indented ("Put_Line (""      ...FAIL."");");
          Put_Indented ("Put_Line (""         ("" & " 
                                   & Comment_Expression & " & "")"");");
      end case;
      if General_Part.Fail_Handling = Stop then
        Put_Indented ("raise Driver_Internals.Program_Terminate;");
      end if;
    end Put_Fail;


    procedure Put_Pass (Test_Case : in Test_Case_Type;  -----------------------
                        Comment   : in String := "") is
    begin
      Put_Indented ("Driver_Internals.Test_Case_Passed := True;");
      case Pass_Output is
        when Off     => 
          null;
        when Numbers => 
          Put_Indent; Put ("Put_Line (""("); Put (Test_Case_Number, 0);
          Put_Line (") pass."");");
        when Titles => 
          if not (    Pass_Output in Titles..Full 
                  and Fail_Output in Titles..Full) then
            Put_Indent; Put ("Put_Line (""("); Put (Test_Case_Number, 0);
            Put_Line (") " & Quoted (Test_Case.Title) & """);" );
          end if;
          Put_Indented ("Put_Line (""      ...pass."");");
        when Full =>
          if not (    Pass_Output in Titles..Full 
                  and Fail_Output in Titles..Full) then
            Put_Indent; Put ("Put_Line (""("); Put (Test_Case_Number, 0);
            Put_Line (") " & Quoted (Test_Case.Title) & """);" );
          end if;
          Put_Indented ("Put_Line (""      ...pass."");");
          Put_Indented ("Put_Line (""         (" & Comment & ")"");");
      end case;
    end Put_Pass;

    function Path_Names (Names : Exception_Lists.List)  -----------------------
                                           return String is
      use Exception_Lists;
      use type ASU.Unbounded_String;
      I      : ListIter;
      Choice : ASU.Unbounded_String;
    begin
      I := MakeListIter (Names);
      Choice := ASU.Null_Unbounded_String;
      loop
        exit when not More (I);
        Choice := Choice & CellValue (I);
        Forward (I);
        if More (I) then Choice := Choice & "|"; end if;
      end loop;
      return ASU.To_String (Choice);
    end Path_Names;

    procedure Put_Handler (Name          : ASU.Unbounded_String;  -------------
                           Text_Before   : in String  := "`";
                           Text_After    : in String  := "' was raised.";
                           Abort_Program : in Boolean := False;
                           Set_Error     : in Boolean := False) is
    begin
      Put_Indented ("when " & Name & " =>");
      Indent := Indent + Indent_Step;
      Put_Indented ("Put_Line (""" & Text_Before & Name 
                                   & Text_After & """);");
      if Set_Error then
        Put_Indented ("Driver_Internals.Unexpected_Error := True;");
      end if;
      if Abort_Program then
        Put_Indented ("raise Driver_Internals.Program_Terminate;");
      end if;
      Indent := Indent - Indent_Step;
    end Put_Handler;
    
    procedure Put_General_Handlers (Part_Name : in String) is  ----------------
      use Exception_Lists;
      I : ListIter;
    begin
      Put_Indented ("exception");
      Indent := Indent + Indent_Step;
      if not IsEmpty (General_Part.Exceptions) then
        I := MakeListIter (General_Part.Exceptions);
        while More (I) loop
          Put_Handler (CellValue (I),
                       Text_Before   => "ERROR: exception `",
                       Text_After    => "', " & Part_Name 
                                        & " of test case"
                                        & Positive'Image (Test_Case_Number)
                                        & ".",
                       Abort_Program => General_Part.Error_Handling = Stop,
                       Set_Error     => True);
          Forward (I);
        end loop;
      end if;
      Put_Indented ("when Driver_Internals.Program_Terminate =>");
      Put_Indented ("  raise;");
      Put_Indented ("when E: others =>");
      Put_Indented ("  Driver_Internals.Unexpected_Error := True;");
      Put_Indented ("  Put_Line (""ERROR: exception "" & Ada.Exceptions.Exception_Name (E) & "" raised in "
                    & Part_Name 
                    & " of test case" 
                    & Positive'Image (Test_Case_Number) 
                    & "."");" );
      if General_Part.Error_Handling = Stop then
        Put_Indented ("  raise Driver_Internals.Program_Terminate;");
      end if;
      Indent := Indent - Indent_Step;
    end Put_General_Handlers;


    procedure Put_Part (Lines     : in Code_Lists.List;  ----------------------
                        Part_Name : in String) is
    begin
      Put_Indented ("begin  -- " & Part_Name);
      Indent := Indent + Indent_Step;
      Put_Indented (Lines);
      Indent := Indent - Indent_Step;
      Put_General_Handlers (Part_Name);
      Put_Indented ("end;  -- " & Part_Name);
      New_Line;
    end Put_Part;


    procedure Put_Test_Part (Test_Case : Test_Case_Type) is -------------------
      use Pass_Clause_Lists, Exception_Lists;
      I             : Pass_Clause_Lists.ListIter;
      Handled, Rest : Exception_Lists.List;
      J             : Exception_Lists.ListIter;
    begin
      Put_Indented ("begin  -- test part");
      Indent := Indent + Indent_Step;
      Put_Indented (Test_Case.Test_Part);
      Put_Indented ("Driver_Internals.Set_Path (""=>"");");
      Indent := Indent - Indent_Step;
      Put_Indented ("exception");
      Indent := Indent + Indent_Step;

      I       := MakeListIter (Test_Case.Pass_Part);
      Handled := Create; 
      while More (I) loop
        if ASU.To_String (CellValue(I).Path) /= "=>" then
          Put_Indented ("when " & CellValue(I).Path & " =>");
          Put_Indented ("  Driver_Internals.Set_Path (""" 
                        & CellValue(I).Path & """);");
          Attach (Handled, CellValue(I).Path);          
        end if;
        Forward (I);
      end loop;

      Rest := Purged_Exception_List (General_Part.Exceptions, Handled);
      J := MakeListIter (Rest);
      while More (J) loop
        Put_Indented ("when " & CellValue(J) & " =>");
        Put_Indented ("  Driver_Internals.Set_Path (""" 
                        & CellValue(J) & """);");
        Forward (J);
      end loop;

      Put_Indented ("when E: others =>");
      Put_Indented ("  Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));");
      Indent := Indent - Indent_Step;
      Put_Indented ("end;  -- test part");
    end Put_Test_Part;


    procedure Put_Predicate_Check (Test_Case : Test_Case_Type;  ---------------
                                   Path      : in ASU.Unbounded_String;
                                   Predicate : in Code_Lists.List) is
      use Code_Lists;
      I : ListIter;
      L : Natural;
    begin
      L := Length (Predicate);  -- number of lines
      if L = 1 then
        Put_Indented ("if " & FirstValue (Predicate) & " then");
        Indent := Indent + Indent_Step;
      else
        Put_Indented ("if " & FirstValue (Predicate));
        Indent := Indent + 3;
        I := MakeListIter (Predicate);
        Forward (I);
        for J in 2 .. L loop
          if J < L then
            Put_Indented (ASU.To_String (CellValue (I)));
          else
            Put_Indented (CellValue (I) & " then");
          end if;
          Forward (I);
        end loop;
        Indent := Indent - 3 + Indent_Step;
      end if;
      Put_Pass (Test_Case, "path `" & Path & "' was taken and predicate is TRUE");
      Indent := Indent - Indent_Step;
      Put_Indented ("else");
      Indent := Indent + Indent_Step;
      Put_Fail (Test_Case, """path `" & Path & "' was taken, but predicate is FALSE""");
      Indent := Indent - Indent_Step;
      Put_Indented ("end if;");
    end Put_Predicate_Check;


    procedure Put_Result_Part (Test_Case : Test_Case_Type) is -----------------
      use Code_Lists, Pass_Clause_Lists, Exception_Lists;
      Expected_Paths : Exception_Lists.List;
      I    : Pass_Clause_Lists.ListIter;
      J    : Code_Lists.List;
    begin
      Put_Indented ("begin  -- result part");
      Expected_Paths := Create;
      Indent := Indent + Indent_Step;
      I := MakeListIter (Test_Case.Pass_Part);
      Attach (Expected_Paths, CellValue(I).Path);
      Put_Indented ("if Driver_Internals.Path_Was (""" 
                     & CellValue(I).Path & """) then");
      loop
        Indent := Indent + Indent_Step;
        if not IsEmpty (CellValue(I).Predicate) then
          Put_Predicate_Check (Test_Case, 
                               CellValue(I).Path, CellValue(I).Predicate);
        else
          Put_Pass (Test_Case, "path `" & CellValue(I).Path 
                               & "' was taken");
        end if;
        Indent := Indent - Indent_Step;
        Forward (I);
        exit when not More (I);
        Attach (Expected_Paths, CellValue(I).Path);
        Put_Indented ("elsif Driver_Internals.Path_Was ("""
                      & CellValue(I).Path & """) then");
      end loop;

      Put_Indented ("else");
      Indent := Indent + Indent_Step;
      Put_Fail (Test_Case, """path `"" & Driver_Internals.Taken_Path & ""' when `" & Path_Names (Expected_Paths) & "' was expected""");
      Indent := Indent - Indent_Step;
      Put_Indented ("end if;");

      Indent := Indent - Indent_Step;
      Put_General_Handlers ("result part");
      Destroy (Expected_Paths);
      Put_Indented ("end;  -- result part");
    end Put_Result_Part;


    procedure Put_Header is  --------------------------------------------------
    begin
      Put_Line ("-------------------------------------------------------------------------------");
      New_Line;
      Put_Line ("  -- University of Stuttgart, Germany");
      Put_Line ("  -- Computer Science, Software Engineering Dept.");
      Put_Line ("  -----------------------------------------------");
      New_Line;
      Put_Line ("  -- Test Driver Source");
      New_Line;
      Put_Line ("  -- File:       " & Name (Output_File));
      Put_Line ("  -- Script:     " & Name (Input_File));
      New_Line;
      Put_Line ("  -- ******************************************************************");
      Put_Line ("  -- * This file was automatically generated by the `tg' program.     *");
      Put_Line ("  -- * Modifications should be made in the corresponding script file. *");
      Put_Line ("  -- ******************************************************************");
      New_Line;
      Put_Line ("-------------------------------------------------------------------------------");
      New_Line;
      Put_Line ("with Ada.Command_Line, Ada.Exceptions;");
      Put_Line ("use type Ada.Command_Line.Exit_Status;");
      New_Line;
      Indent := 0;
    end Put_Header;

    procedure Put_Trailer is  -------------------------------------------------
    begin
      New_Line;
      Put_Line ("  --  End of test cases");
      Put_Line ("  New_Line;");
      Put_Line ("  Put (""Total test result: "");");
      Put_Line ("  if Driver_Internals.Fail_Result then");
      Put_Line ("    Put (""FAIL"");");
      Put_Line ("    Driver_Internals.Status := 1;");
      Put_Line ("  else");
      Put_Line ("    Put (""pass"");");
      Put_Line ("    Driver_Internals.Status := 0;");
      Put_Line ("  end if;");
      if General_Part.Error_Handling = Continue then
        Put_Line ("  if Driver_Internals.Unexpected_Error then");
        Put_Line ("    Put_Line ("","");");
        Put_Line ("    Put_Line (""        there were one or more unexpected errors"");");
        Put_Line ("    Driver_Internals.Status := -1;");
        Put_Line ("  else");
        Put_Line ("    Put_Line (""."");");
        Put_Line ("  end if;");
      else 
        Put_Line ("  Put_Line (""."");");
      end if;
      Put_Line ("  New_Line;");
      Put_Line ("  Ada.Command_Line.Set_Exit_Status (Driver_Internals.Status);");
      New_Line;
      Put_Line ("exception");
      Put_Line ("  when Driver_Internals.Program_Terminate =>");
      Put_Line ("    New_Line;");
      Put_Line ("    Put (""Total test result: "");");
      Put_Line ("    if Driver_Internals.Fail_Result then");
      Put_Line ("      Put (""FAIL"");");
      Put_Line ("      Driver_Internals.Status := 1;");
      Put_Line ("    else");
      Put_Line ("      Put (""UNDEFINED"");");
      Put_Line ("      Driver_Internals.Status := -1;");
      Put_Line ("    end if;");
      Put_Line ("    if Driver_Internals.Unexpected_Error then");
      Put_Line ("      Put_Line ("","");");
      Put_Line ("      Put_Line (""        there were one or more errors outside of test cases."");");
      Put_Line ("      Driver_Internals.Status := -1;");
      Put_Line ("    else");
      Put_Line ("      Put_Line (""."");");
      Put_Line ("    end if;");
      Put_Line ("    New_Line;");
      Put_Line ("    Ada.Command_Line.Set_Exit_Status (Driver_Internals.Status);");
      Put_Line ("  when E: others =>");
      Put_Line ("    New_Line;");
      Put_Line ("    Put_Line (""Unexpected exception "" & Ada.Exceptions.Exception_Name (E) & "" propagating out of driver."");");
      Put_Line ("    Put_Line (""Results are undefined."");");
      Put_Line ("    Driver_Internals.Status := -1;");
      Put_Line ("    Ada.Command_Line.Set_Exit_Status (Driver_Internals.Status);");
      New_Line;
      Put_Line ("end " & Unit_Name & ";");
    end Put_Trailer;
    
    procedure Translate_General_Part is  --------------------------------------
      use Code_Lists;
    begin 
      Get_General_Part (General_Part);
      Indent := 0;
      Put_Indented (General_Part.Context);
      New_Line;
      Put_Line ("procedure " & Unit_Name & " is");
      New_Line;
      Indent := Indent_Step;
      Put_Indented ("package Driver_Internals is");
      Put_Indented ("  -- Global Data");
      Put_Indented ("  Program_Terminate     : exception;");
      Put_Indented ("  Fail_Result           : Boolean := False;");
      Put_Indented ("  Unexpected_Error      : Boolean := False;");
      Put_Indented ("  Status                : Ada.Command_Line.Exit_Status := 0;");
      Put_Indented ("  -- Data of last Test Case");
      Put_Indented ("  Test_Case_Passed      : Boolean := False;");
      Put_Indented ("  -- Access Routines");
      Put_Indented ("  procedure Set_Path (Path : in String);");
      Put_Indented ("  function Path_Was (Path : in String) return Boolean;");
      Put_Indented ("  function Taken_Path return String;");
      Put_Indented ("  function Passed return Boolean;");
      Put_Indented ("  function Failed return Boolean;");
      Put_Indented ("end Driver_Internals;");
      New_Line;
      if not IsEmpty (General_Part.Define_Part) then
        Put_Indented ("-- Global definitions from script");
        Put_Indented (General_Part.Define_Part);
        New_Line;
      end if;
      Put_Indented ("package body Driver_Internals is");
      Put_Indented ("  -- Data of last Test Case");
      Put_Indented ("  Test_Case_Path        : String (1.. 256);");
      Put_Indented ("  Test_Case_Path_Length : Natural := 0;");
      Put_Indented ("  -- Access Routines");
      Put_Indented ("  procedure Set_Path (Path : in String) is");
      Put_Indented ("    begin");
      Put_Indented ("      Test_Case_Path (Test_Case_Path'First..Path'Length) := Path;");
      Put_Indented ("      Test_Case_Path_Length := Path'Length;");
      Put_Indented ("    end Set_Path;");
      Put_Indented ("  function Path_Was (Path : in String) return Boolean is");
      Put_Indented ("    begin");
      Put_Indented ("      return Test_Case_Path_Length = Path'Length");
      Put_Indented ("          and then Test_Case_Path (1..Path'Length) = Path;");
      Put_Indented ("    end Path_Was;");
      Put_Indented ("  function Taken_Path return String is");
      Put_Indented ("    begin return Test_Case_Path (1..Test_Case_Path_Length); end Taken_Path;");
      Put_Indented ("  function Passed return Boolean is");
      Put_Indented ("    begin return Test_Case_Passed; end Passed;");
      Put_Indented ("  function Failed return Boolean is");
      Put_Indented ("    begin return not Test_Case_Passed; end Failed;");
      Put_Indented ("end Driver_Internals;");
      New_Line;
      Put_Line ("begin  -- unit main block");
    end Translate_General_Part;      
      
    procedure Translate_Code is  ----------------------------------------------
      use Exception_Lists;
      Code   : Code_Lists.List;
      I      : Exception_Lists.ListIter;
    begin
      Get_Code_Part (Code);
      New_Line;
      Put_Indented ("-- Code section");
      Put_Indented ("begin");
      Indent := Indent + Indent_Step;
      Put_Indented (Code);

      if not IsEmpty (General_Part.Exceptions) then
        Indent := Indent - Indent_Step;
        Put_Indented ("exception");
        Indent := Indent + Indent_Step;
        I := MakeListIter (General_Part.Exceptions);
        while More (I) loop
          Put_Handler (CellValue(I),
                       Text_Before   => "ERROR: exception `",
                       Text_After    => "', code part.",
                       Abort_Program => General_Part.Error_Handling = Stop,
                       Set_Error     => TRUE);
          Forward (I);
        end loop;
      end if;

      Indent := Indent - Indent_Step;
      Put_Indented ("end;  -- code block");
    end Translate_Code;
    
    procedure Translate_Test_Case is  -----------------------------------------
      use Code_Lists;
      Test_Case : Test_Case_Type;
    begin
      Get_Test_Case (Test_Case);
      if Test_Case.Number /= 0 and then
         Test_Case.Number /= Test_Case_Number then
        Put_Line (Error_Stream, "tg: Warning: test case number `" 
                  & Natural'Image (Test_Case.Number) 
                  & "' in script file is inconsistent.");
        Put_Line (Error_Stream, 
                  "             The correct number is"
                  & Natural'Image (Test_Case_Number) 
                  & " (this will be used in the testdriver).");
        New_Line (Error_Stream);
      end if;

      New_Line;
      Put_Indent; 
      Put ("-- Test Case ("); Put (Test_Case_Number, 0); 
      Put_Line (")  " & Test_Case.Title);

      if not IsEmpty (Test_Case.Define_Part) then
        Put_Indented ("declare");
        Indent := Indent + Indent_Step;
        Put_Indented (Test_Case.Define_Part);
        Indent := Indent - Indent_Step;
      end if;

      Put_Indented ("begin  -- test case");
      Indent := Indent + Indent_Step;

      if     Pass_Output in Titles..Full
         and Fail_Output in Titles..Full then
        Put_Indent; Put ("Put_Line (""("); Put (Test_Case_Number, 0);
        Put_Line (") " & Quoted (Test_Case.Title) & """);" );
      end if;

      if not IsEmpty (Test_Case.Prepare_Part) then
        Put_Part (Test_Case.Prepare_Part, "prepare part");
      end if;

      Put_Test_Part (Test_Case);
      Put_Result_Part (Test_Case);

      if not IsEmpty (Test_Case.Cleanup_Part) then
        Put_Part (Test_Case.Cleanup_Part, "cleanup part");
      end if;

      Indent := Indent - Indent_Step;
      Put_Indented ("end;  -- test case");
    end Translate_Test_Case;
    

  begin  -- Translate

    Set_Output (Output_File);
    Set_Input  (Input_File);
  
    Put_Header;
    
    Next_Token;
    Translate_General_Part;

    loop
      case Test_Script_Scanner.Current_Token is
        when End_Of_Input => 
          exit;
        when Key_Begin_Test_Case => 
          Translate_Test_Case;
          Test_Case_Number := Test_Case_Number + 1;
        when Key_Code => 
          Translate_Code;
        when Error => 
          raise Syntax_Error;
        when others =>
          raise Syntax_Error;
      end case;
    end loop;

    Put_Trailer;

    Set_Output (Standard_Output);
    Set_Input (Standard_Input);

  exception
    when Use_Error | Status_Error | Mode_Error =>
      raise File_Error;
      
    when Syntax_Error | Parse_Error =>
      Put_Line (Error_Stream, "tg: Syntax Error at line " 
                              & Integer'Image (Test_Script_Scanner.Current_Line));
      raise Syntax_Error;

    when Semantic_Error =>
      Put_Line (Error_Stream, "tg: Semantic Error at line " 
                              & Integer'Image (Test_Script_Scanner.Current_Line));
      raise;
  end Translate;                       


end Translator;
