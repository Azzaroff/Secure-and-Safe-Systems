package body generic_graph is

-- turns the graph into an empty graph without vertices and edges
   procedure Clear (Graph : in out Graph_Type) is
   tmp : Graph_Type;
	begin
		null;
	end Clear;

   
   -- inserts new Vertex; raises Constraint_Error if Vertex is already there
   -- the new Vertex is unmarked
   procedure Add_Vertex (Graph  : in out Graph_Type; Vertex : in Vertex_Type) is
	begin
		null;
	end Add_Vertex;
   
   
   -- inserts an Edge into the graph, raises Constraint error if Head or 
   -- Tail aren't already in the graph; overwrites an Edge if it already 
   -- exists (i.e., changes the weight) 
   procedure Add_Edge (Graph: in out Graph_Type;
                       Head, Tail: in Vertex_Type;
                       Weight: in Edge_Weight) is
	begin
		null;
	end Add_Edge;

   
   -- returns the weight of an edge; Natural'Last if the Edge doesn't exist
   function Weight_Of (Graph: Graph_Type;
		       Head, Tail: Vertex_Type) return Edge_Weight is
	begin
		return 0;
	end Weight_Of;

   -- all nodes K with an edge from Vertex to K
   function Successors (Graph  : Graph_Type;
                        Vertex : Vertex_Type) return Vertex_Array is
	dummy : Vertex_Array := (vertex,vertex);
	begin
		return dummy;
	end Successors;
   
   -- all nodes K with an edge from K to Vertex
   function Predecessors (Graph  : Graph_Type;
                          Vertex : Vertex_Type) return Vertex_Array is
	dummy : Vertex_Array := (vertex,vertex);
	begin
		return dummy;
	end Predecessors;
   
   -- return all vertices in the Graph
   function All_Vertices(Graph : Graph_Type) return Vertex_Array is
	vertex : vertex_type;
	dummy : Vertex_Array := (vertex,vertex);
	begin
		return dummy;
	end All_Vertices;

end generic_graph;
