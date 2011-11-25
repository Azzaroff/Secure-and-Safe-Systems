package body Graph_Algorithms is

-- BREADTH FIRST SEARCH
procedure Breadth_First_Search(G       : in out Graph_Type;
				Source : in out Vertex_Type) is
begin
	null;
end Breadth_First_Search;

-- DEPTH FIRST SEARCH
procedure Depth_First_Search(G         : in out Graph_Type;
				Source : in out Vertex_Type) is
begin
	null;
end Depth_First_Search;


-- MINIMAL SPANNING TREE
function Minimal_Spanning_Tree(G       : in Graph_Type;
				Source : in Vertex_Type) return Graph_Type is
begin
	null;
	return G;
end Minimal_Spanning_Tree;

--SHORTEST PATH
function Shortest_Path(G  	    : in Graph_Type;
			Source      : in Vertex_Type;
			Destination : in Vertex_Type)	return Vertex_Array is
begin
	null;
	return Destination;
end Shortest_Path;

end Graph_Algorithms;
