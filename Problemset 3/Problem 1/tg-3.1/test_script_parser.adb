-------------------------------------------------------------------------------

  -- Copyright (C) 1996 by Andre Spiegel.

  -- File:           test_script_parser.adb

  -- Description:    <to be supplied>

  -- Author:         Andre Spiegel
  -- Creation Date:  Wed Jul 14 11:12:09 1993

  -- RCS: $Id: test_script_parser.adb,v 1.1 1996/05/09 12:13:21 spiegel Exp $

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

with Test_Script_Scanner; use Test_Script_Scanner;

package body Test_Script_Parser is

  -- Internal Routines
  --------------------

  procedure Get_Code_Lines (Data : in out Code_Lists.List) is  ----------------
    Line : ASU.Unbounded_String;
  begin
    if Current_Token /= Indented_Text_Line then
      raise Parse_Error;
    end if;
    loop
      Line := ASU.To_Unbounded_String (Token_Text);
      Code_Lists.Attach (Data, Line);
      Next_Token;
      exit when Current_Token /= Indented_Text_Line;
    end loop;
  end Get_Code_Lines;
    
    
  procedure Get_Exception_Names (Data : in out Exception_Lists.List) is  ------
    Name : ASU.Unbounded_String;
  begin
    loop
      if Current_Token /= Ada_Exception then
        raise Parse_Error;
      end if;
      Name := ASU.To_Unbounded_String (Token_Text);
      Exception_Lists.Attach (Data, Name);
      Next_Token;
      if Current_Token = Colon then
        Next_Token;
      elsif Current_Token = Semicolon then
        Next_Token; exit;
      else 
        raise Parse_Error;
      end if;
    end loop;
  end Get_Exception_Names;


  procedure Get_Test_Case_Title (Test_Case : in out Test_Case_Type) is
  begin
     Next_Token;
     if Current_Token = Test_Case_Number then
        begin
          Test_Case.Number := Positive'Value 
            (Token_Text (Token_Text'First + 1 .. Token_Text'Last - 1));
        exception
          when Constraint_Error => 
            Test_Case.Number := 0;
            Next_Token;
            Test_Case.Title  := ASU.To_Unbounded_String (Token_Text);
            return;
        end;
        Next_Token;
        if Current_Token = Test_Case_Title then
           Test_Case.Title  := ASU.To_Unbounded_String (Token_Text);
        else
           raise Parse_Error;
        end if;
     elsif Current_Token = Test_Case_Title then
        Test_Case.Number := 0;
        Test_Case.Title  := ASU.To_Unbounded_String (Token_Text);
     else
        raise Parse_Error;
     end if;
  end Get_Test_Case_Title;                               


  procedure Get_Pass_Clause (Data : in out Pass_Clause_Type) is  --------------
  begin
    Data.Predicate := Code_Lists.Create;
    case Current_Token is
      when Indented_Text_Line => 
         Data.Path := ASU.To_Unbounded_String ("=>");
         Get_Code_Lines (Data.Predicate);

      when Key_Normal_Path => 
         Data.Path := ASU.To_Unbounded_String ("=>");
         Next_Token;
         if Current_Token = Colon then
            Next_Token; 
            Get_Code_Lines (Data.Predicate);
         end if;

      when Key_Exception =>      
         Next_Token;
         if Current_Token = Ada_Exception then
            Data.Path := ASU.To_Unbounded_String (Token_Text);
            Next_Token;
            if Current_Token = Colon then
               Next_Token; 
               Get_Code_Lines (Data.Predicate);
            end if;
         else
            raise Parse_Error;
         end if;

      when others =>             
         raise Parse_Error;
    end case;
  end Get_Pass_Clause;
      
      
  -- Exported Routines
  --------------------

  procedure Get_General_Part (Data : in out General_Part_Type) is  ------------
  begin
    if Current_Token = Key_Fail_Handling then
      Next_Token;
      case Current_Token is
        when Key_Stop     => Data.Fail_Handling := Stop;
        when Key_Continue => Data.Fail_Handling := Continue;
        when others       => raise Parse_Error;
      end case;
      Next_Token;
    end if;

    if Current_Token = Key_Error_Handling then
      Next_Token;
      case Current_Token is
        when Key_Stop     => Data.Error_Handling := Stop;
        when Key_Continue => Data.Error_Handling := Continue;
        when others       => raise Parse_Error;
      end case;
      Next_Token;
    end if;

    Data.Context := Code_Lists.Create;
    if Current_Token = Key_Context then
      Next_Token;
      Get_Code_Lines (Data.Context);
    end if;

    Data.Exceptions := Exception_Lists.Create;
    if Current_Token = Key_Exceptions then
      Next_Token;
      Get_Exception_Names (Data.Exceptions);
    end if;

    Data.Define_Part := Code_Lists.Create;
    if Current_Token = Key_Define then
      Next_Token;
      Get_Code_Lines (Data.Define_Part);
    end if;
  end Get_General_Part;
  

  procedure Get_Code_Part (Data : in out Code_Lists.List) is  -----------------
  begin
    Data := Code_Lists.Create;
    if Current_Token = Key_Code then
      Next_Token;
      Get_Code_Lines (Data);
    end if;
  end Get_Code_Part;    

    
  procedure Get_Test_Case (Data : in out Test_Case_Type) is  ------------------
    Pass_Clause : Pass_Clause_Type;
  begin
    if Current_Token = Key_Begin_Test_Case then
      Get_Test_Case_Title (Data);
      Next_Token;

      Data.Define_Part := Code_Lists.Create;
      if Current_Token = Key_Define then
        Next_Token; Get_Code_Lines (Data.Define_Part);
      end if;
            
      Data.Prepare_Part := Code_Lists.Create;
      if Current_Token = Key_Prepare then
        Next_Token; Get_Code_Lines (Data.Prepare_Part);
      end if;
      
      Data.Test_Part := Code_Lists.Create;
      if Current_Token = Key_Test then
        Next_Token; Get_Code_Lines (Data.Test_Part);
      else
        raise Parse_Error;
      end if;
      
      Data.Pass_Part := Pass_Clause_Lists.Create;
      if Current_Token /= Key_Pass then
        raise Parse_Error;
      else
        while Current_Token = Key_Pass loop
          Next_Token; Get_Pass_Clause (Pass_Clause);
          Pass_Clause_Lists.Attach (Data.Pass_Part, Pass_Clause);
        end loop;
      end if;

      Data.Cleanup_Part := Code_Lists.Create;
      if Current_Token = Key_Cleanup then
        Next_Token; Get_Code_Lines (Data.Cleanup_Part);
      end if;
        
    end if;                      
  end Get_Test_Case;           

end Test_Script_Parser;


