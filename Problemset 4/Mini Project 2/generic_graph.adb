package body Generic_Graph is

	 ------------------------------------------------------------------
   procedure Clear (Graph : in out Graph_Type) is
   begin
      Graph.Vertices.Clear;
      Graph.Edges.Clear;
   end Clear;

	 ------------------------------------------------------------------
   procedure Add_Vertex (Graph  : in out Graph_Type; Vertex : in Vertex_Type) is
      use type Vertex_List.Cursor;
   begin
      if Graph.Vertices.Find(Vertex) /= Vertex_List.No_Element then
	 raise Constraint_Error;
      end if;
      Graph.Vertices.Append(Vertex);
   end Add_Vertex;

	 ------------------------------------------------------------------
   procedure Add_Edge (Graph: in out Graph_Type;
                       Head, Tail: in Vertex_Type;
                       Weight: in Edge_Weight) is
      use type Edge_List.Cursor;
      use type Vertex_List.Cursor;
      Edge_Iterator : Edge_List.Cursor := Graph.Edges.First;
   begin
      -- Check for vertices
      if Graph.Vertices.Find(Head) = Vertex_List.No_Element or else
	Graph.Vertices.Find(Tail) = Vertex_List.No_Element then
	 raise Constraint_Error;
      end if;
      -- Delete edge if already there
      while Edge_Iterator /= Edge_List.No_Element loop
	 if Edge_List.Element(Edge_Iterator).Head = Head and then
	   Edge_List.Element(Edge_Iterator).Tail = Tail then
	    Graph.Edges.Delete(Edge_Iterator);
	    exit;
	 end if;
	 Edge_List.Next(Edge_Iterator);
      end loop;
      
      -- Append edge
      Graph.Edges.Append((Head, Tail, Weight));
   end Add_Edge;

   ------------------------------------------------------------------
   function Weight_Of (Graph: Graph_Type;
		       Head, Tail: Vertex_Type) return Edge_Weight is
      use type Edge_List.Cursor;
      use type Vertex_List.Cursor;
      Edge_Iterator : Edge_List.Cursor := Graph.Edges.First;
   begin
      -- Check for vertices
      if Graph.Vertices.Find(Head) = Vertex_List.No_Element or else
	Graph.Vertices.Find(Tail) = Vertex_List.No_Element then
	 raise Constraint_Error;
      end if;

      -- Delete edge if already there
      while Edge_Iterator /= Edge_List.No_Element loop
	 if Edge_List.Element(Edge_Iterator).Head = Head and then
	   Edge_List.Element(Edge_Iterator).Tail = Tail then
	    return Edge_List.Element(Edge_Iterator).Weight;
	 end if;
	 Edge_List.Next(Edge_Iterator);
      end loop;
      return Natural'Last;
   end Weight_Of;

	 ------------------------------------------------------------------
   function To_Array(Vertices : Vertex_List.List) return Vertex_Array is
      use type Vertex_List.Cursor;
      Size : Natural := Natural(Vertices.Length);
      Vertices_Array : Vertex_Array(1..Size); 
      Vertex_Iterator : Vertex_List.Cursor := Vertices.First;
   begin
      for Index in Positive'First..Size loop
	 Vertices_Array(Index) := Vertex_List.Element(Vertex_Iterator);
	 Vertex_List.Next(Vertex_Iterator);
      end loop;
      return Vertices_Array;
   end To_Array;
   
	 ------------------------------------------------------------------
   function Successors (Graph  : Graph_Type;
                        Vertex : Vertex_Type) return Vertex_Array is
      use type Edge_List.Cursor;
      use type Vertex_List.Cursor;
      Edge_Iterator : Edge_List.Cursor := Graph.Edges.First;
      Successor_List : Vertex_List.List;
   begin
      -- Check for vertex
      if Graph.Vertices.Find(Vertex) = Vertex_List.No_Element then
	 raise Constraint_Error;
      end if;
      
      while Edge_Iterator /= Edge_List.No_Element loop
	 if Edge_List.Element(Edge_Iterator).Head = Vertex then
	    Successor_List.Append(Edge_List.Element(Edge_Iterator).Tail);
	 end if;
	 Edge_List.Next(Edge_Iterator);
      end loop;
      return To_Array(Successor_List);
   end Successors;

   ------------------------------------------------------------------
   function Predecessors (Graph  : Graph_Type;
                          Vertex : Vertex_Type) return Vertex_Array is
      use type Edge_List.Cursor;
      use type Vertex_List.Cursor;
      Edge_Iterator : Edge_List.Cursor := Graph.Edges.First;
      Predecessor_List : Vertex_List.List;
   begin
      -- Check for vertex
      if Graph.Vertices.Find(Vertex) = Vertex_List.No_Element then
	 raise Constraint_Error;
      end if;
      
      while Edge_Iterator /= Edge_List.No_Element loop
	 if Edge_List.Element(Edge_Iterator).Tail = Vertex then
	    Predecessor_List.Append(Edge_List.Element(Edge_Iterator).Head);
	 end if;
	 Edge_List.Next(Edge_Iterator);
      end loop;
      
      return To_Array(Predecessor_List);
   end Predecessors;
   
	 ------------------------------------------------------------------
   function All_Vertices(Graph : Graph_Type) return Vertex_Array is
   begin
      return To_Array(Graph.Vertices);
   end All_Vertices;
end Generic_Graph;
