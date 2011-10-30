package body sets_from_list is

--union
function "and" (A, B : Set ) return Set is
     C : Set;
     elemA: Lists.Cursor := First(A);
     elemB: Lists.Cursor := First(B);
begin
    while Lists.Has_Element(elemA) loop
       C.Insert( Lists.Element(elemA));
       Lists.Next(elemA);
    end loop;

    while Lists.Has_Element(elemB) loop
       C.Insert( Lists.Element(elemB));
       Lists.Next(elemB);
    end loop;
    return C;
end "and"; -- union

--intersection
function "or" (A, B : Set ) return Set is
      C : Set;
      elemA: Lists.Cursor := First(A);
      elemB: Lists.Cursor := First(B);
begin
      while Lists.Has_Element(elemA) loop
         while Lists.Has_Element(elemB) loop
            if (Lists.Contains(Lists.List(A),Lists.Element(elemB))) then
               C.Insert( Lists.Element(elemB));
            end if;
            Lists.Next(elemB);
         end loop;
         Lists.Next(elemA);
      end loop;
      return C;
end "or"; -- intersection

-- gets the difference between A and B
function "-" (A, B : Set ) return Set is
C : Set := A;
      elemA: Lists.Cursor := First(A);
      elemB: Lists.Cursor := First(B);
begin
      while Lists.Has_Element(elemA) loop
         while Lists.Has_Element(elemB) loop
            if (Lists.Contains(Lists.List(A),Lists.Element(elemB))) then
               Delete(C, Lists.Element(elemB));
            end if;
            Lists.Next(elemB);
         end loop;
         Lists.Next(elemA);
      end loop;
      return C;
end "-";

-- is A a subset of B?
function "<=" (A, B : Set ) return Boolean is
 	elemA : Lists.Cursor := First(A);
begin
	while Lists.Has_Element(elemA) loop
         if not(Lists.Contains(Lists.List(B),Lists.Element(elemA))) then
            return false;
         end if;
         Lists.Next(elemA);
      	end loop;
      	return true;
end "<=";

--is a a propper subset of b
function "<" (A, B : Set ) return Boolean is

begin
	if (Natural((Lists.Length(Lists.list(A)))) /= Natural(Lists.Length(Lists.list(B)))) then
	      return "<="(A,B);
	   else
	      return false;
	   end if;
end "<";

-- tests whether one set is equal to another one
function "=" (A, B : Set ) return Boolean is

begin
	return Lists."="(Lists.list(A), Lists.list(B));
end "=";

--To_Set
function To_Set ( Item : Item_Type ) return Set is
A : Set;
begin
Insert(A, Item);
return A;
end To_Set;

-- Insert
procedure Insert (A: in out Set ; Item : Item_Type ) is
begin
	Lists.Append(Lists.list(A),
			New_Item => Item);
end Insert;

-- generate an empty set
function Empty_Set return Set is
A : Set;
begin
	return A;
end Empty_Set;

--deletes one element from the set
procedure Delete (A: in out Set ; Item : Item_Type ) is
	position : Lists.Cursor;
begin
	position := Lists.Find(Lists.list(A), Item); -- helpfull to avoid copmpiler errors
	Lists.Delete(Lists.list(A),
			position);
end Delete;

--tests if there is this element in set
function "<=" ( Item : Item_Type ; S : Set ) return Boolean is
begin
    return (To_Set(Item) <= S);
end "<=";

-- end of file
end sets_from_list;


