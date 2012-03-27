-- * This file has been automatically generated using `testgen'.
-- * Modifications should be made in the corresponding script file.

  -- Test Driver Source

  -- File:       /home/azzaroff/workspace/Secure-and-Safe-Systems/Bonusset/Mini Project 3/vectors_test.adb
  -- Script:     /home/azzaroff/workspace/Secure-and-Safe-Systems/Bonusset/Mini Project 3/vectors_test.ts


with Ada.Command_Line, Ada.Exceptions;
use type Ada.Command_Line.Exit_Status;

with Vectors; 		use Vectors;
	with Ada.Text_IO;    	use Ada.Text_IO;
	with Redirect_Stdin;
	with Stdin;
	with Redirect_Stdout;
	with Stdout;
	with Read_Line;

procedure vectors_test is

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

  -- Test Case (1)   VECTORS mulityply_test_0
  declare
    v1 		: Float_Vector := (1.0, 1.0, 1.0);
    	v2 		: Float_Vector := (2.0, 2.0, 2.0);
    	result	: Float_Vector := (0.0, 0.0, 0.0);
    	testres : Float_Vector := (5.0, 5.0, 5.0);
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,v2);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if testres = result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(1)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(1)  VECTORS mulityply_test_0");
          Put_Line ("           Script name:'vectors_test.ts'; Line:11 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(1)  VECTORS mulityply_test_0");
        Put_Line ("           Script name:'vectors_test.ts'; Line:11 ");
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

  -- Test Case (2)   VECTORS mulityply_test_1
  declare
    v1 		: Float_Vector := (0.0, 0.0, 0.0);
    	v2 		: Float_Vector := (2.0, 2.0, 2.0);
    	result	: Float_Vector := (0.0, 0.0, 0.0);
    	testres : Float_Vector := (5.0, 5.0, 5.0);
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,v2);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if testres = result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(2)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(2)  VECTORS mulityply_test_1");
          Put_Line ("           Script name:'vectors_test.ts'; Line:19 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(2)  VECTORS mulityply_test_1");
        Put_Line ("           Script name:'vectors_test.ts'; Line:19 ");
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

  -- Test Case (3)   VECTORS mulityply_test_2
  declare
    v1 		: Float_Vector := (1.0, 1.0, 1.0);
    	v2 		: Float_Vector := (0.0, 0.0, 0.0);
    	result	: Float_Vector := (0.0, 0.0, 0.0);
    	testres : Float_Vector := (5.0, 5.0, 5.0);
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,v2);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if testres = result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(3)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(3)  VECTORS mulityply_test_2");
          Put_Line ("           Script name:'vectors_test.ts'; Line:27 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(3)  VECTORS mulityply_test_2");
        Put_Line ("           Script name:'vectors_test.ts'; Line:27 ");
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

  -- Test Case (4)   VECTORS mulityply_test_3
  declare
    x		: Float := Float'First;
    	y		: Float := 1.0;
    	v1 		: Float_Vector := (x, x, x);
    	v2 		: Float_Vector := (1.0, 1.0, 1.0);
    	result	: Float_Vector := (x*y-x*y, x*y-x*y, x*y-x*y);
    	testres : Float_Vector := (5.0, 5.0, 5.0);
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,v2);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if testres = result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(4)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(4)  VECTORS mulityply_test_3");
          Put_Line ("           Script name:'vectors_test.ts'; Line:35 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(4)  VECTORS mulityply_test_3");
        Put_Line ("           Script name:'vectors_test.ts'; Line:35 ");
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

  -- Test Case (5)   VECTORS mulityply_test_4
  declare
    x		: Float := Float'Last;
    	y		: Float := 1.0;
    	v1 		: Float_Vector := (x, x, x);
    	v2 		: Float_Vector := (1.0, 1.0, 1.0);
    	result	: Float_Vector := (x*y-x*y, x*y-x*y, x*y-x*y);
    	testres : Float_Vector := (5.0, 5.0, 5.0);
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,v2);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if testres = result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(5)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(5)  VECTORS mulityply_test_4");
          Put_Line ("           Script name:'vectors_test.ts'; Line:45 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(5)  VECTORS mulityply_test_4");
        Put_Line ("           Script name:'vectors_test.ts'; Line:45 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
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

  -- Test Case (6)   VECTORS mulityply_cross_test_0
  declare
    x		: Float := Float'First;
    	y		: Float := 2.0;
    	v1 		: Float_Vector := (1.0, 1.0, 1.0);
    	result	: Float_Vector := (2.0, 2.0, 2.0);
    	testres : Float_Vector := (5.0, 5.0, 5.0);
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,y);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if testres = result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(6)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(6)  VECTORS mulityply_cross_test_0");
          Put_Line ("           Script name:'vectors_test.ts'; Line:56 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(6)  VECTORS mulityply_cross_test_0");
        Put_Line ("           Script name:'vectors_test.ts'; Line:56 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
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

  -- Test Case (7)   VECTORS mulityply_cross_test_1
  declare
    y		: Float := 0.0;
    	v1 		: Float_Vector := (1.0, 1.0, 1.0);
    	result	: Float_Vector := (0.0, 0.0, 0.0);
    	testres : Float_Vector := (5.0, 5.0, 5.0);
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,y);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if testres = result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(7)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(7)  VECTORS mulityply_cross_test_1");
          Put_Line ("           Script name:'vectors_test.ts'; Line:65 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(7)  VECTORS mulityply_cross_test_1");
        Put_Line ("           Script name:'vectors_test.ts'; Line:65 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
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

  -- Test Case (8)   VECTORS mulityply_cross_test_2
  declare
    y		: Float := 8.0;
    	v1 		: Float_Vector := (0.0, 0.0, 0.0);
    	result	: Float_Vector := (0.0, 0.0, 0.0);
    	testres : Float_Vector := (5.0, 5.0, 5.0);
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,y);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if testres = result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(8)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(8)  VECTORS mulityply_cross_test_2");
          Put_Line ("           Script name:'vectors_test.ts'; Line:73 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(8)  VECTORS mulityply_cross_test_2");
        Put_Line ("           Script name:'vectors_test.ts'; Line:73 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
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

  -- Test Case (9)   VECTORS mulityply_cross_test_3
  declare
    x		: Float := Float'First;
    	y		: Float := 1.0;
    	v1 		: Float_Vector := (1.0, 1.0, 1.0);
    	result	: Float_Vector := (x, x, x);
    	testres : Float_Vector := (5.0, 5.0, 5.0);
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,x);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if testres = result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(9)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(9)  VECTORS mulityply_cross_test_3");
          Put_Line ("           Script name:'vectors_test.ts'; Line:81 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(9)  VECTORS mulityply_cross_test_3");
        Put_Line ("           Script name:'vectors_test.ts'; Line:81 ");
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

  -- Test Case (10)   VECTORS mulityply_cross_test_4
  declare
    x		: Float := Float'First;
    	y		: Float := 1.0;
    	v1 		: Float_Vector := (x, x, x);
    	result	: Float_Vector := (x, x, x);
    	testres : Float_Vector := (5.0, 5.0, 5.0);
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,y);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if testres = result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(10)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(10)  VECTORS mulityply_cross_test_4");
          Put_Line ("           Script name:'vectors_test.ts'; Line:90 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(10)  VECTORS mulityply_cross_test_4");
        Put_Line ("           Script name:'vectors_test.ts'; Line:90 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
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

  -- Test Case (11)   VECTORS mulityply_cross_test_4
  declare
    x		: Float := Float'Last;
    	y		: Float := 1.0;
    	v1 		: Float_Vector := (1.0, 1.0, 1.0);
    	result	: Float_Vector := (x, x, x);
    	testres : Float_Vector := (5.0, 5.0, 5.0);
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,x);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if testres = result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(11)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(11)  VECTORS mulityply_cross_test_4");
          Put_Line ("           Script name:'vectors_test.ts'; Line:99 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(11)  VECTORS mulityply_cross_test_4");
        Put_Line ("           Script name:'vectors_test.ts'; Line:99 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
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

  -- Test Case (12)   VECTORS mulityply_cross_test_5
  declare
    x		: Float := Float'Last;
    	y		: Float := 1.0;
    	v1 		: Float_Vector := (x, x, x);
    	result	: Float_Vector := (x, x, x);
    	testres : Float_Vector := (5.0, 5.0, 5.0);
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,y);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if testres = result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(12)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(12)  VECTORS mulityply_cross_test_5");
          Put_Line ("           Script name:'vectors_test.ts'; Line:108 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(12)  VECTORS mulityply_cross_test_5");
        Put_Line ("           Script name:'vectors_test.ts'; Line:108 ");
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

  -- Test Case (13)   VECTORS mulityply_cross_test_6
  declare
    x		: Float := 2.0;
    	y		: Float := 1.0;
    	v1 		: Float_Vector := (x, x);
    	v2 		: Float_Vector := (y, y);
    	testres : Float_Vector := (x, y);
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,v2);
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
        Put_Line ("(13)  pass.");
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(13)  VECTORS mulityply_cross_test_6");
        Put_Line ("           Script name:'vectors_test.ts'; Line:117 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `Constraint_Error' was expected" & ")");
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

  -- Test Case (14)   VECTORS mulityply_cross_test_7
  declare
    x		: Float := 2.0;
    	y		: Float := 1.0;
    	v1 		: Float_Vector := (x, x, y);
    	v2 		: Float_Vector := (y, y);
    	testres : Float_Vector := (x, y);
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,v2);
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
        Put_Line ("(14)  pass.");
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(14)  VECTORS mulityply_cross_test_7");
        Put_Line ("           Script name:'vectors_test.ts'; Line:126 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `Constraint_Error' was expected" & ")");
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

  -- Test Case (15)   VECTORS mulityply_cross_test_8
  declare
    x		: Float := 2.0;
    	y		: Float := 1.0;
    	v1 		: Float_Vector := (x, x);
    	v2 		: Float_Vector := (y, y, x);
    	testres : Float_Vector := (x, y);
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,v2);
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
        Put_Line ("(15)  pass.");
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(15)  VECTORS mulityply_cross_test_8");
        Put_Line ("           Script name:'vectors_test.ts'; Line:135 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `Constraint_Error' was expected" & ")");
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

  -- Test Case (16)   VECTORS mulityply_scalar_product_test_0
  declare
    x		: Float := 2.0;
    	y		: Float := 1.0;
    	v1 		: Float_Vector := (x, x, x);
    	v2 		: Float_Vector := (y, y, y);
    	result	: Float := 6.0;
    	testres : Float := 2.0;
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,v2);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if testres = result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(16)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(16)  VECTORS mulityply_scalar_product_test_0");
          Put_Line ("           Script name:'vectors_test.ts'; Line:146 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(16)  VECTORS mulityply_scalar_product_test_0");
        Put_Line ("           Script name:'vectors_test.ts'; Line:146 ");
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

  -- Test Case (17)   VECTORS mulityply_scalar_product_test_1
  declare
    x		: Float := 2.0;
    	y		: Float := 0.0;
    	v1 		: Float_Vector := (x, x, x);
    	v2 		: Float_Vector := (y, y, y);
    	result	: Float := 0.0;
    	testres : Float := 2.0;
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,v2);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if testres = result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(17)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(17)  VECTORS mulityply_scalar_product_test_1");
          Put_Line ("           Script name:'vectors_test.ts'; Line:156 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(17)  VECTORS mulityply_scalar_product_test_1");
        Put_Line ("           Script name:'vectors_test.ts'; Line:156 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 17.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 17.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (18)   VECTORS mulityply_scalar_product_test_2
  declare
    x		: Float := Float'First;
    	y		: Float := 1.0;
    	v1 		: Float_Vector := (x, -x, x);
    	v2 		: Float_Vector := (y, y, y);
    	result	: Float := Float'First;
    	testres : Float := 2.0;
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,v2);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if testres = result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(18)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(18)  VECTORS mulityply_scalar_product_test_2");
          Put_Line ("           Script name:'vectors_test.ts'; Line:166 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(18)  VECTORS mulityply_scalar_product_test_2");
        Put_Line ("           Script name:'vectors_test.ts'; Line:166 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 18.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 18.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (19)   VECTORS mulityply_scalar_product_test_3
  declare
    x		: Float := Float'Last;
    	y		: Float := 1.0;
    	v1 		: Float_Vector := (x, -x, x);
    	v2 		: Float_Vector := (y, y, y);
    	result	: Float := Float'Last;
    	testres : Float := 2.0;
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,v2);
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if testres = result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(19)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(19)  VECTORS mulityply_scalar_product_test_3");
          Put_Line ("           Script name:'vectors_test.ts'; Line:176 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(19)  VECTORS mulityply_scalar_product_test_3");
        Put_Line ("           Script name:'vectors_test.ts'; Line:176 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 19.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 19.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (20)   VECTORS mulityply_scalar_product_test_4
  declare
    x		: Float := Float'Last;
    	y		: Float := 1.0;
    	v1 		: Float_Vector := (x, -x, x);
    	v2 		: Float_Vector := (y, y);
    	result	: Float := Float'Last;
    	testres : Float := 2.0;
  begin  -- test case
    begin  -- test part
      testres := Vectors."*"(v1,v2);
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
        Put_Line ("(20)  pass.");
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(20)  VECTORS mulityply_scalar_product_test_4");
        Put_Line ("           Script name:'vectors_test.ts'; Line:186 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `Constraint_Error' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 20.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 20.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (21)   VECTORS verify_put_procedure_0
  declare
    v1		: Float_Vector := (1.0, 2.0, 3.0);
    	Result	: String := "( 1.0,  2.0,  3.0)";
    	Line	: String := "( 1.0,  2.0,  8.0)";
  begin  -- test case
    begin  -- test part
      Redirect_Stdout("out.txt");
      	Vectors.Vector_Put(v1);
      	Stdout;
      	Read_Line(Line, "out.txt");
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if Line = Result
           	
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(21)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(21)  VECTORS verify_put_procedure_0");
          Put_Line ("           Script name:'vectors_test.ts'; Line:198 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(21)  VECTORS verify_put_procedure_0");
        Put_Line ("           Script name:'vectors_test.ts'; Line:198 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 21.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 21.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (22)   VECTORS verify_put_procedure_1
  declare
    x 		: Float := 3.0;
    	v1		: Float_Vector := (x, x);
    	Result	: String := "( 3.0,  3.0)";
    	Line	: String := "( 1.0,  2.0)";
  begin  -- test case
    begin  -- test part
      Redirect_Stdout("out.txt");
      	Vectors.Vector_Put(v1);
      	Stdout;
      	Read_Line(Line, "out.txt");
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if Line = Result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(22)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(22)  VECTORS verify_put_procedure_1");
          Put_Line ("           Script name:'vectors_test.ts'; Line:208 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(22)  VECTORS verify_put_procedure_1");
        Put_Line ("           Script name:'vectors_test.ts'; Line:208 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 22.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 22.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  -- Test Case (23)   VECTORS verify_put_procedure_2
  declare
    x 		: Float := 3.0;
    	v1		: Float_Vector := (1=>x);
    	Result	: String := "( 3.0)";
    	Line	: String := "( 1.0)";
  begin  -- test case
    begin  -- test part
      Redirect_Stdout("out.txt");
      	Vectors.Vector_Put(v1);
      	Stdout;
      	Read_Line(Line, "out.txt");
      Driver_Internals.Set_Path ("=>");
    exception
      when Constraint_Error =>
        Driver_Internals.Set_Path ("Constraint_Error");
      when E: others =>
        Driver_Internals.Set_Path (Ada.Exceptions.Exception_Name (E));
    end;  -- test part
    begin  -- result part
      if Driver_Internals.Path_Was ("=>") then
        if Line = Result
        then
          Driver_Internals.Test_Case_Passed := True;
          Put_Line ("(23)  pass.");
        else
          Driver_Internals.Test_Case_Passed := False;
          Driver_Internals.Fail_Result := True;
          Put_Line ("(23)  VECTORS verify_put_procedure_2");
          Put_Line ("           Script name:'vectors_test.ts'; Line:219 ");
          Put_Line ("      ...FAIL.");
          Put_Line ("         (" & "path `=>' was taken, but predicate is FALSE" & ")");
        end if;
      else
        Driver_Internals.Test_Case_Passed := False;
        Driver_Internals.Fail_Result := True;
        Put_Line ("(23)  VECTORS verify_put_procedure_2");
        Put_Line ("           Script name:'vectors_test.ts'; Line:219 ");
        Put_Line ("      ...FAIL.");
        Put_Line ("         (" & "path `" & Driver_Internals.Taken_Path & "' when `=>' was expected" & ")");
      end if;
    exception
      when Constraint_Error =>
        Put_Line ("ERROR: exception `Constraint_Error', result part of test case 23.");
        Driver_Internals.Unexpected_Error := True;
        raise Driver_Internals.Program_Terminate;
      when Driver_Internals.Program_Terminate =>
        raise;
      when E: others =>
        Driver_Internals.Unexpected_Error := True;
        Put_Line ("ERROR: exception " & Ada.Exceptions.Exception_Name (E) & " raised in result part of test case 23.");
        raise Driver_Internals.Program_Terminate;
    end;  -- result part
  end;  -- test case

  --  End of test cases
  New_Line;
  Put ("Script name 'vectors_test.ts'");
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

end vectors_test;
