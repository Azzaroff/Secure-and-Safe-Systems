-- File:           testgen.adb
-- A modification and minor extentsion of tg.adb by Andre Spiegel.
-- Copyright (C) 2004 by Stefan Lucks, 1996 by Andre Spiegel.

-- This file is part of `testgen' (a modification and extension of 'tg').
-- Creation of tg: Andre Spieger; Jul 13,   1993
-- ... of testgen: Stefan Lucks;  March 01, 2004.

-- Description:    This file contains testgen's main procedure, which
--                 analyzes the command line string (argument list)
--                 and calls the translator with appropriate parameters.

-- 'testgen' is free software; you can redistribute it and/or modify it under
-- the GNU General Public License as published by the Free Software Foundation
-- (FSF); either version 2, or (at your option) any later version.

-- `testgen' is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE.

-- You should have received a copy of the GNU General Public License
-- along with `testgen'; see the file COPYING.  If not, write to
-- the FSF, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.


with Ada.Text_IO, Ada.Command_Line, Ada.Strings.Unbounded;
use  Ada.Text_IO;

with Testgen_Version;
with Testgen_Translator;

procedure Testgen is

  package Translator renames Testgen_Translator;
  package ASU renames Ada.Strings.Unbounded;

  -- Variables to store the command line arguments

  Script_Name, Driver_Name    : ASU.Unbounded_String;
  Fail_Output, Pass_Output    : Translator.Output_Mode;
  Long_Trailer                : Boolean := True;

  Incorrect_Call, Terminate_Program, Unknown_Output_Mode : exception;

  ---------------
  -- Put_Usage --
  ---------------

  procedure Put_Usage is
  begin
     New_Line;
     Put_Line ("testgen: A Test Driver Generator for Ada programs (Version " &
               Testgen_Version.Id & ").");
     New_Line;
     Put_Line ("Usage:   testgen [-m] [-f <setting>] [-p <setting>]" &
               "script_file [driver_file]");
     Put_Line ("-f <setting>   Specifies how failed test cases will be " &
               "reported");
     Put_Line ("               by the testdriver. Default is ``full''.");
     Put_Line ("-p <setting>   Same as ``-f'', but for passed test cases.");
     Put_Line ("               Default is ``numbers''.");
     Put_Line ("-m    Minimal mode: changes default for -f to ``locations'' " &
               "default for -p to ``off''");
     Put_Line ("Possible settings are:");
     Translator.Put_Descriptions_Of_Output_Modes;
  end Put_Usage;

  -------------------
  -- Get_Arguments --
  -------------------

  procedure Get_Arguments is

     use Ada.Command_Line;
     I : Positive;

     procedure Get_Output_Mode(Mode: in out Translator.Output_Mode;
                               Text: in String) is
     begin
        Mode := Translator.Output_Mode'Value(Text);
     exception
        when CONSTRAINT_ERROR =>
           Put_Line("Unknown Output Mode: "& Text);
           raise Unknown_Output_Mode;
     end Get_Output_Mode;

  begin -- Get_Arguments
     Fail_Output := Translator.Full;
     Pass_Output := Translator.Numbers;
     if Argument_Count < 1 then
        raise Incorrect_Call;
     else
        I := 1;
        -- options
        while I < Argument_Count loop
           if Argument (I) = "-f" then
              Get_Output_Mode (Fail_Output, Argument(I+1));
              I := I + 2;
           elsif Argument (I) = "-p" then
              Get_Output_Mode (Pass_Output, Argument(I+1));
              I := I + 2;
           elsif Argument (I) = "-m" then
              Fail_Output := Translator.Locations;
              Pass_Output := Translator.Off;
              Long_Trailer := False;
              I := I + 1;
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

  procedure tg_main
    (Script_Name : in String;
     Driver_Name : in String := "";
     Fail_Output : in Translator.Output_Mode := Translator.Full;
     Pass_Output : in Translator.Output_Mode := Translator.Off) is

     use type ASU.Unbounded_String;

     Script_File, Driver_File : File_Type;
     Output_Name              : ASU.Unbounded_String;

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

     procedure Protect_From_Overwrite (File_Name : in String) is

        The_File: File_Type;

        function Get_One_Line(F: File_Type) return String is
           S: String(1..1024); L: Natural;
        begin
           Get_Line(F, S, L);
           return S(1..L);
        end Get_One_Line;

     begin
        Open (The_File, In_File, File_Name);
        -- this should raise name error ... if the file does not exist
        if (not End_Of_File(The_File))
          and then Get_One_Line(The_File) =  Translator.Magic_String_1
          and then (not End_Of_File(The_File))
          and then Get_One_Line(The_File) =  Translator.Magic_String_2
        then
           Close(The_File); -- and then open for (over-)writing
        else
           Put_Line ("testgen:  file " & File_Name & " exists and has not " &
                     "been generated by testgen. ");
           Put_Line ("          No automatic overwriting of foreign files!");
           raise Terminate_Program;
        end if;
     exception
        when Name_Error =>
           null; -- the file does not exist ... great!
        when Use_Error  =>
           Put_Line ("testgen: Error when attempting to open " & File_Name);
           raise Terminate_Program;
     end Protect_From_Overwrite;

  begin -- tg_main

     begin -- attempt to open the input file, error if it doesn't exist
        Open (Script_File, In_File, Script_Name);
     exception
        when Name_Error =>
           Put_Line ("testgen: File " & Script_Name & " not found.");
           raise Terminate_Program;
        when Use_Error  =>
           Put_Line ("testgen: Error when attempting to open " & Script_Name);
           raise Terminate_Program;
     end;

     begin -- create the output file
        if Driver_Name = "" then
           Output_Name := Without_Extension(Script_Name) & ".adb";
        else
           Output_Name := ASU.To_Unbounded_String (Driver_Name);
        end if;
        Protect_From_Overwrite (ASU.To_String(Output_Name));
        Create (Driver_File, Out_File, ASU.To_String (Output_Name));
     exception
        when Name_Error | Use_Error =>
           Put_Line ("testgen: Error opening file " &
                     ASU.To_String (Output_Name));
           raise Terminate_Program;
     end;

     Translator.Translate (Script_File, Driver_File, Standard_Error,
                           Without_Extension (ASU.To_String (Output_Name)),
                           Fail_Output, Pass_Output,
                           Script_Name, Long_Trailer);
     Close (Driver_File);
     Close (Script_File);

  end tg_main;


begin  -- testgen
   Get_Arguments;
   tg_main (ASU.To_String (Script_Name), ASU.To_String (Driver_Name),
            Fail_Output, Pass_Output);
exception
   when Incorrect_Call =>
      Put_Usage;
   when Unknown_Output_Mode =>
      Put("  Possible Modes are: ");
      for Mode in Translator.Output_Mode loop
         Put(Translator.Output_Mode'Image(Mode) & " ");
      end loop;
      New_Line;
   when Translator.File_Error | Translator.Syntax_Error |
        Translator.Semantic_Error | Terminate_Program =>
      null;
end testgen;