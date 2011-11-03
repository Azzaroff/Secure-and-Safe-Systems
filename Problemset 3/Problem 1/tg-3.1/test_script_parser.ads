-------------------------------------------------------------------------------

  -- Copyright (C) 1996 by Andre Spiegel.

  -- File:           test_script_parser.ads

  -- Description:

  -- Author:         Andre Spiegel
  -- Creation Date:  Wed Jul 14 10:59:09 1993

  -- RCS: $Id: test_script_parser.ads,v 1.1 1996/05/09 12:13:12 spiegel Exp $

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

with Ada.Strings.Unbounded;

with Lists;

with Test_Script_Scanner; use Test_Script_Scanner;

package Test_Script_Parser is

  package ASU renames Ada.Strings.Unbounded;

  Parse_Error : exception;  ---------------------------------------------------

  package Exception_Lists is  -------------------------------------------------
    new Lists (ITEMTYPE => ASU.Unbounded_String,
               Equal    => ASU."=");  
  package Code_Lists is 
    new Lists (ITEMTYPE => ASU.Unbounded_String,
               Equal    => ASU."=");
  

  type Handling_Mode is (Stop, Continue);  ------------------------------------
                          
  type General_Part_Type is record  
                              Fail_Handling  : Handling_Mode := Continue; 
                              Error_Handling : Handling_Mode := Stop;
                              Context        : Code_Lists.List;
                              Exceptions     : Exception_Lists.List;
                              Define_Part    : Code_Lists.List;
                            end record;


  subtype Path_Type is ASU.Unbounded_String;  ---------------------------------

  type Pass_Clause_Type is record
                             Path      : Path_Type;
                             Predicate : Code_Lists.List;
                           end record; 

  package Pass_Clause_Lists is new Lists (Pass_Clause_Type);


  type Test_Case_Type is record  ----------------------------------------------
                           Number         : Natural := 0;
                           Title          : ASU.Unbounded_String;
                           Define_Part,
                           Prepare_Part,
                           Test_Part      : Code_Lists.List;
                           Pass_Part      : Pass_Clause_Lists.List;
                           Cleanup_Part   : Code_Lists.List;
                         end record;                         
       

  procedure Get_General_Part (Data : in out General_Part_Type);  --------------
  
    -- Preconditions.
    --   1.    Test_Script_Scanner.Current_Token = 
    --                Key_Fail_Handling/Key_Error_Handling/
    --                Key_Context/Key_Exceptions
    --   2. The syntax of the general part is correct.
    
    -- Postconditions.
    --   1. Data contains the general data specified in the file.
    --   2. Current_Token is the first token after the general part.
    
    -- Error Handling.
    --   1. All fields of Data are set to empty values.
    --   2. Parse_Error is raised.


  procedure Get_Code_Part (Data : in out Code_Lists.List);  -------------------

    --   1. Test_Script_Scanner.Current_Token = Key_Code
    
    -- Postconditions.
    --   1. Data contains the code lines given in the file.
    --   2. Current_Token is the first token after the code part.
    
    -- Error Handling.
    --   1. Data is an empty list.
    
    
  procedure Get_Test_Case (Data : in out Test_Case_Type);  --------------------
  
    -- Preconditions.
    --   1. Test_Script_Scanner.Current_Token = Key_Begin_Test_Case
    --   2. The syntax of the test case is correct.
    
    -- Postconditions.
    --   1. Data contains a representation of the test case 
    --      specified in the file.
    --   2. Current_Token is the first token after the test case.
    
    -- Error Handling.
    --   1. All fields of Data are set to empty values.
    --   2. Parse_Error is raised.
    

end Test_Script_Parser;


