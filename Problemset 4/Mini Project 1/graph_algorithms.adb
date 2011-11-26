package body Graph_Algorithms is

-- BREADTH FIRST SEARCH
procedure Breadth_First_Search(G       : in out Graph_Type;
				Source : in out Vertex_Type) is
Queue 	: Mark_List.List;
cursor 	: Mark_List.Cursor;
elem	: Mark_Type;
begin
	elem := (null, Source);
	Queue.append(Source);
	cursor := First(Queue.List);
	while Queue.Has_Element(Cursor) loop -- for all elements in queue
		elem := Queue.Element(Cursor);
		for all I : Marked_Type in G.Successor(elem(Marked_Vertex)) loop -- mark all childs
			if G.Get_Mark(G, I) /= Graph'First then
				G.Set_Mark(G, I, Mark_Graph'First);
			end if;
			Queue.append(I); -- Append all Childs to queue
		end loop;
		Queue.Delete(Cursor); --delete first element of queue
		Queue.Next(Cursor);
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
