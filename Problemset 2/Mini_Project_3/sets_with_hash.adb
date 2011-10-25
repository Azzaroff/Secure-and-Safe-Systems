package body sets_with_hash is


function To_Set ( Item : Item_Type ) return Set is
A : Set;
begin
A.Insert(Item);
return A;
end To_Set;

function Empty_Set return Set is
A : Set;
begin
	return A;
end Empty_Set;

procedure Insert (A: in out Set ; Item : Item_Type ) is
      dummy : Dummy_Type;
begin

      Maps.Insert(Maps.map(A),
                     Key => item,
                  New_Item => dummy);

end Insert;

function "and" (A, B : Set ) return Set is
begin
   return A; --Dummy
end "and"; -- union

function "or" (A, B : Set ) return Set is
begin
   return A; --Dummy
end "or"; -- intersection

function "-" (A, B : Set ) return Set is
begin
   return A; --Dummy
end "-"; -- difference

function "<=" (A, B : Set ) return Boolean is
begin
   return true; --Dummy
end "<="; -- A subset of B

function "<" (A, B : Set ) return Boolean is
begin
   return true; --Dummy
end "<"; -- A propper subset of B

function "=" (A, B : Set ) return Boolean is
begin
   return true; --Dummy
end "="; -- A and B are equal

procedure Delete (A: in out Set ; Item : Item_Type ) is
begin
   null;
end Delete; -- A − { Item }

function "<=" ( Item : Item_Type ; S : Set ) return Boolean is
begin
   return true;
end "<="; -- { Item } <= S



end sets_with_hash;
