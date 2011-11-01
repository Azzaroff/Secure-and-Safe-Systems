with Ada.Text_IO;

private with Ada.Containers.Indefinite_Hashed_Maps;

generic
	type Item_Type is private ;
	with function "=" (X, Y: Item_Type ) return Boolean is <>;
	with function Hash ( Item : Item_Type ) return Ada.Containers.Hash_Type is <>;
        with procedure Put_Item(Item:Item_Type);

package Sets_With_Hash is

-- constant time insers and remove operations
type Set is private;

	function "and" (A, B : Set ) return Set ; -- union
	function "or" (A, B : Set ) return Set ; -- intersection
	function "-" (A, B : Set ) return Set ; -- difference
	function "<=" (A, B : Set ) return Boolean ; -- A subset of B
	function "<" (A, B : Set ) return Boolean ; -- A propper subset of B
	function "=" (A, B : Set ) return Boolean ; -- A and B are equal
	function To_Set ( Item : Item_Type ) return Set ; -- { Item }

	procedure Insert (A: in out Set ; Item : Item_Type ) ; -- A or To_Set ( Item )

	function Empty_Set return Set ; -- {}

	procedure Delete (A: in out Set ; Item : Item_Type ) ; -- A − { Item }

	function "<=" ( Item : Item_Type ; S : Set ) return Boolean ; -- { Item } <= S

	procedure Put(A:Set);

private
type Dummy_Type is( Dummy_Type_Value) ;

package Maps is new Ada.Containers.Indefinite_Hashed_Maps
	( Key_Type => Item_Type,
	Element_Type => Dummy_Type,
	Hash => Hash,
	Equivalent_Keys => "=" ) ;

type Set is new Maps.Map with null record ;

end Sets_With_Hash ;
