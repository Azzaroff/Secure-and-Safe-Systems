-- * This file has been automatically generated using `testgen'.
-- * Modifications should be made in the corresponding script file.

  -- Test Driver Source

  -- File:       d:\personal\organisation\dropbox\my dropbox\safe and secure software\bonus\umsetzung\project03\src\test_vectors.adb
  -- Script:     d:\personal\organisation\dropbox\my dropbox\safe and secure software\bonus\umsetzung\project03\src\test_vectors.ts


with Ada.Command_Line, Ada.Exceptions;
use type Ada.Command_Line.Exit_Status;

with Vectors; use Vectors;
	with Test_StdIO; use Test_StdIO;
	with Ada.Text_IO; use Ada.Text_IO;

procedure test_vectors is

  package Driver_Internals is
    -- Global Data
    Program_Terminate     : exception;
    Fail_Result           : Boolean := False;
    Unexpected_Error      : Boolean := False;
    Status                : Ada.Command_Line.Exit_Status := 0;
    -- Data of last Test Case
    Test_Case_Passed      : Boolean := False;
    -- Access Routines
    procedure Set_Path (Path : in String);
    function Path_Was (Path : in String) return Boolean;
    function Taken_Path return String;
    function Passed return Boolean;
    function Failed return Boolean;
  end Driver_Internals;

  package body Driver_Internals is
    -- Data of last Test Case
    Test_Case_Path        : String (1.. 256);
    Test_Case_Path_Length : Natural := 0;
    -- Access Routines
    procedure Set_Path (Path : in String) is
      begin
        Test_Case_Path (Test_Case_Path'First..Path'Length) := Path;
        Test_Case_Path_Length := Path'Length;
      end Set_Path;
    function Path_Was (Path : in String) return Boolean is
      begin
        return Test_Case_Path_Length = Path'Length
            and then Test_Case_Path (1..Path'Length) = Path;
      end Path_Was;
    function Taken_Path return String is
      begin return Test_Case_Path (1..Test_Case_Path_Length); end Taken_Path;
    function Passed return Boolean is
      begin return Test_Case_Passed; end Passed;
    function Failed return Boolean is
      begin return not Test_Case_Passed; end Failed;
  end Driver_Internals;

begin  -- unit main block

  -- Test Case (1)   Put Test empty Vector
  declare
    Vec1:Float_Vector(1..0);
    	Text_File : File_Type;	
    	File_Text : String(1..50);
    	Compare_Text : constant String := "()";
    	Result : Boolean := True;
    	Line_Length : Natural;
  begin  -- test case
    begin  -- prepare part
      Redirect_To_File;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', prepare part of test case 1.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in prepare part of test case 1.");
        raise Driver_Internals.Program_Terminate;
    end;  -- prepare part

    begin  -- test part
      Vector_Put(Vec1);
      	Redirect_To_StdOut;
      	Open(Text_File, In_File, "std_out.txt");
      	Get_Line(Text_File, File_Text, Line_Length);
      	for I in 1..Line_Length loop
      		if File_Text(I) /= Compare_Text(I) then
      			Result := False;
      		end if;
      	end loop;
      	Close(Text_File);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if Result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(1)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(1)  Put Test empty Vector");
          Put_Line ("           Script name:'test_vectors.ts'; Line:6 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(1)  Put Test empty Vector");
        Put_Line ("           Script name:'test_vectors.ts'; Line:6 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 1.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 1.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (2)   Put Test 2 dimensional Vector
  declare
    Vec1:Float_Vector(1..2);
    	Text_File : File_Type;	
    	File_Text : String(1..50);
    	Compare_Text : constant String := "( 1.0,  1.0)";
    	Result : Boolean := True;
    	Line_Length : Natural;
  begin  -- test case
    begin  -- prepare part
      Vec1 := ( 1.0, 1.0);
      	Redirect_To_File;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', prepare part of test case 2.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in prepare part of test case 2.");
        raise Driver_Internals.Program_Terminate;
    end;  -- prepare part

    begin  -- test part
      Vector_Put(Vec1);
      	Redirect_To_StdOut;
      	Open(Text_File, In_File, "std_out.txt");
      	Get_Line(Text_File, File_Text, Line_Length);
      	for I in 1..Line_Length loop
      		if File_Text(I) /= Compare_Text(I) then
      			Result := False;
      		end if;
      	end loop;
      	Close(Text_File);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if Result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(2)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(2)  Put Test 2 dimensional Vector");
          Put_Line ("           Script name:'test_vectors.ts'; Line:26 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(2)  Put Test 2 dimensional Vector");
        Put_Line ("           Script name:'test_vectors.ts'; Line:26 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 2.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 2.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (3)   Put Test 3 dimensional Vector
  declare
    Vec1:Float_Vector(1..3);
    	Text_File : File_Type;	
    	File_Text : String(1..50);
    	Compare_Text : constant String := "( 1.0,  1.0,  1.0)";
    	Result : Boolean := True;
    	Line_Length : Natural;
  begin  -- test case
    begin  -- prepare part
      Vec1 := ( 1.0, 1.0, 1.0);
      	Redirect_To_File;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', prepare part of test case 3.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in prepare part of test case 3.");
        raise Driver_Internals.Program_Terminate;
    end;  -- prepare part

    begin  -- test part
      Vector_Put(Vec1);
      	Redirect_To_StdOut;
      	Open(Text_File, In_File, "std_out.txt");
      	Get_Line(Text_File, File_Text, Line_Length);
      	for I in 1..Line_Length loop
      		if File_Text(I) /= Compare_Text(I) then
      			Result := False;
      		end if;
      	end loop;
      	Close(Text_File);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if Result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(3)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(3)  Put Test 3 dimensional Vector");
          Put_Line ("           Script name:'test_vectors.ts'; Line:47 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(3)  Put Test 3 dimensional Vector");
        Put_Line ("           Script name:'test_vectors.ts'; Line:47 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 3.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 3.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (4)   Cross_Product normal
  declare
    Vec1, Vec2, Result:Float_Vector(1..3);	
  begin  -- test case
    begin  -- prepare part
      Vec1 := ( 1.0, 1.0, 1.0);
      	Vec2 := ( 1.0, 2.0, 3.0);
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', prepare part of test case 4.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in prepare part of test case 4.");
        raise Driver_Internals.Program_Terminate;
    end;  -- prepare part

    begin  -- test part
      Result := Vec1 * Vec2;
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if Result = (1.0, -2.0, 1.0)
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(4)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(4)  Cross_Product normal");
          Put_Line ("           Script name:'test_vectors.ts'; Line:70 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(4)  Cross_Product normal");
        Put_Line ("           Script name:'test_vectors.ts'; Line:70 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 4.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 4.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (5)   Cross_Product unequal Dimensions, first smaller
  declare
    Vec1, Result:Float_Vector(1..2);
    	Vec2:Float_Vector(1..3);		
  begin  -- test case
    begin  -- prepare part
      Vec1 := ( 1.0, 1.0);
      	Vec2 := ( 1.0, 2.0, 3.0);
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', prepare part of test case 5.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in prepare part of test case 5.");
        raise Driver_Internals.Program_Terminate;
    end;  -- prepare part

    begin  -- test part
      Result := Vec1 * Vec2;
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("Constraint_Error") then
        Driver_Internals.Test_Case_Passed := True;
        Put_Line ("(5)  pass.");
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(5)  Cross_Product unequal Dimensions, first smaller");
        Put_Line ("           Script name:'test_vectors.ts'; Line:77 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `Constraint_Error' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 5.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 5.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (6)   Cross_Product unequal Dimensions, second smaller
  declare
    Vec1, Result:Float_Vector(1..3);
    	Vec2:Float_Vector(1..2);		
  begin  -- test case
    begin  -- prepare part
      Vec1 := ( 1.0, 1.0, 1.0);
      	Vec2 := ( 1.0, 2.0);
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', prepare part of test case 6.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in prepare part of test case 6.");
        raise Driver_Internals.Program_Terminate;
    end;  -- prepare part

    begin  -- test part
      Result := Vec1 * Vec2;
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("Constraint_Error") then
        Driver_Internals.Test_Case_Passed := True;
        Put_Line ("(6)  pass.");
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(6)  Cross_Product unequal Dimensions, second smaller");
        Put_Line ("           Script name:'test_vectors.ts'; Line:85 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `Constraint_Error' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 6.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 6.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (7)   Cross_Product Dimension unequal 3
  declare
    Vec1, Vec2, Result:Float_Vector(1..2);	
  begin  -- test case
    begin  -- prepare part
      Vec1 := ( 1.0, 1.0);
      	Vec2 := ( 1.0, 2.0);
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', prepare part of test case 7.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in prepare part of test case 7.");
        raise Driver_Internals.Program_Terminate;
    end;  -- prepare part

    begin  -- test part
      Result := Vec1 * Vec2;
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("Constraint_Error") then
        Driver_Internals.Test_Case_Passed := True;
        Put_Line ("(7)  pass.");
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(7)  Cross_Product Dimension unequal 3");
        Put_Line ("           Script name:'test_vectors.ts'; Line:93 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `Constraint_Error' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 7.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 7.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (8)   Cross_Product empty Vector
  declare
    Vec1, Vec2, Result:Float_Vector(1..0);	
  begin  -- test case
    begin  -- test part
      Result := Vec1 * Vec2;
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("Constraint_Error") then
        Driver_Internals.Test_Case_Passed := True;
        Put_Line ("(8)  pass.");
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(8)  Cross_Product empty Vector");
        Put_Line ("           Script name:'test_vectors.ts'; Line:100 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `Constraint_Error' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 8.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 8.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (9)   Scalar_Product normal
  declare
    Vec1, Vec2:Float_Vector(1..3);	
       	Result: Float;	
  begin  -- test case
    begin  -- prepare part
      Vec1 := ( 1.0, 1.0, 1.0);
      	Vec2 := ( 1.0, 2.0, 3.0);
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', prepare part of test case 9.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in prepare part of test case 9.");
        raise Driver_Internals.Program_Terminate;
    end;  -- prepare part

    begin  -- test part
      Result := Vec1 * Vec2;
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if Result = 6.0
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(9)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(9)  Scalar_Product normal");
          Put_Line ("           Script name:'test_vectors.ts'; Line:108 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(9)  Scalar_Product normal");
        Put_Line ("           Script name:'test_vectors.ts'; Line:108 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 9.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 9.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (10)   Scalar_Product unequal Dimensions, first smaller
  declare
    Vec1:Float_Vector(1..2);
    	Vec2:Float_Vector(1..3);		
       	Result: Float;	
  begin  -- test case
    begin  -- prepare part
      Vec1 := ( 1.0, 1.0);
      	Vec2 := ( 1.0, 2.0, 3.0);
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', prepare part of test case 10.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in prepare part of test case 10.");
        raise Driver_Internals.Program_Terminate;
    end;  -- prepare part

    begin  -- test part
      Result := Vec1 * Vec2;
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("Constraint_Error") then
        Driver_Internals.Test_Case_Passed := True;
        Put_Line ("(10)  pass.");
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(10)  Scalar_Product unequal Dimensions, first smaller");
        Put_Line ("           Script name:'test_vectors.ts'; Line:116 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `Constraint_Error' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 10.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 10.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (11)   Scalar_Product unequal Dimensions, second smaller
  declare
    Vec1:Float_Vector(1..3);
    	Vec2:Float_Vector(1..2);		
       	Result: Float;	
  begin  -- test case
    begin  -- prepare part
      Vec1 := ( 1.0, 1.0, 1.0);
      	Vec2 := ( 1.0, 2.0);
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', prepare part of test case 11.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in prepare part of test case 11.");
        raise Driver_Internals.Program_Terminate;
    end;  -- prepare part

    begin  -- test part
      Result := Vec1 * Vec2;
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("Constraint_Error") then
        Driver_Internals.Test_Case_Passed := True;
        Put_Line ("(11)  pass.");
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(11)  Scalar_Product unequal Dimensions, second smaller");
        Put_Line ("           Script name:'test_vectors.ts'; Line:125 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `Constraint_Error' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 11.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 11.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (12)   Scalar_Product empty Vector
  declare
    Vec1, Vec2:Float_Vector(1..0);		
       	Result: Float;	
  begin  -- test case
    begin  -- test part
      Result := Vec1 * Vec2;
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if Result = 0.0
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(12)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(12)  Scalar_Product empty Vector");
          Put_Line ("           Script name:'test_vectors.ts'; Line:134 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(12)  Scalar_Product empty Vector");
        Put_Line ("           Script name:'test_vectors.ts'; Line:134 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 12.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 12.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (13)   Stretching normal
  declare
    Vec1, Result:Float_Vector(1..3);	
  begin  -- test case
    begin  -- prepare part
      Vec1 := ( 1.0, 2.0, 3.0);
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', prepare part of test case 13.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in prepare part of test case 13.");
        raise Driver_Internals.Program_Terminate;
    end;  -- prepare part

    begin  -- test part
      Result := Vec1 * 2.0;
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if Result = ( 2.0, 4.0, 6.0)
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(13)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(13)  Stretching normal");
          Put_Line ("           Script name:'test_vectors.ts'; Line:143 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(13)  Stretching normal");
        Put_Line ("           Script name:'test_vectors.ts'; Line:143 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 13.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 13.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (14)   Stretching Float'First
  declare
    Vec1, Result:Float_Vector(1..3);
  begin  -- test case
    begin  -- prepare part
      Vec1 := ( 1.0, 2.0, 3.0);	
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', prepare part of test case 14.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in prepare part of test case 14.");
        raise Driver_Internals.Program_Terminate;
    end;  -- prepare part

    begin  -- test part
      Result := Vec1 * Float'First;
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if (Result(1) = Float'First) and (Result(2) < Float'First) and (Result(3) < Float'First)
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(14)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(14)  Stretching Float'First");
          Put_Line ("           Script name:'test_vectors.ts'; Line:149 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(14)  Stretching Float'First");
        Put_Line ("           Script name:'test_vectors.ts'; Line:149 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 14.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 14.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (15)   Stretching Float'Last
  declare
    Vec1, Result:Float_Vector(1..3);		
  begin  -- test case
    begin  -- prepare part
      Vec1 := ( 1.0, 2.0, 3.0);
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', prepare part of test case 15.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in prepare part of test case 15.");
        raise Driver_Internals.Program_Terminate;
    end;  -- prepare part

    begin  -- test part
      Result := Vec1 * Float'Last;
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if (Result(1) = Float'Last) and (Result(2) > Float'Last) and (Result(3) > Float'Last)
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(15)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(15)  Stretching Float'Last");
          Put_Line ("           Script name:'test_vectors.ts'; Line:155 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(15)  Stretching Float'Last");
        Put_Line ("           Script name:'test_vectors.ts'; Line:155 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 15.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 15.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (16)   Stretching Zero
  declare
    Vec1, Result:Float_Vector(1..3);	
  begin  -- test case
    begin  -- prepare part
      Vec1 := ( 1.0, 2.0, 3.0);
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', prepare part of test case 16.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in prepare part of test case 16.");
        raise Driver_Internals.Program_Terminate;
    end;  -- prepare part

    begin  -- test part
      Result := Vec1 * 0.0;
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if Result = (0.0, 0.0, 0.0)
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(16)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(16)  Stretching Zero");
          Put_Line ("           Script name:'test_vectors.ts'; Line:161 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(16)  Stretching Zero");
        Put_Line ("           Script name:'test_vectors.ts'; Line:161 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 16.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 16.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  --  End of test cases
  New_Line;
  Put ("Script name 'test_vectors.ts'");
  Put ("; total test result: ");
  if Driver_Internals.Fail_Result then
    Put ("FAIL");
    Driver_Internals.Status := 1;
  else
    Put ("pass");
    Driver_Internals.Status := 0;
  end if;
  Put_Line (".");
  New_Line;
  Ada.Command_Line.Set_Exit_Status (Driver_Internals.Status);

exception
  when Driver_Internals.Program_Terminate =>
    New_Line;
    Put ("Total test result: ");
    if Driver_Internals.Fail_Result then
      Put ("FAIL");
      Driver_Internals.Status := 1;
    else
      Put ("UNDEFINED");
      Driver_Internals.Status := -1;
    end if;
    if Driver_Internals.Unexpected_Error then
      Put_Line (",");
      Put_Line ("        there were one or more errors outside of test cases.");
      Driver_Internals.Status := -1;
    else
      Put_Line (".");
    end if;
    New_Line;
    Ada.Command_Line.Set_Exit_Status (Driver_Internals.Status);
  when E: others =>
    New_Line;
    Put_Line ("Unexpected exception " & Ada.Exceptions.Exception_Name (E) & " propagating out of driver.");
    Put_Line ("Results are undefined.");
    Driver_Internals.Status := -1;
    Ada.Command_Line.Set_Exit_Status (Driver_Internals.Status);

end test_vectors;
