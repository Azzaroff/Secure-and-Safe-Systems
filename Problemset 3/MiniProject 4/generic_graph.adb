package body generic_graph is

-- turns the graph into an empty graph without vertices and edges
   procedure Clear (Graph : in out Graph_Type) is
   tmpV : Vertex_List;
   tmpE : Edge_List;
	begin
		Graph.vertices := tmpV;
		Graph.edges := tmpE;
	end Clear;

   
   -- inserts new Vertex; raises Constraint_Error if Vertex is already there
   -- the new Vertex is unmarked
   procedure Add_Vertex (Graph  : in out Graph_Type; Vertex : in Vertex_Type) is
	cursor : Vertex_Lists.Cursor := First(Graph.vertices);
	begin
		cursor := Vertex_Lists.Find(Container => Vertex_Lists.List(Graph.vertices), Item => Vertex);
		if cursor = Vertex_Lists.No_Element then
			Graph.vertices.append(Vertex);
		end if;
	end Add_Vertex;
   
   
   -- inserts an Edge into the graph, raises Constraint error if Head or 
   -- Tail aren't already in the graph; overwrites an Edge if it already 
   -- exists (i.e., changes the weight) 
   procedure Add_Edge (Graph: in out Graph_Type;
                       Head, Tail: in Vertex_Type;
                       Weight: in Edge_Weight) is
	edge : Edge_Type := (Weight, Head, Tail);
	begin
		Graph.edges.append(edge);
	end Add_Edge;

   
   -- returns the weight of an edge; Natural'Last if the Edge doesn't exist
   function Weight_Of (Graph: Graph_Type;
		       Head, Tail: Vertex_Type) return Edge_Weight is
	cursor : Edge_Lists.Cursor := First(Graph.edges);
	elem : Edge_Type;
	begin
		while Edge_Lists.Has_Element(Cursor) loop
			elem := Edge_Lists.Element(Cursor);
			if (elem.head = Head and then elem.tail = Tail) then
				return elem.weight;
			end if;
			Edge_Lists.Next(Cursor);
		end loop;
		return Natural'Last;
	end Weight_Of;

   -- all nodes K with an edge from Vertex to K
   function Successors (Graph  : Graph_Type;
                        Vertex : Vertex_Type) return Vertex_Array is
	cursor : Edge_Lists.Cursor := First(Graph.edges);
	vertex_count : Positive := Positive(Length(Graph.vertices));
	v_array: Vertex_Array(1..vertex_count); 
	elem : Edge_Type;
	index : Positive := 1;
	begin
		while Edge_Lists.Has_Element(Cursor) loop
			elem := Edge_Lists.Element(Cursor);
			if elem.Head = Vertex then
					v_array(index) := elem.Tail;
					index := index +1;
			end if;
			Edge_Lists.Next(Cursor);
		end loop;
		return v_array;
	end Successors;
   
   -- all nodes K with an edge from K to Vertex
   function Predecessors (Graph  : Graph_Type;
                          Vertex : Vertex_Type) return Vertex_Array is
	cursor : Edge_Lists.Cursor := First(Graph.edges);
	vertex_count : Positive := Positive(Length(Graph.vertices));
	v_array: Vertex_Array(1..vertex_count); 
	elem : Edge_Type;
	index : Positive := 1;
	begin
		while Edge_Lists.Has_Element(Cursor) loop
			elem := Edge_Lists.Element(Cursor);
			if elem.Tail = Vertex then
					v_array(index) := elem.Head;
					index := index +1;
			end if;
			Edge_Lists.Next(Cursor);
		end loop;
		return v_array;
	end Predecessors;
   
   -- return all vertices in the Graph
   function All_Vertices(Graph : Graph_Type) return Vertex_Array is
	cursor : Vertex_Lists.Cursor := First(Graph.vertices);
	vertex_count : Positive := Positive(Length(Graph.vertices));
	v_array: Vertex_Array(1..vertex_count); 
	index : Positive := 1;
	begin
		while Vertex_Lists.Has_Element(Cursor) loop
			v_array(index) := Vertex_Lists.Element(Cursor);
			index := index + 1;
			Vertex_Lists.Next(Cursor);
		end loop;
		return v_array;
	end All_Vertices;

end generic_graph;
