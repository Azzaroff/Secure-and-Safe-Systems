context with Vectors; 		use Vectors;
		with Ada.Text_IO;    	use Ada.Text_IO;
		with Redirect_Stdin;
		with Stdin;
		with Redirect_Stdout;
		with Stdout;
		with Read_Line;

***** VECTORS mulityply_test_0
define  v1 		: Float_Vector := (1.0, 1.0, 1.0);
		v2 		: Float_Vector := (2.0, 2.0, 2.0);
		result	: Float_Vector := (0.0, 0.0, 0.0);
		testres : Float_Vector := (5.0, 5.0, 5.0);
test testres := Vectors."*"(v1,v2);
pass testres = result

***** VECTORS mulityply_test_1
define  v1 		: Float_Vector := (0.0, 0.0, 0.0);
		v2 		: Float_Vector := (2.0, 2.0, 2.0);
		result	: Float_Vector := (0.0, 0.0, 0.0);
		testres : Float_Vector := (5.0, 5.0, 5.0);
test testres := Vectors."*"(v1,v2);
pass testres = result

***** VECTORS mulityply_test_2
define  v1 		: Float_Vector := (1.0, 1.0, 1.0);
		v2 		: Float_Vector := (0.0, 0.0, 0.0);
		result	: Float_Vector := (0.0, 0.0, 0.0);
		testres : Float_Vector := (5.0, 5.0, 5.0);
test testres := Vectors."*"(v1,v2);
pass testres = result

***** VECTORS mulityply_test_3
define  x		: Float := Float'First;
		y		: Float := 1.0;
		v1 		: Float_Vector := (x, x, x);
		v2 		: Float_Vector := (1.0, 1.0, 1.0);
		result	: Float_Vector := (x*y-x*y, x*y-x*y, x*y-x*y);
		testres : Float_Vector := (5.0, 5.0, 5.0);
test testres := Vectors."*"(v1,v2);
pass testres = result

***** VECTORS mulityply_test_4
define  x		: Float := Float'Last;
		y		: Float := 1.0;
		v1 		: Float_Vector := (x, x, x);
		v2 		: Float_Vector := (1.0, 1.0, 1.0);
		result	: Float_Vector := (x*y-x*y, x*y-x*y, x*y-x*y);
		testres : Float_Vector := (5.0, 5.0, 5.0);
test testres := Vectors."*"(v1,v2);
pass testres = result

-------------------------------------------------------------------------------
***** VECTORS mulityply_scalar_test_0
define  x		: Float := Float'First;
		y		: Float := 2.0;
		v1 		: Float_Vector := (1.0, 1.0, 1.0);
		result	: Float_Vector := (2.0, 2.0, 2.0);
		testres : Float_Vector := (5.0, 5.0, 5.0);
test testres := Vectors."*"(v1,y);
pass testres = result

***** VECTORS mulityply_scalar_test_1
define  y		: Float := 0.0;
		v1 		: Float_Vector := (1.0, 1.0, 1.0);
		result	: Float_Vector := (0.0, 0.0, 0.0);
		testres : Float_Vector := (5.0, 5.0, 5.0);
test testres := Vectors."*"(v1,y);
pass testres = result

***** VECTORS mulityply_scalar_test_2
define  y		: Float := 8.0;
		v1 		: Float_Vector := (0.0, 0.0, 0.0);
		result	: Float_Vector := (0.0, 0.0, 0.0);
		testres : Float_Vector := (5.0, 5.0, 5.0);
test testres := Vectors."*"(v1,y);
pass testres = result

***** VECTORS mulityply_scalar_test_3
define  x		: Float := Float'First;
		y		: Float := 1.0;
		v1 		: Float_Vector := (1.0, 1.0, 1.0);
		result	: Float_Vector := (x, x, x);
		testres : Float_Vector := (5.0, 5.0, 5.0);
test testres := Vectors."*"(v1,x);
pass testres = result

***** VECTORS mulityply_scalar_test_4
define  x		: Float := Float'First;
		y		: Float := 1.0;
		v1 		: Float_Vector := (x, x, x);
		result	: Float_Vector := (x, x, x);
		testres : Float_Vector := (5.0, 5.0, 5.0);
test testres := Vectors."*"(v1,y);
pass testres = result

***** VECTORS mulityply_scalar_test_4
define  x		: Float := Float'Last;
		y		: Float := 1.0;
		v1 		: Float_Vector := (1.0, 1.0, 1.0);
		result	: Float_Vector := (x, x, x);
		testres : Float_Vector := (5.0, 5.0, 5.0);
test testres := Vectors."*"(v1,x);
pass testres = result

***** VECTORS mulityply_scalar_test_5
define  x		: Float := Float'Last;
		y		: Float := 1.0;
		v1 		: Float_Vector := (x, x, x);
		result	: Float_Vector := (x, x, x);
		testres : Float_Vector := (5.0, 5.0, 5.0);
test testres := Vectors."*"(v1,y);
pass testres = result

-------------------------------------------------------------

***** VECTORS mulityply_scalar_product_test_0
define  x		: Float := 2.0;
		y		: Float := 1.0;
		v1 		: Float_Vector := (x, x, x);
		v2 		: Float_Vector := (y, y, y);
		result	: Float := 6.0;
		testres : Float := 2.0;
test testres := Vectors."*"(v1,v2);
pass testres = result

***** VECTORS mulityply_scalar_product_test_1
define  x		: Float := 2.0;
		y		: Float := 0.0;
		v1 		: Float_Vector := (x, x, x);
		v2 		: Float_Vector := (y, y, y);
		result	: Float := 0.0;
		testres : Float := 2.0;
test testres := Vectors."*"(v1,v2);
pass testres = result

***** VECTORS mulityply_scalar_product_test_2
define  x		: Float := Float'First;
		y		: Float := 1.0;
		v1 		: Float_Vector := (x, -x, x);
		v2 		: Float_Vector := (y, y, y);
		result	: Float := Float'First;
		testres : Float := 2.0;
test testres := Vectors."*"(v1,v2);
pass testres = result

***** VECTORS mulityply_scalar_product_test_3
define  x		: Float := Float'Last;
		y		: Float := 1.0;
		v1 		: Float_Vector := (x, -x, x);
		v2 		: Float_Vector := (y, y, y);
		result	: Float := Float'Last;
		testres : Float := 2.0;
test testres := Vectors."*"(v1,v2);
pass testres = result


-------------------------------------------------------

***** VECTORS verify_put_procedure_0
define	v1		: Float_Vector := (1.0, 2.0, 3.0);
		Result	: String := "( 1.0,  2.0,  3.0)";
		Line	: String := "( 1.0,  2.0,  8.0)";
test	Redirect_Stdout("out.txt");
		Vectors.Vector_Put(v1);
		Stdout;
		Read_Line(Line, "out.txt");
pass	Line = Result
		
***** VECTORS verify_put_procedure_1
define	x 		: Float := Float'First;	
		v1		: Float_Vector := (x, x, x);
		Result	: String := "("&x'Img&","&x'Img&","&x'Img&")";
		Line	: String := "( 1.0,  2.0,  8.0)";
test	Redirect_Stdout("out.txt");
		Vectors.Vector_Put(v1);
		Stdout;
		Read_Line(Line, "out.txt");
		Ada.Text_IO.Put_Line(Result);
		Ada.Text_IO.Put_Line(Line);
pass	Line = Result
