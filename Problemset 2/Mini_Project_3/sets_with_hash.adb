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
            if (Maps.Contains(Maps.Map(A),Maps.Key(elemB))) then
               C.Insert( Maps.Key(elemB));
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
            if (Maps.Contains(Maps.Map(A),Maps.Key(elemB))) then
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
   if not(Natural((Maps.Length(Maps.map(A)))) > Natural(Maps.Length(Maps.map(B)))) then
      while Maps.Has_Element(elemA) loop
         if not(Maps.Contains(Maps.Map(B),Maps.Key(elemA))) then
            return false;
         end if;
         Maps.Next(elemA);
      end loop;
      return true;
	else 
		return false;
    end if;
end "<="; -- A subset of B

function "<" (A, B : Set ) return Boolean is
begin
   if (Natural((Maps.Length(Maps.map(A)))) < Natural(Maps.Length(Maps.map(B)))) then
      return "<="(A,B);
   else
      return false;
   end if;
end "<"; -- A propper subset of B

function "=" (A, B : Set ) return Boolean is
      elemA: Maps.Cursor := First(A);
      elemB: Maps.Cursor := First(B);
begin
      while Maps.Has_Element(elemA) loop
         if not(Maps.Contains(Maps.Map(B),Maps.Key(elemA))) then
            return false;
         end if;
         Maps.Next(elemA);
	  end loop;
	  return true;
end "="; -- A and B are equal

procedure Delete (A: in out Set ; Item : Item_Type ) is
begin
   Maps.Delete(Maps.map(A),Item);
end Delete; -- A − { Item }

function "<=" ( Item : Item_Type ; S : Set ) return Boolean is
begin
   return (To_Set(Item) <= S);
end "<="; -- { Item } <= S

procedure Put(A:Set) is
      use Maps;
      Iterator : Maps.Cursor := A.First;
      Item:Item_Type;
begin
      Ada.Text_IO.Put("{");
      if not A.Is_Empty then
         while Iterator /= Maps.No_Element loop
            Item := Maps.Key(Iterator);
            Put_Item(Item);
            Maps.Next(Iterator);
            if Iterator /= Maps.No_Element then
               Ada.Text_IO.Put(", ");
            end if;
         end loop;
      end if;
         Ada.Text_IO.Put("}");
end Put;

end sets_with_hash;
