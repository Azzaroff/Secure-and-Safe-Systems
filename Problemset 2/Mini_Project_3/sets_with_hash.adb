package body sets_with_hash is


function To_Set ( Item : Item_Type ) return Set is
A : Set;
begin
 Insert(A, Item);
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
      --ignore items of the map, use hash as items for the set!
      Maps.Insert(Maps.map(A),
                     Key => item,
                  New_Item => dummy);

end Insert;

function "and" (A, B : Set ) return Set is
     C : Set;
     elemA: Maps.Cursor := First(A);
     elemB: Maps.Cursor := First(B);
begin
    while Maps.Has_Element(elemA) loop
       C.Insert( Maps.Key(elemA));
       Maps.Next(elemA);
    end loop;

    while Maps.Has_Element(elemB) loop
       C.Insert( Maps.Key(elemB));
       Maps.Next(elemB);
    end loop;
    return C;
end "and"; -- union

function "or" (A, B : Set ) return Set is
      C : Set;
      elemA: Maps.Cursor := First(A);
      elemB: Maps.Cursor := First(B);
begin
      while Maps.Has_Element(elemA) loop
         while Maps.Has_Element(elemB) loop
            if (Maps.Key(elemA) = Maps.Key(elemB)) then
               C.Insert( Maps.Key(elemA));
            end if;
            Maps.Next(elemB);
         end loop;
         Maps.Next(elemA);
      end loop;
      return C;
end "or"; -- intersection

function "-" (A, B : Set ) return Set is
      C : Set := A;
      elemA: Maps.Cursor := First(A);
      elemB: Maps.Cursor := First(B);
begin
      while Maps.Has_Element(elemA) loop
         while Maps.Has_Element(elemB) loop
            if (Maps.Key(elemA) = Maps.Key(elemB)) then
               Delete(C, Maps.Key(elemB));
            end if;
            Maps.Next(elemB);
         end loop;
         Maps.Next(elemA);
      end loop;
      return C;
end "-"; -- difference

function "<=" (A, B : Set ) return Boolean is
      elemA: Maps.Cursor := First(A);
begin
      while Maps.Has_Element(elemA) loop
         if (To_Set(Maps.Key(elemA)) <= B) then
            return true;
         end if;
         Maps.Next(elemA);
      end loop;
      return false;
end "<="; -- A subset of B

function "<" (A, B : Set ) return Boolean is
begin
   if (Natural((Maps.Length(Maps.map(A)))) /= Natural(Maps.Length(Maps.map(B)))) then
      return "<="(A,B);
   else
      return false;
   end if;
end "<"; -- A propper subset of B

function "=" (A, B : Set ) return Boolean is
begin
   return (Maps."="(Maps.map(A) ,Maps.map(B))); --Dummy
end "="; -- A and B are equal

procedure Delete (A: in out Set ; Item : Item_Type ) is
begin
   Maps.Delete(Maps.map(A),Item);
end Delete; -- A − { Item }

function "<=" ( Item : Item_Type ; S : Set ) return Boolean is
   begin
   -- Maps.Is_In findet er nicht obwohl es in der Referenz steht, deswegen dieser "Hack"
   return Maps.Has_Element(Maps.find(Maps.map(S), item));
end "<="; -- { Item } <= S



end sets_with_hash;
