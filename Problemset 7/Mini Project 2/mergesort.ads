generic
   type Element_Type is private;
   type Index_Type is (<>);
   type Collection_Type is array(Index_Type range <>) of Element_Type;
   with function "<"(Left, Right : Element_Type) return Boolean is <>;
 
package Mergesort is
   procedure Merge(Left, Right : in Collection_Type; Result : out Collection_Type);
   procedure Sort (Item : in out Collection_Type);
end MergeSort;
