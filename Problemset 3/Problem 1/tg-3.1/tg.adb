-------------------------------------------------------------------------------

  -- Copyright (C) 1996 by Andre Spiegel.

  -- File:           tg.adb

  -- Description:    tg's main procedure, which analyzes the argument
  --                 list and calls procedure `tg_main' with appropriate
  --                 parameters.

  -- Author:         Andre Spiegel
  -- Creation Date:  Tue Jul 13 17:29:49 1993

  -- RCS: $Id: tg.adb,v 1.3 1996/05/09 12:40:46 spiegel Exp $

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

with Ada.Text_IO, Ada.Command_Line, Ada.Strings.Unbounded;
use  Ada.Text_IO;

with Version;
with Translator; use Translator;

procedure tg is  --------------------------------------------------------------

  package ASU renames Ada.Strings.Unbounded;

  -- Variables to store the command line arguments

  Script_Name, 
  Driver_Name    : ASU.Unbounded_String;

  Fail_Output,
  Pass_Output    : Translator.Output_Mode;
  
  Incorrect_Call, Terminate_Program : exception;

  ---------------
  -- Put_Usage --
  ---------------

  procedure Put_Usage is
  begin
    Put_Line ("tg:      A Test Driver Generator for Ada programs (Version " & Version.Id & ").");
    Put_Line ("Usage:   tg [options...] script_file [driver_file]");
    Put_Line ("Options:");
    Put_Line ("-f <setting>   Specifies how failed test cases will be reported");
    Put_Line ("               by the testdriver. <setting> may be one of");
    New_Line;
    Put_Line ("               off      No output.");
    Put_Line ("               numbers  Only test case numbers, followed by the string");
    Put_Line ("                        ``FAIL.''.");
    Put_Line ("               titles   Numbers and titles, followed by ``...FAIL.''");
    Put_Line ("                        on the next line.");
    Put_Line ("               full     Numbers and titles, ``...FAIL'' and a short");
    Put_Line ("                        explanation on the next line.");
    Put_Line ("                        This is the default.");
    New_Line;
    Put_Line ("-p  <setting>  Same as ``-p'', but for passed test cases.");
    Put_Line ("               Default is ``numbers''.");
    New_Line;
  end Put_Usage;

  -------------------
  -- Get_Arguments --
  -------------------

  procedure Get_Arguments is

    use Ada.Command_Line;
    I : Positive;

  begin
    Fail_Output := Full;
    Pass_Output := Numbers;
    if Argument_Count < 1 then
      raise Incorrect_Call;
    else
      I := 1;
      -- options
      while I < Argument_Count loop
        if Argument (I) = "-f" then
          Fail_Output := Translator.Output_Mode'Value (Argument (I+1));
          I := I + 2;
        elsif Argument (I) = "-p" then
          Pass_Output := Translator.Output_Mode'Value (Argument (I+1));
          I := I + 2;
        else
          exit;
        end if;
      end loop;
      -- filenames
      if Argument_Count > I+1 then 
        raise Incorrect_Call;
      else
        Script_Name := ASU.To_Unbounded_String (Argument (I));
        if Argument_Count = I+1 then
          Driver_Name := ASU.To_Unbounded_String (Argument (I+1));
        end if;
      end if;
    end if;
  end Get_Arguments;

  -------------
  -- tg_main --
  -------------
  
  procedure tg_main (Script_Name : in String;  
                     Driver_Name : in String := "";
                     Fail_Output : in Translator.Output_Mode   := Full;
                     Pass_Output : in Translator.Output_Mode   := Off) is

    use type ASU.Unbounded_String;

    Script_File, 
    Driver_File : File_Type;

    Output_Name : ASU.Unbounded_String;

    function Without_Extension (File_Name : String) return String is
      Index : Natural;
    begin
      Index := File_Name'Last;
      while Index > File_Name'First loop
        if File_Name (Index) = '.' then
          return File_Name (File_Name'First .. Index-1);
        else
          Index := Index - 1;
        end if;
      end loop;
      return File_Name;
    end Without_Extension;

    function Without_Extension (File_Name : in String) 
                                return ASU.Unbounded_String is
    begin
       return ASU.To_Unbounded_String (Without_Extension (File_Name));
    end Without_Extension;

  begin

    -- attempt to open the input file, error if it doesn't exist
    begin
      Open (Script_File, In_File, Script_Name);
    exception
      when Name_Error => 
        Put_Line ("tg: File " & Script_Name & " not found.");
        raise Terminate_Program;
      when Use_Error  => 
        Put_Line ("tg: Error when attempting to open " & Script_Name);
        raise Terminate_Program;
    end;

    -- create the output file, overwrite if it does exist
    begin
      if Driver_Name = "" then
        Output_Name := Without_Extension (Script_Name) & ".adb";
      else
        Output_Name := ASU.To_Unbounded_String (Driver_Name);
      end if;
      Create (Driver_File, Out_File, ASU.To_String (Output_Name));
    exception
      when Name_Error | Use_Error =>
        Put_Line ("tg: Error opening file " & ASU.To_String (Output_Name));
        raise Terminate_Program;
    end;

    Translator.Translate (Script_File, Driver_File, Standard_Error,
                          Without_Extension (ASU.To_String (Output_Name)),
                          Fail_Output, Pass_Output);

    Close (Driver_File);
    Close (Script_File);

  end tg_main;


begin  -- tg

  Get_Arguments;  
  
  tg_main (ASU.To_String (Script_Name), ASU.To_String (Driver_Name), 
           Fail_Output, Pass_Output);

exception
  when Incorrect_Call =>
    Put_Usage;
  when Translator.File_Error | 
       Translator.Syntax_Error | 
       Translator.Semantic_Error |
       Terminate_Program => 
    null;
end tg;
