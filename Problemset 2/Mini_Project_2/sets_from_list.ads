private with Ada.Containers.Indefinite_Doubly_Linked_Lists;
generic
type Item_Type is private ;
with function "=" (X, Y: Item_Type ) return Boolean is <>;
package Sets_From_List is
-- set as an ( unsorded ) list of items
type Set is private ;
function "and" (A, B : Set ) return Set ; -- union
function "or" (A, B : Set ) return Set ; -- intersection
function "-" (A, B : Set ) return Set ; -- difference
function "<=" (A, B : Set ) return Boolean ; -- A subset of B
function "<" (A, B : Set ) return Boolean ; -- A propersubset of B
function "=" (A, B : Set ) return Boolean ; -- A and B are equal
function To_Set ( Item : Item_Type ) return Set ; -- { Item }
procedure Insert (A: in out Set ; Item : Item_Type ) ; -- A or To_Set ( Item )
function Empty_Set return Set ; -- {}
procedure Delete (A: in out Set ; Item : Item_Type ) ; -- A − { Item }
function "<=" ( Item : Item_Type ; S : Set ) return Boolean ; -- { Item } <= S
private
package Lists is new Ada.Containers.Indefinite_Doubly_Linked_Lists
   (Element_Type 	=> Item_Type,
    "="			=> "=");

type Set is new Lists.List with null record ;
end Sets_From_List ;

