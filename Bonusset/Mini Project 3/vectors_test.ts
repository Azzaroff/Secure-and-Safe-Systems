context with Vectors; use Vectors;
	with Text_IO;    	use Text_IO;

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
define  x		: Float := Float'First;
		y		: Float := 0.0;
		v1 		: Float_Vector := (1.0, 1.0, 1.0);
		result	: Float_Vector := (0.0, 0.0, 0.0);
		testres : Float_Vector := (5.0, 5.0, 5.0);
test testres := Vectors."*"(v1,y);
pass testres = result

***** VECTORS mulityply_scalar_test_2
define  x		: Float := Float'First;
		y		: Float := 1.0;
		v1 		: Float_Vector := (1.0, 1.0, 1.0);
		result	: Float_Vector := (x, x, x);
		testres : Float_Vector := (5.0, 5.0, 5.0);
test testres := Vectors."*"(v1,x);
pass testres = result

***** VECTORS mulityply_scalar_test_3
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

***** VECTORS mulityply_scalar_product_test_0
define  x		: Float := Float'First;
		y		: Float := 1.0;
		v1 		: Float_Vector := (x, -x, x);
		v2 		: Float_Vector := (y, y, y);
		result	: Float := Float'First;
		testres : Float := 2.0;
test testres := Vectors."*"(v1,v2);
pass testres = result

***** VECTORS mulityply_scalar_product_test_0
define  x		: Float := Float'Last;
		y		: Float := 1.0;
		v1 		: Float_Vector := (x, -x, x);
		v2 		: Float_Vector := (y, y, y);
		result	: Float := Float'Last;
		testres : Float := 2.0;
test testres := Vectors."*"(v1,v2);
pass testres = result
