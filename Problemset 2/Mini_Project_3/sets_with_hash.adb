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

begin
	Maps.Insert(Container => A, New_Item => Item, Key => Hash(Item));
end Insert;


end sets_with_hash;
