package body Graph_Algorithms is

-- BREADTH FIRST SEARCH
procedure Breadth_First_Search(G       : in out Graph_Type;
				Source : in out Vertex_Type) is
Queue : Vertex_Array;
Queue2: Vertex_Array;
begin
	--FALSCH
	Queue := G.Successor(Source); -- just for help
	for all J : Vertex_Type in Queue loop
		for all I : Vertex_Type in Queue loop -- mark all childs
			if G.Get_Mark(G, I) /= Graph'First then
				G.Set_Mark(G, I, Mark_Graph'First);
			end if;
		end loop;
		Queue2 := Queue;
		Queue := G.Successor(J);
	end loop;
		
end Breadth_First_Search;


-- DEPTH FIRST SEARCH
procedure Depth_First_Search(G         : in out Graph_Type;
				Source : in out Vertex_Type) is
begin
	for all I : Vertex_Type in G.Successor(Source) loop
		if G.Get_Mark(G, I) /= Graph'First then
			G.Set_Mark(G, I, Mark_Graph'First);
			Depth_First_Search(G, I);
		end if;
	end loop;
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
