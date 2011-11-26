with Ada.Containers.Doubly_Linked_Lists;

package body Graph_Algorithms is

-- BREADTH FIRST SEARCH
procedure Breadth_First_Search(G       : in out Graph_Type;
				Source : in out Vertex_Type) is

package Queue_List is new Ada.Containers.Doubly_Linked_Lists(Vertex_Type);
use Queue_List;
Queue 	: List;
cursor 	: Queue_List.Cursor;
elem	: Vertex_Type;
elem2	: Vertex_Type;
begin
	elem := Source;
	Queue.append(Source);
	cursor := Queue_List.First(Queue);
	while Queue_List.Has_Element(Cursor) loop -- for all elements in queue
		elem := Queue_List.Element(Cursor);
		for I in G.Successors(elem)'Range loop -- mark all childs
			elem2 := G.Successors(elem)(I);
			if G.Get_Mark(elem2) /= Vertex_Mark'First then
				G.Set_Mark(elem2, Vertex_Mark'First);
			end if;
			Queue.append(elem2); -- Append all Childs to queue
		end loop;
		Queue.Delete(Cursor); --delete first element of queue
		Queue_List.Next(Cursor);
	end loop;
		
end Breadth_First_Search;


-- DEPTH FIRST SEARCH
procedure Depth_First_Search(G         : in out Graph_Type;
				Source : in out Vertex_Type) is
elem	: Vertex_Type;
begin
	for I in G.Successors(Source)'Range loop
		elem	:= G.Successors(Source)(I);
		if G.Get_Mark(elem) /= Vertex_Mark'First then
			G.Set_Mark(elem, Vertex_Mark'First);
			Depth_First_Search(G, elem);
		end if;
	end loop;
end Depth_First_Search;


-- MINIMAL SPANNING TREE
function Minimal_Spanning_Tree(G       : in Graph_Type;
				Source : in Vertex_Type) return Graph_Type is
Result	: Graph_Type;
begin
	return Result;
end Minimal_Spanning_Tree;

--SHORTEST PATH
function Shortest_Path(G  	    : in Graph_Type;
			Source      : in Vertex_Type;
			Destination : in Vertex_Type)	return Graphs.Vertex_Array is
begin
	return G.Successors(Source);
end Shortest_Path;

end Graph_Algorithms;
