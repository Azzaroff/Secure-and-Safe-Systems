with Mark_Graph;

generic
   with package Graph  is new Mark_Graph(<>);
package Graph_Algorithms is  
   use Graph;
   -- Marks all Vertices with Vertex_Mark'First that are reachable from 
   -- vertex "Source" using the "Breadth_First_Search" algorithm.
   -- Raises Constraint_Error if Vertex_Mark enumeration has less then two
   -- entries, or Source is not a vertex of G.
   procedure Breadth_First_Search(G      : in out Graph_Type;
				  Source : in out Vertex_Type);
   
   -- Marks all Vertices with Vertex_Mark'First that are reachable from 
   -- vertex "Source" using the "Depth_First_Search" algorithm.
   -- Raises Constraint_Error if Vertex_Mark enumeration has less then three
   -- entries, or Source is not a vertex of G.   
   procedure Depth_First_Search(G      : in out Graph_Type;
				Source : in out Vertex_Type);
   
   
   -- Returns the minimal spanning tree (MST) that includes vertex 
   -- source.
   -- Return an empty graph if Source is not a vertex of G.
   function Minimal_Spanning_Tree(G      : in Graph_Type;
				  Source : in Vertex_Type) return Graph_Type;
   
   
   -- Returns the shortest path form source to Destination using the
   -- Dijkstra's algorithm. Raises Constraint_Error if 
   -- Source or Destination is not a vertex of G. 
   function Shortest_Path(G           : in Graph_Type;
			  Source      : in Vertex_Type;
			  Destination : in Vertex_Type)	return Vertex_Array;
end Graph_Algorithms;
