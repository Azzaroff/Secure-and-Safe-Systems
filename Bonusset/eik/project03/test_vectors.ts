context with Vectors; use Vectors;
		with Test_StdIO; use Test_StdIO;
		with Ada.Text_IO; use Ada.Text_IO;
exceptions Constraint_Error;

***** Put Test empty Vector
define 	Vec1:Float_Vector(1..0);
		Text_File : File_Type;	
		File_Text : String(1..50);
		Compare_Text : constant String := "()";
		Result : Boolean := True;
		Line_Length : Natural;
prepare Redirect_To_File;
test 	Vector_Put(Vec1);
		Redirect_To_StdOut;
		Open(Text_File, In_File, "std_out.txt");
		Get_Line(Text_File, File_Text, Line_Length);
		for I in 1..Line_Length loop
			if File_Text(I) /= Compare_Text(I) then
				Result := False;
			end if;
		end loop;
		Close(Text_File);
pass 	Result

***** Put Test 2 dimensional Vector
define 	Vec1:Float_Vector(1..2);
		Text_File : File_Type;	
		File_Text : String(1..50);
		Compare_Text : constant String := "( 1.0,  1.0)";
		Result : Boolean := True;
		Line_Length : Natural;
prepare Vec1 := ( 1.0, 1.0);
		Redirect_To_File;
test 	Vector_Put(Vec1);
		Redirect_To_StdOut;
		Open(Text_File, In_File, "std_out.txt");
		Get_Line(Text_File, File_Text, Line_Length);
		for I in 1..Line_Length loop
			if File_Text(I) /= Compare_Text(I) then
				Result := False;
			end if;
		end loop;
		Close(Text_File);
pass 	Result

***** Put Test 3 dimensional Vector
define 	Vec1:Float_Vector(1..3);
		Text_File : File_Type;	
		File_Text : String(1..50);
		Compare_Text : constant String := "( 1.0,  1.0,  1.0)";
		Result : Boolean := True;
		Line_Length : Natural;
prepare Vec1 := ( 1.0, 1.0, 1.0);
		Redirect_To_File;
test 	Vector_Put(Vec1);
		Redirect_To_StdOut;
		Open(Text_File, In_File, "std_out.txt");
		Get_Line(Text_File, File_Text, Line_Length);
		for I in 1..Line_Length loop
			if File_Text(I) /= Compare_Text(I) then
				Result := False;
			end if;
		end loop;
		Close(Text_File);
pass 	Result



***** Cross_Product normal
define 	Vec1, Vec2, Result:Float_Vector(1..3);	
prepare Vec1 := ( 1.0, 1.0, 1.0);
		Vec2 := ( 1.0, 2.0, 3.0);
test 	Result := Vec1 * Vec2;
pass 	Result = (1.0, -2.0, 1.0)

***** Cross_Product unequal Dimensions, first smaller
define 	Vec1, Result:Float_Vector(1..2);
		Vec2:Float_Vector(1..3);		
prepare Vec1 := ( 1.0, 1.0);
		Vec2 := ( 1.0, 2.0, 3.0);
test 	Result := Vec1 * Vec2;
pass 	exception Constraint_Error

***** Cross_Product unequal Dimensions, second smaller
define 	Vec1, Result:Float_Vector(1..3);
		Vec2:Float_Vector(1..2);		
prepare Vec1 := ( 1.0, 1.0, 1.0);
		Vec2 := ( 1.0, 2.0);
test 	Result := Vec1 * Vec2;
pass 	exception Constraint_Error

***** Cross_Product Dimension unequal 3
define 	Vec1, Vec2, Result:Float_Vector(1..2);	
prepare Vec1 := ( 1.0, 1.0);
		Vec2 := ( 1.0, 2.0);
test 	Result := Vec1 * Vec2;
pass 	exception Constraint_Error

***** Cross_Product empty Vector
define 	Vec1, Vec2, Result:Float_Vector(1..0);	
test 	Result := Vec1 * Vec2;
pass 	exception Constraint_Error




***** Scalar_Product normal
define 	Vec1, Vec2:Float_Vector(1..3);	
	   	Result: Float;	
prepare Vec1 := ( 1.0, 1.0, 1.0);
		Vec2 := ( 1.0, 2.0, 3.0);
test 	Result := Vec1 * Vec2;
pass 	Result = 6.0

***** Scalar_Product unequal Dimensions, first smaller
define 	Vec1:Float_Vector(1..2);
		Vec2:Float_Vector(1..3);		
	   	Result: Float;	
prepare Vec1 := ( 1.0, 1.0);
		Vec2 := ( 1.0, 2.0, 3.0);
test 	Result := Vec1 * Vec2;
pass 	exception Constraint_Error

***** Scalar_Product unequal Dimensions, second smaller
define 	Vec1:Float_Vector(1..3);
		Vec2:Float_Vector(1..2);		
	   	Result: Float;	
prepare Vec1 := ( 1.0, 1.0, 1.0);
		Vec2 := ( 1.0, 2.0);
test 	Result := Vec1 * Vec2;
pass 	exception Constraint_Error

***** Scalar_Product empty Vector
define 	Vec1, Vec2:Float_Vector(1..0);		
	   	Result: Float;	
test 	Result := Vec1 * Vec2;
pass 	Result = 0.0




***** Stretching normal
define 	Vec1, Result:Float_Vector(1..3);	
prepare Vec1 := ( 1.0, 2.0, 3.0);
test 	Result := Vec1 * 2.0;
pass 	Result = ( 2.0, 4.0, 6.0)

***** Stretching Float'First
define 	Vec1, Result:Float_Vector(1..3);
prepare Vec1 := ( 1.0, 2.0, 3.0);	
test 	Result := Vec1 * Float'First;
pass 	(Result(1) = Float'First) and (Result(2) < Float'First) and (Result(3) < Float'First)

***** Stretching Float'Last
define 	Vec1, Result:Float_Vector(1..3);		
prepare Vec1 := ( 1.0, 2.0, 3.0);
test 	Result := Vec1 * Float'Last;
pass 	(Result(1) = Float'Last) and (Result(2) > Float'Last) and (Result(3) > Float'Last)

***** Stretching Zero
define 	Vec1, Result:Float_Vector(1..3);	
prepare Vec1 := ( 1.0, 2.0, 3.0);
test 	Result := Vec1 * 0.0;
pass 	Result = (0.0, 0.0, 0.0)










