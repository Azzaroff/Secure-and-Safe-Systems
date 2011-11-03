-- NOTE: This package was taken from the "csparts" library which can be
-- found on many Ada servers.  It is NOT copyrighted by the author of `tg',
-- neither is any warranty given for this piece of software.

-- *********************************************
-- *                                           *
-- *  LISTS                                    *  SPEC
-- *                                           *
-- *********************************************
generic
      type ITEMTYPE is private;  -- This is the data being manipulated.
      with function Equal (X,Y: in ITEMTYPE) return BOOLEAN is "=";
                                 -- This allows the user to define
                                 -- equality on ItemType.  For instance
                                 -- if ItemType is an abstract type
                                 -- then equality is defined in terms of
                                 -- the abstract type.  If this function
                                 -- is not provided equality defaults to
                                 -- =.
package Lists is
--| Purpose
--| This package provides singly linked lists with elements of type
--| ItemType, where ItemType is specified by a generic parameter.
--| 
--| When this package is instantiated, it provides a linked list type for
--| lists of objects of type ItemType, which can be any desired type.  A
--| complete set of operations for manipulation, and releasing
--| those lists is also provided.  For instance, to make lists of strings,
--| all that is necessary is:
--|
--| type StringType is string(1..10);
--|
--| package Str_List is new Lists(StringType); use Str_List;
--| 
--|    L:List;
--|    S:StringType;
--|
--| Then to add a string S, to the list L, all that is necessary is
--|
--|    L := Create;
--|    Attach(S,L);
--| 
--| Initialization Exceptions (none)
--| Notes (none)
--|
--| Modifications
--| Programmer Buddy Altus, Intermetrics

          type LIST       is private;
          type LISTITER   is private;

    CircularList     :exception;     -- Raised if an attemp is made to
                                     -- create a circular list.  This
                                     -- results when a list is attempted
                                     -- to be attached to itself.
     
    EmptyList        :exception;     -- Raised if an attemp is made to
                                     -- manipulate an empty list.

    ItemNotPresent   :exception;     -- Raised if an attempt is made to
                                     -- remove an element from a list in
                                     -- which it does not exist.

    NoMore           :exception;     -- Raised if an attemp is made to
                                     -- get the next element from a list
                                     -- after iteration is complete.

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.ATTACH                                       .  SPEC
  -- .                                                     .
  -- .......................................................
  procedure Attach (List1: in out LIST; List2: in LIST);
  --| Purpose
  --| Appends List2 to List1.  This makes the next field of the last element
  --| of List1 refer to List2.  This can possibly change the value of List1
  --| if List1 is an empty list.  This causes sharing of lists.  Thus if
  --| user Destroys List1 then List2 will be a dangling reference.
  --| This procedure raises CircularList if List1 equals List2.  If it is 
  --| necessary to Attach a list to itself first make a copy of the list and 
  --| attach the copy.
  --|
  --| Exceptions
  --|   CircularList
  --|
  --| Notes

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.ATTACH                                       .  SPEC
  -- .                                                     .
  -- .......................................................
  function Attach (Element1: in ITEMTYPE; Element2: in ITEMTYPE) return LIST;
  --| Purpose
  --| This creates a list containing the two elements in the order
  --| specified.
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.ATTACH                                       .  SPEC
  -- .                                                     .
  -- .......................................................
  procedure Attach (L: in out LIST; Element: in ITEMTYPE);
  --| Purpose
  --| Appends Element onto the end of the list L.  If L is empty then this
  --| may change the value of L.
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.ATTACH                                       .  SPEC
  -- .                                                     .
  -- .......................................................
  procedure Attach (Element: in ITEMTYPE; L: in  out LIST);
  --| Purpose
  --| This prepends list L with Element (makes Element the first item in
  --| list L).
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.ATTACH                                       .  SPEC
  -- .                                                     .
  -- .......................................................
  function Attach (List1: in LIST; List2: in LIST) return LIST;
  --| Purpose
  --| This returns a list which is List1 attached to List2.  If it is desired
  --| to make List1 be the new attached list the following ada code should be
  --| used.
  --|  
  --| List1 := Attach (List1, List2);
  --|
  --| This procedure raises CircularList if List1 equals List2.  If it is 
  --| necessary to Attach a list to itself first make a copy of the list and 
  --| attach the copy.
  --|
  --| Exceptions
  --|   CircularList
  --|
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.ATTACH                                       .  SPEC
  -- .                                                     .
  -- .......................................................
  function Attach (Element: in ITEMTYPE; L: in LIST) return LIST;
  --| Purpose
  --| Returns a new list which is headed by Element and followed by L.
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.ATTACH                                       .  SPEC
  -- .                                                     .
  -- .......................................................
  function Attach (L: in LIST; Element: in ITEMTYPE) return LIST;
  --| Purpose
  --| Returns a new list which is L followed by Element.
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.COPY                                         .  SPEC
  -- .                                                     .
  -- .......................................................
  function Copy (L: in LIST) return LIST;
  --| Purpose
  --| Returns a copy of L.
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.COPYDEEP                                     .  SPEC
  -- .                                                     .
  -- .......................................................
  generic
        with function Copy (I: in ITEMTYPE) return ITEMTYPE;
  function CopyDeep (L: in LIST) return LIST;
  --| Purpose
  --| This produces a new list whose elements have been duplicated using
  --| the Copy function provided by the user.  This is helpful if the type
  --| of a list is an abstract data type.
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.CREATE                                       .  SPEC
  -- .                                                     .
  -- .......................................................
  function Create return LIST;
  --| Purpose
  --| Returns an empty, initialized list.
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.DELETEHEAD                                   .  SPEC
  -- .                                                     .
  -- .......................................................
  procedure DeleteHead (L: in out LIST); 
  --| Purpose
  --| This will return the space occupied by the first element in the list
  --| to the heap.  If sharing exists between lists this procedure
  --| could leave a dangling reference.  If L is empty, EmptyList will be
  --| raised.
  --|
  --| Exceptions
  --|   EmptyList
  --|
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.DELETEITEM                                   .  SPEC
  -- .                                                     .
  -- .......................................................
  procedure DeleteItem (L: in out LIST; Element: in ITEMTYPE);
  --| Purpose
  --| Removes the first element of the list equal to Element.  If there is
  --| not an element equal to Element, then ItemNotPresent is raised.
  --|
  --| This operation is destructive; it returns the storage occupied by
  --| the elements being deleted.
  --|
  --| Exceptions
  --|   ItemNotPresent
  --|
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.DELETEITEM                                   .  SPEC
  -- .                                                     .
  -- .......................................................
  function DeleteItem (L: in LIST; Element: in ITEMTYPE) return LIST;
  --| Purpose
  --| This returns the List L with the first occurrence of Element removed.
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.DELETEITEMS                                  .  SPEC
  -- .                                                     .
  -- .......................................................
  function DeleteItems (L: in LIST; Element: in ITEMTYPE) return LIST;
  --| Purpose
  --| This function returns a copy of the list L which has all elements which
  --| have value Element removed.
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.DELETEITEMS                                  .  SPEC
  -- .                                                     .
  -- .......................................................
  procedure DeleteItems (L: in out LIST; Element: in ITEMTYPE);
  --| Purpose
  --| This procedure removes all occurrences of Element from the List L.  This
  --| is a destructive procedure.
  --|
  --| Exceptions (none)
  --| Notes (none)
 
  -- .......................................................
  -- .                                                     .
  -- .  LISTS.DESTROY                                      .  SPEC
  -- .                                                     .
  -- .......................................................
  procedure Destroy (L: in out LIST);
  --| Purpose
  --| This returns to the heap all the storage that a list occupies.  Keep in
  --| mind if there exists sharing between lists then this operation can leave
  --| dangling references.
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.DESTROYDEEP                                  .  SPEC
  -- .                                                     .
  -- .......................................................
  generic
    with procedure Dispose (I :in out ITEMTYPE); 
  procedure DestroyDeep (L :in out LIST);
  --| Purpose
  --| This procedure is used to destroy a list and all the objects contained
  --| in an element of the list.  For example if L is a list of lists
  --| then destroy L does not destroy the lists which are elements of L.
  --| DestroyDeep will now destroy L and all the objects in the elements of L.
  --| The produce Dispose is a procedure which will destroy the objects which
  --| comprise an element of a list.  For example if package  L was  a list
  --| of lists then Dispose for L would be the Destroy of list type package L was
  --| instantiated with.
  --| 
  --| This procedure requires no sharing between elements of lists. 
  --| For example, if L_int is a list of integers and L_of_L_int is a list 
  --| of lists of integers and two elements of L_of_L_int have the same value
  --| then doing a DestroyDeep will cause an access violation to be raised.  
  --| The best way to avoid this is not to have sharing between list elements
  --| or use copy functions when adding to the list of lists.
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.FIRSTVALUE                                   .  SPEC
  -- .                                                     .
  -- .......................................................
  function FirstValue (L: in LIST) return ITEMTYPE;
  --| Purpose
  --| This returns the Item in the first position in the list.  If the list
  --| is empty EmptyList is raised.
  --|
  --| Exceptions
  --|   EmptyList
  --|
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.FORWARD                                      .  SPEC
  -- .                                                     .
  -- .......................................................
  procedure Forward (I :in out LISTITER);
  --| Purpose
  --| This procedure can be used in conjunction with Cell to iterate over a list.
  --| This is in addition to Next.  Instead of writing
  --|
  --|  I :ListIter;
  --|  L :List;
  --|  V :List_Element_Type;
  --|  
  --|  I := MakeListIter(L);
  --|  while More(I) loop
  --|      Next (I, V);
  --|      Print (V);
  --|  end loop;
  --| 
  --| One can write
  --|
  --| I := MakeListIter(L);
  --| while More (I) loop
  --|     Print (Cell (I));
  --|     Forward (I);
  --| end loop;
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.ISEMPTY                                      .  SPEC
  -- .                                                     .
  -- .......................................................
  function IsEmpty (L: in LIST) return BOOLEAN;
  --| Purpose
  --| Return TRUE iff L is empty.
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.ISINLIST                                     .  SPEC
  -- .                                                     .
  -- .......................................................
  function IsInList (L: in LIST; Element: in ITEMTYPE) return BOOLEAN;
  --| Purpose
  --| Walks down the list L looking for an element whose value is Element.
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.LASTVALUE                                    .  SPEC
  -- .                                                     .
  -- .......................................................
  function LastValue (L: in LIST) return ITEMTYPE;
  --| Purpose
  --| Returns the last element in a list.  If the list is empty EmptyList is
  --| raised.
  --|
  --| Exceptions
  --|   EmptyList
  --|
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.LENGTH                                       .  SPEC
  -- .                                                     .
  -- .......................................................
  function Length (L: in LIST) return INTEGER;
  --| Purpose
  --| Count the number of elements in list L.
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.LENGTH                                       .  SPEC
  -- .                                                     .
  -- .......................................................
  function MakeList (E :in ITEMTYPE) return LIST;
  --| Purpose
  --| Takes in an element and returns a list.
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.MAKELISTITER                                 .  SPEC
  -- .                                                     .
  -- .......................................................
  function MakeListIter (L: in LIST) return LISTITER;
  --| Purpose
  --| This prepares a user for iteration operation over a list.  The iterater is
  --| an operation which returns successive elements of the list on successive
  --| calls to the iterator.  There needs to be a mechanism which marks the
  --| position in the list, so on successive calls to the Next operation the
  --| next item in the list can be returned.  This is the function of the
  --| MakeListIter and the type ListIter.  MakeIter just sets the Iter to the
  --| the beginning  of the list. On subsequent calls to Next the Iter
  --| is updated with each call.
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.MORE                                         .  SPEC
  -- .                                                     .
  -- .......................................................
  function More (L: in LISTITER) return BOOLEAN;
  --| Purpose
  --| Returns TRUE iff there are more elements in the list.
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.NEXT                                         .  SPEC
  -- .                                                     .
  -- .......................................................
  procedure Next (Place: in out LISTITER; Info: out ITEMTYPE);
  --| Purpose
  --| This is the iterator operation.  Given a ListIter, Next returns the
  --| current item and updates the ListIter.
  --|
  --| The iterators subprograms MakeListIter, More, and Next should be used
  --| in the following way:
  --|
  --|         L:        List;
  --|         Place:    ListIter;
  --|         Info:     SomeType;
  --|
  --|     
  --|         Place := MakeListIter(L);
  --|
  --|         while ( More(Place) ) loop
  --|               Next(Place, Info);
  --|               process each element of list L;
  --|               end loop;
  --|
  --| Exceptions (none)
  --| Notes (none)


  -- .......................................................
  -- .                                                     .
  -- .  LISTS.REPLACEHEAD                                  .  SPEC
  -- .                                                     .
  -- .......................................................
  procedure ReplaceHead (L: in out LIST; Info: in ITEMTYPE);
  --| Purpose
  --| Replaces the information in the first element in the list.  Raises
  --| EmptyList if the list is empty.
  --|
  --| Exceptions
  --|   EmptyList
  --|
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.REPLACETAIL                                  .  SPEC
  -- .                                                     .
  -- .......................................................
  procedure ReplaceTail (L: in out LIST; NewTail: in LIST);
  --| Purpose
  --| Replaces the tail of a list with a new list.  If the list whose tail
  --| is being replaced is null EmptyList is raised.
  --|
  --| Exceptions
  --|   EmptyList
  --|
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.TAIL                                         .  SPEC
  -- .                                                     .
  -- .......................................................
  function Tail (L: in LIST) return LIST;
  --| Purpose
  --| Returns a list which is the tail of the list L.  Raises EmptyList if
  --| L is empty.  If L only has one element then Tail returns the Empty
  --| list.
  --|
  --| Exceptions
  --|   EmptyList
  --|
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.CELLVALUE                                    .  SPEC
  -- .                                                     .
  -- .......................................................
  function CellValue (I :in LISTITER) return ITEMTYPE;
  --| Purpose
  --| This returns the value of the element at the position of the iterator.
  --| This is used in conjunction with Forward.
  --|
  --| Exceptions (none)
  --| Notes (none)

  -- .......................................................
  -- .                                                     .
  -- .  LISTS.EQUAL                                        .  SPEC
  -- .                                                     .
  -- .......................................................
  function Equal (List1: in LIST; List2: in LIST) return BOOLEAN;
  --| Purpose
  --| Returns true if for all elements of List1 the corresponding element
  --| of List2 has the same value.  This function uses the Equal operation
  --| provided by the user.  If one is not provided then = is used.
  --|
  --| Exceptions (none)
  --| Notes (none)

private
    type CELL;
    type LIST is access CELL;      -- pointer added by this package
                                   -- in order to make a list
    type CELL is                   -- Cell for the lists being created
         record
              Info : ITEMTYPE;
              Next : LIST;
         end record;
    type LISTITER is new LIST;     -- This prevents Lists being assigned to
                                   -- iterators and vice versa
end Lists;
